mode: user.sketch
and not mode: sleep
tag: browser
win.title: /sketch coding assistant/
-

# Process arbitrary prose when spoken and insert it directly
# This allows dictation-like behavior without switching to dictation mode
<user.prose>: user.dictation_insert(prose)
boom: key(. space)
clap$: key(enter)
