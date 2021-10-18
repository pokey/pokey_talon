tag: user.snippets
-
snip {user.snippets}: user.snippet_insert(user.snippets)
snip {user.snippet_one_phrase} [<user.text>]$: user.snippet_insert_with_phrases(user.snippet_one_phrase, text_list or "")
snip {user.snippet_one_phrase} [<user.text>] halt: user.snippet_insert_with_phrases(user.snippet_one_phrase, text_list or "")
snip scout <user.text>: user.snippet_search(user.text)
snip scout: user.snippet_search("")
snip create: user.snippet_create()
snip show: user.snippet_toggle()
