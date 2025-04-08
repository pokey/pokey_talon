window (new | open): app.window_open()
window next: app.window_next()
window last: app.window_previous()
window close: app.window_close()
window hide: app.window_hide()
focus <user.running_applications> [<phrase>]$:
    user.switcher_focus(running_applications)
    sleep(200ms)
    user.parse_phrase(phrase or "")
# following only works on windows. Can't figure out how to make it work for mac. No idea what the equivalent for linux would be.
# focus$: user.switcher_menu()
focus last: user.switcher_focus_last()
running list: user.switcher_toggle_running()
running close: user.switcher_hide_running()
launch <user.launch_applications>: user.switcher_launch(launch_applications)

snap <user.window_snap_position>: user.snap_window(window_snap_position)
snap next [screen]: user.move_window_next_screen()
snap last [screen]: user.move_window_previous_screen()
snap screen <number>: user.move_window_to_screen(number)
snap <user.running_applications> <user.window_snap_position>:
    user.snap_app(running_applications, window_snap_position)
snap <user.running_applications> [screen] <number>:
    user.move_app_to_screen(running_applications, number)
portal [<phrase>]$:
    user.switcher_focus("Firefox")
    sleep(200ms)
    user.parse_phrase(phrase or "")
coder [<phrase>]$:
    user.switcher_focus("Code")
    sleep(300ms)
    user.parse_phrase(phrase or "")
tune (talon | talent) [<phrase>]$:
    user.focus_talon_project()
    user.parse_phrase(phrase or "")
(talon | talent) sketch <user.text>$:
    user.focus_talon_project()
    user.run_rpc_command("workbench.action.tasks.runTask", "Modify talon using sketch")
    sleep(1s)
    insert(text)
slacker [<phrase>]$:
    user.switcher_focus("Slack")
    sleep(200ms)
    user.parse_phrase(phrase or "")
folk things [<phrase>]$:
    user.switcher_focus("Things")
    sleep(200ms)
    user.parse_phrase(phrase or "")
folk sim [<phrase>]$:
    user.switcher_focus("Simulator")
    sleep(200ms)
    user.parse_phrase(phrase or "")
