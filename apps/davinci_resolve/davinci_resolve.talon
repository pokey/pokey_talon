app: davinci_resolve
mode: command
-
parrot(dental_click): key(shift-left:3)
parrot(labiodental_click): key(space)
parrot(lateral_click): key(cmd-b)
parrot(sibilant_low): edit.zoom_out()
parrot(sibilant_high): edit.zoom_in()

sprint: key(shift-l)
reverse: key(j)
give it up: key(cmd-shift-a)
ditch clip: key(shift-v shift-backspace)
ditch left:
    key(left)
    sleep(200ms)
    key(shift-v shift-backspace)
link clips: key(cmd-alt-l)
ripple cut: key(cmd-shift-x)
paste insert: key(cmd-shift-v)
