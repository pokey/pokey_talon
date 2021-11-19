from talon import Module, actions

mod = Module()
mod.list("code_keyword", desc="List of keywords for the active language")


@mod.action_class
class Actions:
    def code_keyword(keywords: list[str]):
        """Adds keywords"""
        for keyword in keywords:
            actions.insert(keyword)