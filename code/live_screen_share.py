from talon import Module, Context, actions

mod = Module()
mod.tag(
    "live_screen_share",
    f"tag to to indicate that live screen sharing session is active",
)

ctx = Context()

live_screen_share_ctx = Context()
live_screen_share_ctx.matches = r"""
tag: user.live_screen_share
"""


@mod.action_class
class Actions:
    def live_screen_share_start():
        """Start recording screen"""
        ctx.tags = ["user.live_screen_share"]
        actions.key("shift-f10")
        actions.user.change_setting("cursorless.pendingEditDecorationTime", 200)

    def live_screen_share_stop():
        """Stop recording screen"""
        ctx.tags = []
        actions.key("shift-f10")
        actions.user.change_setting("cursorless.pendingEditDecorationTime", 100)


@live_screen_share_ctx.action_class("user")
class UserActions:
    def maybe_hide_history():
        pass