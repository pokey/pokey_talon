from talon import Module, Context
import appscript

mod = Module()


ctx = Context()
ctx.matches = r"""
os: mac
"""

@mod.action_class
class Actions:
    def run_shortcut(name: str):
        """Runs a shortcut on macOS"""        
        pass


@ctx.action_class("user")
class UserActions:
    def run_shortcut(name: str):
        appscript.app(id='com.apple.shortcuts.events').shortcuts[name].run_()
