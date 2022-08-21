from talon import Module, actions, app

mod = Module()


@mod.action_class
class UserActions:
    def record_screen_start(record_face: bool):
        actions.user.wax_record_screen_start(
            actions.user.get_cursorless_recorder(True),
            actions.user.get_quicktime_recorder(),
            actions.user.get_obs_recorder() if record_face else None,
        )

        # Slow down cursorless decorations
        actions.user.change_setting("cursorless.pendingEditDecorationTime", 200)

        # Disable notifications
        actions.user.run_shortcut("Turn Do Not Disturb On")

        actions.user.sleep_all()

    def record_screen_start_light():
        actions.user.wax_record_screen_start(
            actions.user.get_cursorless_recorder(False),
        )

        app.notify("Recording started")

    def record_screen_stop():
        actions.user.wax_record_screen_stop()

        # Restore cursorless decoration speed
        actions.user.change_setting("cursorless.pendingEditDecorationTime", 100)

        # Enable notifications
        actions.user.run_shortcut("Turn Do Not Disturb Off")
