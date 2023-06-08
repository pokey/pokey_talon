import json
import re
from os.path import expanduser
from pathlib import Path

from talon import Context, Module, actions, app, clip

is_mac = app.platform == "mac"

ctx = Context()
mac_ctx = Context()
mod = Module()
mod.apps.vscode = """
os: mac
and app.bundle: com.microsoft.VSCode
os: mac
and app.bundle: com.microsoft.VSCodeInsiders
os: mac
and app.bundle: com.visualstudio.code.oss
"""
mod.apps.vscode = """
os: linux
and app.name: Code
os: linux
and app.name: code-oss
os: linux
and app.name: code-insiders
os: linux
and app.name: VSCodium
os: linux
and app.name: Codium
"""
mod.apps.vscode = """
os: windows
and app.name: Visual Studio Code
os: windows
and app.name: Visual Studio Code Insiders
os: windows
and app.name: Visual Studio Code - Insiders
os: windows
and app.exe: Code.exe
os: windows
and app.exe: Code-Insiders.exe
os: windows
and app.name: VSCodium
os: windows
and app.exe: VSCodium.exe
"""

ctx.matches = r"""
app: vscode
"""
mac_ctx.matches = r"""
os: mac
app: vscode
"""

mod.list("branchless_command", "A command to use with branchless that expects a commit")

ctx.lists["user.branchless_command"] = {
    "git push stack this": "Git push commit stack",
    "git sink this": "Git sync commit",
    "git ditch branch this": "Git delete branch",
    "git ditch branch this force": "Git delete branch force",
    "pop branch this": "Git switch to commit",
}


@ctx.action_class("app")
class AppActions:
    # talon app actions
    def tab_open():
        actions.user.vscode("workbench.action.files.newUntitledFile")

    def tab_close():
        actions.user.vscode("workbench.action.closeActiveEditor")

    def tab_next():
        actions.user.vscode("workbench.action.nextEditorInGroup")

    def tab_previous():
        actions.user.vscode("workbench.action.previousEditorInGroup")

    def tab_reopen():
        actions.user.vscode("workbench.action.reopenClosedEditor")

    def window_close():
        actions.user.vscode("workbench.action.closeWindow")

    def window_open():
        actions.user.vscode("workbench.action.newWindow")


@ctx.action_class("code")
class CodeActions:
    # talon code actions
    def toggle_comment():
        actions.user.vscode("editor.action.commentLine")


@ctx.action_class("edit")
class EditActions:
    # talon edit actions
    def indent_more():
        actions.user.vscode("editor.action.indentLines")

    def indent_less():
        actions.user.vscode("editor.action.outdentLines")

    def save_all():
        actions.user.vscode("workbench.action.files.saveAll")

    def find(text=None):
        if is_mac:
            actions.key("cmd-f")
        else:
            actions.key("ctrl-f")
        if text is not None:
            actions.insert(text)

    def line_swap_up():
        actions.key("alt-up")

    def line_swap_down():
        actions.key("alt-down")

    def line_clone():
        actions.key("shift-alt-down")

    def jump_line(n: int):
        actions.user.vscode("workbench.action.gotoLine")
        actions.insert(str(n))
        actions.key("enter")
        actions.edit.line_start()

    def line_insert_down():
        actions.user.vscode_and_wait("editor.action.insertLineAfter")

    def line_insert_up():
        actions.user.vscode_and_wait("editor.action.insertLineBefore")

    def save():
        actions.key("cmd-s")
        actions.sleep("50ms")


@mac_ctx.action_class("edit")
class EditActions:
    def select_line(n: int = None):
        # NB: this prevents opening a split when you're quick picking a file
        actions.key("ctrl-e cmd-shift-left")


@ctx.action_class("win")
class WinActions:
    def filename():
        title = actions.win.title()
        # this doesn't seem to be necessary on VSCode for Mac
        # if title == "":
        #    title = ui.active_window().doc

        if is_mac:
            result = title.split(" — ")[0]
        else:
            result = title.split(" - ")[0]

        if "." in result:
            return result

        return ""


@mod.action_class
class Actions:
    def vscode_terminal(number: int):
        """Activate a terminal by number"""
        actions.user.vscode(f"workbench.action.terminal.focusAtIndex{number}")

    def change_setting(setting_name: str, setting_value: any):
        """
        Changes a VSCode setting by name

        Args:
            setting_name (str): The name of the setting
            setting_value (any): The new value.  Will be JSON encoded
        """
        original_settings_path = Path(
            expanduser("~/Library/Application Support/Code/User/settings.json")
        )
        original_settings = original_settings_path.read_text()
        regex = re.compile(rf'^(\s*)"{setting_name}": .*[^,](,?)$', re.MULTILINE)
        new_settings = regex.sub(
            rf'\1"{setting_name}": {json.dumps(setting_value)}\2', original_settings
        )
        original_settings_path.write_text(new_settings)

    def set_zoom_level(level: int):
        """Set zoom level"""
        actions.user.change_setting("window.zoomLevel", level)

    def command_palette():
        """Show command palette"""
        actions.key("ctrl-shift-p")

    def vscode_language_id() -> str:
        """Returns the vscode language id of the current programming language"""

    def copy_command_id():
        """Copy the command id of the focused menu item"""
        actions.key("tab:2 enter")
        actions.sleep("750ms")
        json_text = actions.edit.selected_text()
        command_id = json.loads(json_text)["command"]
        actions.app.tab_close()
        clip.set_text(command_id)

    def git_commit(text: str):
        """Git commit"""
        actions.user.vscode("git.commitStaged")
        actions.sleep("500ms")
        actions.user.insert_formatted(text, "CAPITALIZE_FIRST_WORD")

    def cursorless_record_navigation_test():
        """Run cursorless Record navigation test"""
        actions.user.vscode_with_plugin(
            "cursorless.recordTestCase", {"isHatTokenMapTest": True}
        )

    def cursorless_record_error_test():
        """Record cursorless record error test"""
        actions.user.vscode_with_plugin(
            "cursorless.recordTestCase", {"recordErrors": True}
        )

    def cursorless_record_highlights_test():
        """Record cursorless record error test"""
        actions.user.vscode_with_plugin(
            "cursorless.recordTestCase", {"isDecorationsTest": True}
        )

    def cursorless_record_that_mark_test():
        """Record cursorless record error test"""
        actions.user.vscode_with_plugin(
            "cursorless.recordTestCase", {"captureFinalThatMark": True}
        )

    # From https://github.com/AndreasArvidsson/andreas-talon/blob/1f48ae59452004d2266aad908b301f93b262f875/apps/vscode/vscode.py#L382-L387
    def vscode_add_missing_imports():
        """Add all missing imports"""
        actions.user.vscode_with_plugin(
            "editor.action.sourceAction",
            {"kind": "source.addMissingImports", "apply": "first"},
        )


@mac_ctx.action_class("user")
class MacUserActions:
    def command_palette():
        actions.key("cmd-shift-p")


@ctx.action_class("user")
class UserActions:
    # splits.py support begin
    def split_clear_all():
        actions.user.vscode("workbench.action.editorLayoutSingle")

    def split_clear():
        actions.user.vscode("workbench.action.joinTwoGroups")

    def split_flip():
        actions.user.vscode("workbench.action.toggleEditorGroupLayout")

    def split_maximize():
        actions.user.vscode("workbench.action.maximizeEditor")

    def split_reset():
        actions.user.vscode("workbench.action.evenEditorWidths")

    def split_last():
        actions.user.vscode("workbench.action.focusLeftGroup")

    def split_next():
        actions.user.vscode_and_wait("workbench.action.navigateEditorGroups")

    def split_window_down():
        actions.user.vscode("workbench.action.moveEditorToBelowGroup")

    def split_window_horizontally():
        actions.user.vscode("workbench.action.splitEditorOrthogonal")

    def split_window_left():
        actions.user.vscode("workbench.action.moveEditorToLeftGroup")

    def split_window_right():
        actions.user.vscode("workbench.action.moveEditorToRightGroup")

    def split_window_up():
        actions.user.vscode("workbench.action.moveEditorToAboveGroup")

    def split_window_vertically():
        actions.user.vscode("workbench.action.splitEditor")

    def split_window():
        actions.user.vscode("workbench.action.splitEditor")

    # splits.py support end

    # multiple_cursor.py support begin
    # note: vscode has no explicit mode for multiple cursors
    def multi_cursor_add_above():
        actions.user.vscode("editor.action.insertCursorAbove")

    def multi_cursor_add_below():
        actions.user.vscode("editor.action.insertCursorBelow")

    def multi_cursor_add_to_line_ends():
        actions.user.vscode("editor.action.insertCursorAtEndOfEachLineSelected")

    def multi_cursor_disable():
        actions.key("escape")

    def multi_cursor_enable():
        actions.skip()

    def multi_cursor_select_all_occurrences():
        actions.user.vscode("editor.action.selectHighlights")

    def multi_cursor_select_fewer_occurrences():
        actions.user.vscode("cursorUndo")

    def multi_cursor_select_more_occurrences():
        actions.user.vscode("editor.action.addSelectionToNextFindMatch")

    def multi_cursor_skip_occurrence():
        actions.user.vscode("editor.action.moveSelectionToNextFindMatch")

    # snippet.py support begin
    def snippet_search(text: str):
        actions.user.vscode("editor.action.insertSnippet")
        actions.insert(text)

    def snippet_insert(text: str):
        """Inserts a snippet"""
        actions.user.vscode_with_plugin_and_wait(
            "editor.action.insertSnippet",
            {"langId": actions.user.vscode_language_id(), "name": text},
        )

    def snippet_create():
        """Triggers snippet creation"""
        actions.user.vscode("workbench.action.openSnippets")

    # snippet.py support end

    def tab_jump(number: int):
        if number < 10:
            if is_mac:
                actions.user.vscode_with_plugin(
                    f"workbench.action.openEditorAtIndex{number}"
                )
            else:
                actions.key(f"alt-{number}")
        else:
            actions.user.vscode_with_plugin(
                "workbench.action.openEditorAtIndex", number
            )

    def tab_final():
        if is_mac:
            actions.user.vscode("workbench.action.lastEditorInGroup")
        else:
            actions.key("alt-0")

    # splits.py support begin
    def split_number(index: int):
        """Navigates to a the specified split"""
        if index < 9:
            if is_mac:
                actions.key(f"cmd-{index}")
            else:
                actions.key(f"ctrl-{index}")

    # splits.py support end

    # find_and_replace.py support begin

    def find(text: str):
        """Triggers find in current editor"""
        if is_mac:
            actions.key("cmd-f")
        else:
            actions.key("ctrl-f")

        if text:
            actions.insert(text)

    def find_next():
        actions.user.vscode("editor.action.nextMatchFindAction")

    def find_previous():
        actions.user.vscode("editor.action.previousMatchFindAction")

    def find_everywhere(text: str):
        """Triggers find across project"""
        if is_mac:
            actions.key("cmd-shift-f")
        else:
            actions.key("ctrl-shift-f")

        if text:
            actions.insert(text)

    def find_toggle_match_by_case():
        """Toggles find match by case sensitivity"""
        if is_mac:
            actions.key("alt-cmd-c")
        else:
            actions.key("alt-c")

    def find_toggle_match_by_word():
        """Toggles find match by whole words"""
        if is_mac:
            actions.key("cmd-alt-w")
        else:
            actions.key("alt-w")

    def find_toggle_match_by_regex():
        """Toggles find match by regex"""
        if is_mac:
            actions.key("cmd-alt-r")
        else:
            actions.key("alt-r")

    def replace(text: str):
        """Search and replaces in the active editor"""
        if is_mac:
            actions.key("alt-cmd-f")
        else:
            actions.key("ctrl-h")

        if text:
            actions.insert(text)

    def replace_everywhere(text: str):
        """Search and replaces in the entire project"""
        if is_mac:
            actions.key("cmd-shift-h")
        else:
            actions.key("ctrl-shift-h")

        if text:
            actions.insert(text)

    def replace_confirm():
        """Confirm replace at current position"""
        if is_mac:
            actions.key("shift-cmd-1")
        else:
            actions.key("ctrl-shift-1")

    def replace_confirm_all():
        """Confirm replace all"""
        if is_mac:
            actions.key("cmd-enter")
        else:
            actions.key("ctrl-alt-enter")

    def select_previous_occurrence(text: str):
        actions.edit.find(text)
        actions.sleep("100ms")
        actions.key("shift-enter esc")

    def select_next_occurrence(text: str):
        actions.edit.find(text)
        actions.sleep("100ms")
        actions.key("esc")

    def select_next_token():
        actions.edit.find("")
        actions.key("enter")
        actions.key("enter")
        actions.key("esc")

    def run_shell_command(shell_command: str):
        """Run a shell command"""
        # FIXME: Only do it this way if we are in a bash book
        actions.edit.select_all()
        actions.edit.cut()
        actions.insert(shell_command)
        actions.user.vscode("bashbook.cell.executeAndClear")

    # find_and_replace.py support end


python_ctx = Context()
python_ctx.matches = r"""
app: vscode
mode: user.python
mode: user.auto_lang
and code.language: python
"""


@python_ctx.action_class("user")
class PythonActions:
    def vscode_language_id() -> str:
        return "python"


typescript_ctx = Context()
typescript_ctx.matches = r"""
app: vscode
mode: user.typescript
mode: user.auto_lang
and code.language: typescript
"""


@typescript_ctx.action_class("user")
class TypescriptActions:
    def vscode_language_id() -> str:
        return "typescript"


mod.list("language_id", "language id")
ctx.lists["user.language_id"] = {
    "bash": "bash",
    "html": "html",
    "jason": "json",
    "java": "java",
    "lay tech": "tex",
    "markdown": "markdown",
    "python": "python",
    "ruby": "ruby",
    "rust": "rust",
    "scala": "scala",
    "text": "plaintext",
    "typescript": "typescript",
    "javascript": "javascript",
}
