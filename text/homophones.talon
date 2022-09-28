# phones <user.homophones_canonical>: user.homophones_show(homophones_canonical)
# phones that: user.homophones_show_selection()
phones force <user.homophones_canonical>:
    user.homophones_force_show(homophones_canonical)
phones force: user.homophones_force_show_selection()
phones hide: user.homophones_hide()
phones word:
    edit.select_word()
    user.homophones_show_selection()
phones [<user.ordinals_small>] word left:
    n = ordinals_small or 1
    user.words_left(n - 1)
    edit.extend_word_left()
    user.homophones_show_selection()
phones [<user.ordinals_small>] word right:
    n = ordinals_small or 1
    user.words_right(n - 1)
    edit.extend_word_right()
    user.homophones_show_selection()
