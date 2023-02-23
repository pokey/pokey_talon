app: davinci_resolve
mode: command
-
parrot(dental_click): key(shift-left:3)
parrot(labiodental_click): key(space)
parrot(lateral_click): key(cmd-b)
parrot(sibilant_low): edit.zoom_out()
parrot(sibilant_high): edit.zoom_in()
# parrot(postalveolar_click): key(cmd-b)
# parrot(sibilant): key(shift-left)

da vinci mode:
    mode.disable("sleep")
    mode.disable("command")
    mode.enable("user.davinci_resolve")

sprint: key(shift-l)
give it up: key(cmd-shift-a)
ditch clip: key(left shift-v shift-backspace)
link clips: key(cmd-alt-l)
