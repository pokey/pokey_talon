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
    def get_value(self) -> str:
        pass


class Commitish(ABC):
    @abstractmethod
    def get_value(self) -> str:
        pass


class RevsetFunction(Revset):
    def __init__(self, name: str, *params: Revset):
        self.name = name
        self.params = params

    def get_value(self):
        args = ", ".join([param.get_value() for param in self.params])
        return f"{self.name}({args})"


class SelectedTextRevset(Revset, Commitish):
    def get_value(self):
        return f'"{actions.edit.selected_text()}"'


class ClipboardRevset(Revset, Commitish):
    def get_value(self):
        return f'"{actions.clip.text()}"'


class LiteralRevset(Revset, Commitish):
    def __init__(self, value: str):
        self.value = value

    def get_value(self):
        return self.value


def create_rich_list_capture(
    mod: Module, ctx: Context, name: str, description: str, values: Mapping
):
    list_name = f"private_{name}"
    mod.list(list_name, description)
    full_list_name = f"user.{list_name}"
    ctx.lists[full_list_name] = list(values.keys())

    def capture(m) -> Any:
        return values[getattr(m, list_name)]

    capture.__name__ = name
    mod.capture(rule=f"{{{full_list_name}}}")(capture)


revset_marks = {
    "this": SelectedTextRevset(),
    "clip": ClipboardRevset(),
    "active": LiteralRevset("head"),
    "main": LiteralRevset("main()"),
}

create_rich_list_capture(
    mod,
    ctx,
    "revset_mark",
    "Marks for use with revset grammar such as 'active' or 'this'",
    revset_marks,
)
create_rich_list_capture(
    mod,
    ctx,
    "commitish",
    "Commits for use with revset grammar such as 'active' or 'this'",
    revset_marks,
)


mod.list("revset_modifier", "Functions for use in modifier grammar")
ctx.lists["user.revset_modifier"] = {"stack": "stack", "tail": "descendants"}


@mod.capture(rule="[{user.revset_modifier}] <user.revset_mark>")
def revset(m) -> Revset:
    ret = m.revset_mark

    try:
        return RevsetFunction(m.revset_modifier, ret)
    except AttributeError:
        return ret


@mod.action_class
class Actions:
    def branchless_move_exact(exact: Revset, destination: Commitish):
        """git-branchless move"""
        actions.user.vscode_with_plugin(
            "git-branchless.move.exact",
            {
                "exact": exact.get_value(),
                "destination": destination.get_value(),
                "noConfirmation": True,
            },
        )

    def branchless_autobranch(revset: Revset):
        """git-branchless move"""
        actions.user.vscode_with_plugin(
            "git-branchless.custom.autoBranch",
            {
                "revset": revset.get_value(),
            },
        )
