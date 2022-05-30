from talon import Context, Module, actions

mod = Module()

sleep_ctx = Context()
sleep_ctx.matches = r"""
mode: sleep
"""

wake_ctx = Context()


@mod.action_class
class Actions:
    def maybe_hide_history():
        """Hides history if mode wants it"""

    def maybe_show_history():
        """Shows history if mode wants it"""

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
        active_microphone = actions.sound.active_microphone()
        actions.sound.set_microphone("None")
        actions.sound.set_microphone(active_microphone)
        actions.user.mouse_wake()
        actions.user.maybe_show_history()
        actions.user.talon_mode()


@sleep_ctx.action_class("user")
class SleepUserActions:
    def postalveolar_click():
        actions.user.wake_all()

    def maybe_show_history():
        pass


@wake_ctx.action_class("user")
class WakeUserActions:
    def maybe_hide_history():
        pass
