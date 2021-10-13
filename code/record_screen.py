from talon import Module, Context, actions, app, ui
from talon.experimental.locate import locate_hover

mod = Module()
mod.tag(
    "recording_screen", f"tag to to indicate that screen is currently being recorded"
)

ctx = Context()

sleeping_recording_screen_ctx = Context()
sleeping_recording_screen_ctx.matches = r"""
mode: sleep
and tag: user.recording_screen
"""


@mod.action_class
class Actions:
    def maybe_show_history():
        """Shows history if mode wants it"""
        actions.user.history_enable()

    def record_screen_start():
        """Start recording screen"""
        ctx.tags = ["user.recording_screen"]
        actions.user.history_disable()
        actions.user.switcher_focus("OBS")
        actions.key("cmd-ctrl-alt-.")
        actions.key("cmd-ctrl-alt-p")
        actions.sleep("250ms")
        actions.user.switcher_focus("QuickTime Player")
        actions.sleep("250ms")
        actions.key("cmd-ctrl-n")
        actions.sleep("250ms")
        actions.key("enter")
        actions.sleep("250ms")
        actions.user.switcher_focus("Code")

    def record_screen_stop():
        """Stop recording screen"""
        ctx.tags = []
        actions.user.history_enable()
        actions.user.switcher_focus("OBS")
        actions.key("cmd-ctrl-alt-,")
        actions.sleep("250ms")
        actions.key("cmd-shift-5")
        actions.sleep("250ms")
        locate_hover("templates/stop-recording.png")
        actions.mouse_click(0)
        actions.sleep("250ms")
        actions.user.switcher_focus("Code")


@sleeping_recording_screen_ctx.action_class("user")
class UserActions:
    def maybe_show_history():
        pass