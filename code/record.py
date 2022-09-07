from talon import Context, Module, actions, app

mod = Module()
mod.tag(
    "recording_screen",
    "Indicates that the screen is being recorded",
)
ctx = Context()


@mod.action_class
class UserActions:
    def start_recording(record_face: bool):
        """
        Start recording the screen

        Args:
            record_face (bool): Whether to also record the face using obs
        """
        actions.user.wax_start_recording(
            actions.user.wax_cursorless_recorder(True),
            actions.user.wax_quicktime_recorder(),
            actions.user.wax_obs_recorder() if record_face else None,
        )

        ctx.tags = ["user.recording_screen"]

        # Slow down cursorless decorations
        actions.user.change_setting("cursorless.pendingEditDecorationTime", 200)

        actions.user.sleep_all()

    def start_recording_light():
        """Start recording just cursorless"""
        actions.user.wax_start_recording(
            actions.user.wax_cursorless_recorder(False),
        )

        app.notify("Recording started")

    def stop_recording():
        """Stop recording"""
        actions.user.wax_stop_recording()

        ctx.tags = []

        # Restore cursorless decoration speed
        actions.user.change_setting("cursorless.pendingEditDecorationTime", 100)
