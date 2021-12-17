from talon import Module, Context, actions

mod = Module()

ctx = Context()
ctx.matches = r"""
mode: sleep
"""


@mod.action_class
class Actions:
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


@ctx.action_class("user")
class UserActions:
    def postalveolar_click():
        actions.user.wake_all()
