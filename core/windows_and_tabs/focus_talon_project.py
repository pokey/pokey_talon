from talon import Module, actions

mod = Module()

@mod.action_class
class Actions:
    def focus_talon_project():
        """
        Focus the Talon project in VS Code.
        """
        # Focus VS Code
        actions.user.switcher_focus("Code")
        actions.sleep("300ms")
        
        # Open recent projects
        actions.user.vscode("workbench.action.openRecent")
        actions.sleep("250ms")
        
        # Select pokey-talon project
        actions.insert("pokey-talon")
        actions.key("enter")
        actions.sleep("250ms")