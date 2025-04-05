tag: browser
win.title: /sketch coding assistant/
-

# Process arbitrary prose when spoken and insert it directly
# This allows dictation-like behavior without switching to dictation mode
^<user.raw_prose>$: user.dictation_insert(raw_prose)
