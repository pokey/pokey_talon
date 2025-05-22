slow mode: mode.enable("user.slow")

dictate [<phrase>]$:
    mode.enable("dictation")
    user.parse_phrase(phrase or "")

^(halt | halter): mode.disable("dictation")

dictate <user.prose> (halt | halter): auto_insert(prose or "")

show numbers: key(cmd-ctrl-alt-f)

move overlay: user.move_overlay()
ring save: user.ring_save()

additional word:
    user.desktop(2)
    user.switcher_launch("/Applications/Visual Studio Code.app")
    sleep(200ms)
    user.vscode("workbench.action.openRecent")
    sleep(50ms)
    insert("pokey-talon")
    key(enter)
    sleep(250ms)
    user.vscode("workbench.action.quickOpen")
    sleep(200ms)
    insert("additional_words")
    sleep(300ms)
    key(enter)
    sleep(200ms)
    edit.file_end()
    edit.line_insert_down()

then: skip()
work focus: user.run_shortcut("Set work focus")
clear focus: user.run_shortcut("Turn Do Not Disturb Off")
theme dog: user.run_shortcut("Toggle dark mode")

hey siri$:
    user.sleep_all()
    key(ctrl-alt-cmd-s)

alphabet: "abcdefghijklmnopqrstuvwxyz"

bold dev log:
    user.system_command("code /Users/pokey/src/bold/devlog/pokey/$(date +%Y-%m-%d).md")
    sleep(250ms)
sketch dev this:
    text = edit.selected_text()
    clip.set_text(text)
    user.system_command("code ~/src/spaghetti")
    user.run_rpc_command("workbench.action.tasks.runTask", "sketch dev in worktree")
sketch dev clip:
    user.system_command("code ~/src/spaghetti")
    user.run_rpc_command("workbench.action.tasks.runTask", "sketch dev in worktree")

bookmark link clip:
    user.system_command("code ~/notes")
    user.run_rpc_command("workbench.action.tasks.runTask", "Add note for URL")

bookmark link this:
    edit.copy()
    user.system_command("code ~/notes")
    user.run_rpc_command("workbench.action.tasks.runTask", "Add note for URL")
