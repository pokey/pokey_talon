from abc import ABC, abstractmethod
from typing import Any, Mapping, TypeVar

from talon import Context, Module, actions, app, clip

mod = Module()
ctx = Context()
ctx.matches = r"""
app: vscode
"""


class Revset(ABC):
    @abstractmethod
    def get_revset(self) -> str:
        pass


class Commitish(Revset):
    pass


class Branch(Commitish):
    @abstractmethod
    def get_branch(self) -> str:
        pass


class RevsetFunction(Revset):
    def __init__(self, name: str, *params: Revset):
        self.name = name
        self.params = params

    def get_revset(self):
        args = ", ".join([param.get_revset() for param in self.params])
        return f"{self.name}({args})"


class SelectedTextRevset(Branch):
    def get_revset(self):
        return f'"{actions.edit.selected_text()}"'

    def get_branch(self):
        return actions.edit.selected_text()


class ClipboardRevset(Branch):
    def get_revset(self):
        return f'"{actions.clip.text()}"'

    def get_branch(self):
        return actions.clip.text()


class LiteralRevset(Branch):
    def __init__(self, value: str):
        self.value = value

    def get_revset(self):
        return self.value

    def get_branch(self):
        return self.value


def create_rich_list_capture(
    mod: Module, ctx: Context, name: str, description: str, values: Mapping
):
    list_name = f"private_{name}"
    mod.list(list_name, description)
    full_list_name = f"user.{list_name}"
    ctx.lists[full_list_name] = list(values.keys())

    def capture(m) -> Any:
        f"""{description}"""
        return values[getattr(m, list_name)]

    capture.__name__ = name
    mod.capture(rule=f"{{{full_list_name}}}")(capture)


revset_marks = {
    "this": SelectedTextRevset(),
    "clip": ClipboardRevset(),
    "active": LiteralRevset("."),
    "head": LiteralRevset("."),
    "main": LiteralRevset("main()"),
}


create_rich_list_capture(
    mod,
    ctx,
    "branchless_revset_mark",
    "Marks for use with revset grammar such as 'active' or 'this'",
    revset_marks,
)
create_rich_list_capture(
    mod,
    ctx,
    "branchless_commitish",
    "Commits for use with revset grammar such as 'active' or 'this'",
    revset_marks,
)
create_rich_list_capture(
    mod,
    ctx,
    "branchless_branch",
    "Branches for use with revset grammar such as 'active' or 'this'",
    revset_marks,
)


mod.list("branchless_revset_modifier", "Functions for use in modifier grammar")
ctx.lists["user.branchless_revset_modifier"] = {
    "just": "",
    "stack": "stack",
    "tail": "descendants",
}

mod.list("branchless_simple_command", "Simple branches command that accepts a revset")
ctx.lists["user.branchless_simple_command"] = {
    "auto branch": "custom.autoBranch",
    "abandon": "hide",
    "log": "smartlogRevset",
}


@mod.capture(rule="[{user.branchless_revset_modifier}] <user.branchless_revset_mark>")
def branchless_revset(m) -> Revset:
    ret = m.branchless_revset_mark

    try:
        return RevsetFunction(m.branchless_revset_modifier, ret)
    except AttributeError:
        return ret


@mod.capture(rule="{user.branchless_revset_modifier} <user.branchless_revset_mark>")
def branchless_revset_required_modifier(m) -> Revset:
    return RevsetFunction(m.branchless_revset_modifier, m.branchless_revset_mark)


class Destination(ABC):
    @abstractmethod
    def get_revset(self, source: Revset) -> str:
        pass

    def get_revset_for_move(self, source: Revset) -> str:
        return self.get_revset(source)


class DestinationCommitish(Destination):
    def __init__(self, commitish: Commitish):
        self.commitish = commitish

    def get_revset(self, source: Revset):
        return self.commitish.get_revset()


class DestinationRelativeAncestor(Destination):
    def __init__(self, count: int):
        self.count = count

    def get_revset(self, source: Revset):
        source_value = source.get_revset()
        return (
            f"ancestors.nth(roots(range({source_value}, {source_value})), {self.count})"
        )

    def get_revset_for_move(self, source: Revset) -> str:
        return f"parents({self.get_revset(source)})"


class DestinationRelativeDescendant(Destination):
    def __init__(self, count: int):
        self.count = count

    def get_revset(self, source: Revset):
        source_value = source.get_revset()
        revset_head = f"heads(range({source_value}, {source_value}))"
        for _ in range(self.count):
            revset_head = f"children({revset_head})"
        return revset_head


@mod.capture(rule="to <user.branchless_commitish>")
def branchless_destination_commitish(m) -> DestinationCommitish:
    return DestinationCommitish(m.branchless_commitish)


@mod.capture(rule="(forward | back) <number_small>")
def branchless_destination_relative(m) -> Destination:
    return (
        DestinationRelativeAncestor(m.number_small)
        if m[0] == "back"
        else DestinationRelativeDescendant(m.number_small)
    )


@mod.capture(
    rule="<user.branchless_destination_commitish> | <user.branchless_destination_relative>"
)
def branchless_destination(m) -> Destination:
    return m[0]


@mod.action_class
class Actions:
    def branchless_move_exact(
        exact_source: Revset, destination: Destination, merge: bool = False
    ):
        """git-branchless move a set of commits"""
        actions.user.vscode_with_plugin(
            "git-branchless.move.exact",
            {
                "exact": exact_source.get_revset(),
                "destination": destination.get_revset_for_move(exact_source),
                "noConfirmation": True,
                "merge": bool(merge),
            },
        )

    def branchless_move_source(
        source: Commitish, destination: Destination, merge: bool = False
    ):
        """git-branchless move a set of commits"""
        actions.user.vscode_with_plugin(
            "git-branchless.move.source",
            {
                "source": source.get_revset(),
                "destination": destination.get_revset_for_move(source),
                "noConfirmation": True,
                "merge": bool(merge),
            },
        )

    def branchless_simple_command(command_id: str, revset: Revset):
        """git-branchless automatically create a branch based on commit name for a set of commits."""
        actions.user.vscode_with_plugin(
            f"git-branchless.{command_id}",
            {
                "revset": revset.get_revset(),
            },
        )

    def branchless_submit_revset(revset: Revset, create: bool = False):
        """git-branchless automatically create a branch based on commit name for a set of commits."""
        actions.user.vscode_with_plugin(
            "git-branchless.submitRevset",
            {
                "revset": revset.get_revset(),
                "create": bool(create),
            },
        )

    def branchless_move_branch(branch: Branch, destination: Destination):
        """git-branchless move branch"""
        actions.user.vscode_with_plugin(
            "git-branchless.custom.moveBranch",
            {
                "branch": branch.get_branch(),
                "destination": destination.get_revset(branch),
            },
        )

    def branchless_switch_to_commit(destination: Destination):
        """git-branchless move branch"""
        actions.user.vscode_with_plugin(
            "git-branchless.custom.switchToCommit",
            {
                "destination": destination.get_revset(LiteralRevset(".")),
            },
        )

    def branchless_reset_mixed(source: Commitish, destination: Destination):
        """git-branchless move a set of commits"""
        actions.user.vscode_with_plugin(
            "git-branchless.custom.reset",
            {
                "source": source.get_revset(),
                "destination": destination.get_revset(source),
                "type": "mixed",
            },
        )
