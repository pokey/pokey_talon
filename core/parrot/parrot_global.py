from typing import Any

from talon import Module, actions, app, ctrl, ui

mod = Module()


@mod.action_class
class Actions:
    def handle_sibilant(f0: float, f1: float, f2: float, power: float):
        """Cancels phrase currently being spoken"""
        print(f"{f0}\t{f1}\t{f2}\t{power}")
        current_x, _ = ctrl.mouse_pos()
        rect = ui.active_window().rect
        fraction = (f2 - 1000) / 1500
        ctrl.mouse_move(current_x, rect.bot - (rect.height * fraction))
