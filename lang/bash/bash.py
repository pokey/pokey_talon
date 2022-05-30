from talon import Context, Module, actions

mod = Module()
ctx = Context()
ctx.matches = r"""
mode: user.bash
mode: user.auto_lang
and code.language: bash
"""
# tbd

mod.list(
    "quick_shell_command",
    "Shell commands that should run immediately rather than leaving the command line there to edit",
)

ctx.lists["user.quick_shell_command"] = {
    "katy up": "cd .. && pwd",
    "printer": "pwd",
}

mod.list(
    "commitish", "Something that can be recursively dereferenced to a commit object"
)

ctx.lists["user.commitish"] = {
    "last": "head~",
    "main": "main",
    "origin main": "origin/main",
}


@mod.action_class
class Actions:
    def run_shell_command(shell_command: str):
        """Run a shell command"""
        actions.insert(shell_command)
        actions.key("enter")
