from talon import Module, actions

mod = Module()


@mod.action_class
class Actions:
    def dental_click():
        """Responds to an alveolar click"""
        # app.notify("Dental click")

    def postalveolar_click():
        """Responds to an postalveolar click"""
        actions.core.repeat_phrase(1)
