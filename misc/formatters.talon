#provide both anchored and unachored commands via 'over'
phrase <user.text>$: user.insert_formatted(text, "NOOP")
phrase <user.text> {user.phrase_ender}:
    user.insert_formatted(text, "NOOP")
    key(phrase_ender)
{user.prose_formatter} <user.prose>$: user.insert_formatted(prose, prose_formatter)
{user.prose_formatter} <user.prose> {user.phrase_ender}:
    user.insert_formatted(prose, prose_formatter)
    key(phrase_ender)
<user.format_text>+ [halt]: user.insert_many(format_text_list)
strict <user.format_text>+$: user.insert_many(format_text_list)
<user.formatters> that: user.formatters_reformat_selection(user.formatters)
word <user.word>: user.insert_formatted(user.word, "NOOP")
proud <user.word>: user.insert_formatted(user.word, "CAPITALIZE_FIRST_WORD")
format help | help format: user.formatters_help_toggle()
recent list: user.toggle_phrase_history()
recent repeat <number_small>: insert(user.get_recent_phrase(number_small))
recent copy <number_small>: clip.set_text(user.get_recent_phrase(number_small))
select that: user.select_last_phrase()
before that: user.before_last_phrase()
nope that | scratch that: user.clear_last_phrase()
nope that was <user.formatters>: user.formatters_reformat_last(formatters)
trot <user.word>: "{word} "