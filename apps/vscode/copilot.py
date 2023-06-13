from talon import Context, Module, actions, app, clip

mod = Module()
ctx = Context()

ctx.matches = r"""
app: vscode
"""

mod.list(
    "copilot_slash_command", "Slash commands that can be used with copilot, e.g. /test"
)
ctx.lists["user.copilot_slash_command"] = ["test", "fix", "explain"]

mod.list("makeshift_destination", "Cursorless makeshift destination")
ctx.lists["user.makeshift_destination"] = {
    "to": "clearAndSetSelection",
    "after": "editNewLineAfter",
    "before": "editNewLineBefore",
}


@mod.action_class
class Actions:
    def copilot_inline_chat(
        copilot_slash_command: str, cursorless_target: dict, prose: str
    ):
        """Initiate copilot inline chat session"""
        actions.user.cursorless_command("setSelection", cursorless_target)
        actions.user.vscode("interactiveEditor.start")
        has_content = copilot_slash_command or prose
        if has_content:
            actions.sleep("50ms")
        if copilot_slash_command:
            actions.insert(f"/{copilot_slash_command} ")
        if prose:
            actions.insert(prose)
        if has_content:
            actions.key("enter")

    def copilot_chat(prose: str):
        """Initiate copilot chat session"""
        actions.user.vscode("workbench.panel.chat.view.copilot.focus")
        if prose:
            actions.sleep("50ms")
            actions.insert(prose)
            actions.key("enter")

    def copilot_bring_code_block(index: int):
        """Bring a copilot chat suggestion to the cursor"""
        actions.user.vscode("workbench.panel.chat.view.copilot.focus")
        action = (
            "workbench.action.chat.previousCodeBlock"
            if index < 0
            else "workbench.action.chat.nextCodeBlock"
        )
        count = index + 1 if index >= 0 else abs(index)
        for _ in range(count):
            actions.user.vscode(action)
        actions.user.vscode("workbench.action.chat.insertCodeBlock")
        actions.user.vscode("workbench.action.chat.insertCodeBlock")
