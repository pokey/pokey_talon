from talon import Context, Module, actions

mod = Module()

wake_ctx = Context()


@mod.action_class
class Actions:
    def maybe_hide_history():
        """Hides history if mode wants it"""

    def sleep_all():
        """Sleeps talon and hides everything"""
        actions.user.switcher_hide_running()
        actions.user.maybe_hide_history()
        actions.user.homophones_hide()
        actions.user.help_hide()
        actions.user.mouse_sleep()
        actions.speech.disable()
        actions.user.engine_sleep()

    def wake_all():
        """Wakes talon and shows everything"""
        actions.user.cancel_in_flight_phrase()
        actions.user.mouse_wake()
        actions.user.talon_mode()
        actions.mode.enable("user.sketch")


@wake_ctx.action_class("user")
class WakeUserActions:
    def maybe_hide_history():
        pass
