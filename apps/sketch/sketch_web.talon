tag: browser
win.title: /sketch coding assistant/
-

# Process arbitrary prose when spoken and insert it directly
# This allows dictation-like behavior without switching to dictation mode
<user.prose>$: user.dictation_insert(prose)
<user.prose> {user.phrase_ender}:
    user.dictation_insert(prose)
    key(phrase_ender)