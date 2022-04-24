tag: user.recording_screen
-
settings():
    # speech._subtitles = 1
    user.talon_hud_environment = "recording_screen"
record stop: user.record_screen_stop()
record restart:
    user.record_screen_stop()
    user.record_screen_start()
