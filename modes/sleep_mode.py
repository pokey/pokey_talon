from talon import Context, actions

ctx = Context()
ctx.matches = r"""
mode: sleep
"""


@ctx.action_class("user")
class UserActions:
    def postalveolar_click():
        active_microphone = actions.sound.active_microphone()
        actions.sound.set_microphone("None")
        actions.sound.set_microphone(active_microphone)
        actions.user.mouse_wake()
        actions.user.maybe_show_history()
        actions.user.talon_mode()
