from talon import Context, Module, actions, app

from pathlib import Path

mod = Module()
mod.tag(
    "recording_screen",
    "Indicates that the screen is being recorded",
)
ctx = Context()

is_recording_file = Path("/tmp/is-recording-video")


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

        is_recording_file.touch()

        # Hide VSCode notifications that command recording has started
        actions.sleep(1)
        actions.key("escape")

        actions.user.sleep_all()

    def start_recording_light():
        """Start recording just cursorless"""
        actions.user.wax_start_recording(
            actions.user.wax_cursorless_recorder(False),
        )

        app.notify("Recording started")

    def stop_recording():
        """Stop recording"""
        if is_recording_file.exists():
            is_recording_file.unlink()

        actions.user.wax_stop_recording()

        ctx.tags = []

        # Restore cursorless decoration speed
        actions.user.change_setting("cursorless.pendingEditDecorationTime", 100)
