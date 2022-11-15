import appscript
from talon import Context, Module

mod = Module()

ctx = Context()
ctx.matches = r"""
os: mac
"""


@mod.action_class
class Actions:
    def run_shortcut(name: str):
        """Runs a shortcut on macOS"""

    def run_shortcut_async(name: str):
        """Runs a shortcut on macOS, and don't wait for it to finish"""


@ctx.action_class("user")
class UserActions:
    def run_shortcut(name: str):
        appscript.app(id="com.apple.shortcuts.events").shortcuts[name].run_()

    def run_shortcut_async(name: str):
        actions.user.system_command_nb(f'/usr/bin/shortcuts run "{name}"')
