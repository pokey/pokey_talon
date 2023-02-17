app: davinci_resolve
mode: command
-
# parrot(postalveolar_click): key(cmd-b)
# parrot(dental_click): key(cmd-b)
parrot(labiodental_click): key(space)
parrot(sibilant): key(shift-left)
parrot(lateral_click): key(cmd-b)

da vinci mode:
    mode.disable("sleep")
    mode.disable("command")
    mode.enable("user.davinci_resolve")

sprint: key(shift-l)
give it up: key(cmd-shift-a)
ditch clip: key(left shift-v shift-backspace)
link clips: key(cmd-alt-l)
