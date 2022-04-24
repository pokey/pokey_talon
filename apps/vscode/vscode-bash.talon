mode: command
and mode: user.bash
mode: command
and mode: user.auto_lang
and code.language: bash
app: vscode
-
run clear: user.vscode("bashbook.cell.executeAndClear")
git clone: user.cursorless_insert_snippet("gitClone")
katy clip:
    insert("cd ")
    edit.paste()
{user.quick_shell_command}: user.run_shell_command(quick_shell_command)

git reset hard: "git reset --hard "
git reset hard {user.commitish}: "git reset --hard {commitish}"
git move: "git branch -m "
