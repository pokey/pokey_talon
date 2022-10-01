from talon import Module

mod = Module()
mod.tag("todo_list", desc="Tag for enabling generic todo list commands")


@mod.action_class
class Actions:
    def mark_complete():
        """Mark a todo as completed"""

    def mark_cancelled():
        """Mark a todo as cancelled"""

    def show_today():
        """Show today"""

    def show_inbox():
        """Show inbox"""

    def show_upcoming():
        """Show upcoming"""

    def show_anytime():
        """Show anytime"""

    def show_someday():
        """Show someday"""

    def show_logbook():
        """Show logbook"""
