#defines the commands that sleep/wake Talon
# mode: all
# -
drowse [<phrase>]$:
    user.switcher_hide_running()
    user.history_disable()
    user.homophones_hide()
    user.help_hide()
    user.mouse_sleep()
    speech.disable()
    user.engine_sleep()

drowse <phrase> resume$: skip()

