import os
import shutil
from pathlib import Path

from talon import Module, actions

mod = Module()


def get_prompt_dir() -> Path:
    workspace_folders = actions.user.run_rpc_command_get("andreas.getWorkspaceFolders")

    if workspace_folders:
        return Path(workspace_folders[0])
    else:
        return Path("/tmp")


prompt_file: Path | None = None


@mod.action_class
class Actions:
    def prompt_draft():
        """Open a new prompt draft"""
        global prompt_file
        actions.user.focus_vscode()
        prompt_file = get_prompt_dir() / ".PROMPT_DRAFT.md"
        prompt_file.touch()
        actions.user.run_rpc_command("commands.openFolder", str(prompt_file))
        actions.sleep("250ms")

    def prompt_save():
        """Save the prompt to clipboard and backup the file"""
        if prompt_file is None:
            raise RuntimeError("Prompt draft not open")
        actions.user.run_rpc_command("workbench.action.focusActiveEditorGroup")
        # Copy content to clipboard
        actions.edit.select_all()
        actions.edit.copy()

        delete_prompt_file(prompt_file)

    def prompt_discard():
        """Discard the prompt draft without saving"""
        if prompt_file is None:
            raise RuntimeError("Prompt draft not open")

        delete_prompt_file(prompt_file)


def delete_prompt_file(path: Path):
    actions.edit.save()
    actions.app.tab_close()

    # Create backup of the current file
    prompt_backup = "/tmp/PROMPT_DRAFT.md"

    # If the file exists, create a backup
    if os.path.exists(path):
        # Remove old backup if it exists
        if os.path.exists(prompt_backup):
            os.remove(prompt_backup)
        # Create new backup
        shutil.move(path, prompt_backup)
