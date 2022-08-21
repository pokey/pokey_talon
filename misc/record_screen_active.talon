tag: user.wax_is_recording
-
settings():
    user.talon_hud_environment = "recording_screen"

^record stop$: user.record_screen_stop()

^record restart$:
    user.record_screen_stop()
    user.record_screen_start()

# Use this after a cool command; can search through logs for it later
^nice one$: skip()
