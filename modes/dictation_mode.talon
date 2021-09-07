mode: dictation
-
^press <user.keys>$: key("{keys}")

# Everything here should call auto_insert to preserve the state to correctly auto-capitalize/auto-space.
<user.prose>: auto_insert(prose)
new line: "\n"
new paragraph: "\n\n"
cap <user.word>:
    result = user.formatted_text(word, "CAPITALIZE_FIRST_WORD")
    auto_insert(result)
    
# Escape, type things that would otherwise be commands
^escape <user.text>$:
    auto_insert(user.text)

numb <user.number_string>: "{number_string}"
numb <user.number_string> point <digit_string>: "{number_string}.{digit_string}"

halt [<phrase>]$:
    mode.disable("sleep")
    mode.disable("dictation")
    mode.enable("command")
    user.parse_phrase(phrase or "")