collapse: edit.zoom_in()
expand: edit.zoom_out()
zoom reset: edit.zoom_reset()
scroll up: edit.page_up()
scroll down: edit.page_down()
copy that: edit.copy()
cut that: edit.cut()
(pace | paste) that: edit.paste()
show clip:
    key(cmd-shift-v)
    sleep(100ms)
(pace | paste) <user.ordinals_small>:
    key(cmd-shift-v)
    sleep(100ms)
    insert("{user.ordinals_small}")
    sleep(100ms)
(pace | paste) rough <number_small>:
    key(cmd-shift-v)
    sleep(100ms)
    key("alt-{number_small}")
(undo that | nope): edit.undo()
(redo that | yes indeed): edit.redo()
paste match: edit.paste_match_style()
disk: edit.save()
disk oliver: edit.save_all()
padding: user.insert_between(" ", " ")
pour: edit.line_insert_down()
drink: edit.line_insert_up()

slow mode: mode.enable("user.slow")

emoji scout [<user.text>]:
    key(cmd-ctrl-space)
    sleep(200ms)
    insert(user.text or "")

dictate [<phrase>]$:
    mode.enable("dictation")
    user.parse_phrase(phrase or "")

^halt: mode.disable("dictation")

dictate <user.prose> halt: auto_insert(prose or "")

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

hey siri$:
    user.sleep_all()
    key(ctrl-alt-cmd-s)

alphabet: "abcdefghijklmnopqrstuvwxyz"
