#provide both anchored and unachored commands via 'over'
phrase <user.text>$: user.insert_with_history(text)
phrase <user.text> {user.phrase_ender}:
    user.insert_with_history(text)
    key(phrase_ender)
{user.prose_formatter} <user.prose>$:
    user.insert_formatted(prose, prose_formatter)
{user.prose_formatter} <user.prose> {user.phrase_ender}:
    user.insert_formatted(prose, prose_formatter)
    key(phrase_ender)
# Note that we have to use two separate lines here rather than an optional halt
# at the end because otherwise it doesn't work in the following case:
# "get halt string node"
# We would like this to map to:
# get"node"
# But instead it would map to:
# getHaltStringNode
# Also keep an eye out for the following cases when messing with these formatters:
# getStringNode
# mockPrePhraseGetVersion
<user.format_text>: user.insert_many(format_text_list)
<user.format_text> halt: user.insert_many(format_text_list)
strict <user.format_text>$: user.insert_many(format_text_list)
<user.formatters> that: user.formatters_reformat_selection(user.formatters)
word <user.word>: user.insert_with_history(user.word)
proud <user.word>: user.insert_formatted(user.word, "CAPITALIZE_FIRST_WORD")
recent list: user.toggle_phrase_history()
recent close: user.phrase_history_hide()
recent repeat <number_small>:
    user.insert_with_history(user.get_recent_phrase(number_small))
recent copy <number_small>: clip.set_text(user.get_recent_phrase(number_small))
select that: user.select_last_phrase()
before that: user.before_last_phrase()
nope that | scratch that: user.clear_last_phrase()
nope that was <user.formatters>: user.formatters_reformat_last(formatters)
trot <user.word>: "{word} "
