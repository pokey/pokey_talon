from talon import Context, Module, actions

mod = Module()


ctx = Context()


@ctx.action_class("user")
class UserActions:
    def post_record_screen_start_hook():
        # Slow down cursorless decorations
        actions.user.change_setting("cursorless.pendingEditDecorationTime", 200)

        # Disable notifications
        actions.user.run_shortcut("Turn Do Not Disturb On")

        actions.user.sleep_all()

    def post_record_screen_stop_hook():
        # Enable notifications
        actions.user.run_shortcut("Turn Do Not Disturb Off")

        # Restore cursorless decoration speed
        actions.user.change_setting("cursorless.pendingEditDecorationTime", 100)
