from talon import Module, actions, app, cron

mod = Module()


@mod.action_class
class UserActions:
    def start_recording(record_face: bool):
        """
        Start recording the screen

        Args:
            record_face (bool): Whether to also record the face using obs
        """
        actions.user.wax_start_recording(
            actions.user.get_cursorless_recorder(True),
            actions.user.get_quicktime_recorder(),
            actions.user.get_obs_recorder() if record_face else None,
        )

        # Slow down cursorless decorations
        actions.user.change_setting("cursorless.pendingEditDecorationTime", 200)

        actions.user.sleep_all()

    def start_recording_light():
        """Start recording just cursorless"""
        actions.user.wax_start_recording(
            actions.user.get_cursorless_recorder(False),
        )

        app.notify("Recording started")

    def stop_recording():
        """Stop recording"""
        actions.user.wax_stop_recording()

        # Restore cursorless decoration speed
        actions.user.change_setting("cursorless.pendingEditDecorationTime", 100)

        # Enable notifications
        actions.user.run_shortcut("Turn Do Not Disturb Off")
