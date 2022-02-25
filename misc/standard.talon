#(jay son | jason ): "json"
#(http | htp): "http"
#tls: "tls"
#M D five: "md5"
#word (regex | rejex): "regex"
#word queue: "queue"
#word eye: "eye"
#word iter: "iter"
#word no: "NULL"
#word cmd: "cmd"
#word dup: "dup"
#word shell: "shell".
zoom in: edit.zoom_in()
zoom out: edit.zoom_out()
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
padding:
	insert("  ") 
	key(left)
pour: edit.line_insert_down()
drink: edit.line_insert_up()

slow mode: mode.enable("user.slow")

emoji scout [<user.text>]:
	key(cmd-ctrl-space)
	sleep(200ms)
	insert(user.text or "")

dictate [<user.prose>]$:
    auto_insert(prose or "")
    mode.disable("sleep")
    mode.disable("command")
    mode.enable("dictation")
    user.code_clear_language_mode()
    mode.disable("user.gdb")

dictate <user.prose> halt:
    auto_insert(prose or "")

show numbers: key(cmd-ctrl-alt-f)

move overlay: user.move_overlay()
ring save: user.ring_save()

additional word:
    user.switcher_focus("Code")
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