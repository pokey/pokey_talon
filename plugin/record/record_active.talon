tag: user.wax_is_recording
-

^record stop$: user.stop_recording()

^record restart$:
    user.stop_recording()
    user.start_recording(1)

# Use this after a cool command; can search through logs for it later
^nice one$: skip()
