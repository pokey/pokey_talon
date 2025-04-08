from talon import Module, actions

mod = Module()


@mod.action_class
class Actions:
    def focus_talon_project():
        """
        Focus the Talon project in VS Code.
        """
        actions.user.system_command("code /Users/pokey/src/pokey-talon.code-workspace")
        actions.sleep("250ms")
