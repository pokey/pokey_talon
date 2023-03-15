mode: dictation
experiment: anchor-file
-
# ^press <user.modifiers>$: key(modifiers)
# ^press <user.keys>$: key(keys)

# Everything here should call `auto_insert()` (instead of `insert()`), to preserve the state to correctly auto-capitalize/auto-space.
# (Talonscript string literals implicitly call `auto_insert`, so there's no need to wrap those)
<user.raw_prose>: auto_insert(raw_prose)
# cap: user.dictation_format_cap()
# Hyphenated variants are for Dragon.
# (no cap | no-caps): user.dictation_format_no_cap()
# (no space | no-space): user.dictation_format_no_space()
# ^cap that$: user.dictation_reformat_cap()
# ^(no cap | no-caps) that$: user.dictation_reformat_no_cap()
# ^(no space | no-space) that$: user.dictation_reformat_no_space()

# Escape, type things that would otherwise be commands
# ^escape <user.text>$: auto_insert(user.text)

# numb <user.number_string>: "{number_string}"
# numb <user.number_string> point <digit_string>:
#     "{number_string}.{digit_string}"
