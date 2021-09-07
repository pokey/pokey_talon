from talon import Context, actions

ctx = Context()
ctx.matches = r"""
mode: sleep
"""


@ctx.action_class("user")
class UserActions:
    def postalveolar_click():
        actions.user.mouse_wake()
        actions.user.history_enable()
        actions.user.talon_mode()
