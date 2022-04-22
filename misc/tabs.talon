tag: user.tabs
-
tab make: app.tab_open()
tab last: app.tab_previous()
tab next: app.tab_next()
tab close: user.tab_close_wrapper()
tab (reopen|restore): app.tab_reopen()
tab <user.ordinals>: user.tab_jump(ordinals)
tab final: user.tab_final()
tab duplicate: user.tab_duplicate()
