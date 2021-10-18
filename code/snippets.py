# defines placeholder actions and captures for ide-specific snippet functionality
from typing import Optional, Union
from talon import Module, actions, app, Context, imgui, registry

mod = Module()
mod.tag("snippets", desc="Tag for enabling code snippet-related commands")
mod.list("snippets", desc="List of code snippets")
mod.list("snippet_one_phrase", desc="List of code snippets that accept one phrase")


@imgui.open()
def gui(gui: imgui.GUI):
    gui.text("snippets")
    gui.line()

    if "user.snippets" in registry.lists:
        function_list = sorted(registry.lists["user.snippets"][0].keys())
        # print(str(registry.lists["user.snippets"]))

        # print(str(registry.lists["user.code_functions"]))
        if function_list:
            for i, entry in enumerate(function_list):
                gui.text("{}".format(entry, function_list))


@mod.action_class
class Actions:
    def snippet_search(text: str):
        """Triggers the program's snippet search"""

    def snippet_insert(text: str):
        """Inserts snippet"""

    def snippet_next():
        """Move to next snippet placeholder"""

    def snippet_insert_with_phrases(snippet_name: str, phrases: Union[list[str], str]):
        """Inserts a snippet filling in some text"""
        if phrases == "":
            phrases = []

        formatters = actions.user.get_snippet_formatters(snippet_name)
        formatted_texts = [
            actions.user.formatted_text(phrase, formatter)
            for phrase, formatter in zip(phrases, formatters)
        ]
        actions.user.snippet_insert(snippet_name)
        for formatted_text in formatted_texts:
            actions.insert(formatted_text)
            actions.user.snippet_next()

    def get_snippet_formatters(snippet_name: str):
        """Get a list of formatters four placeholders in the given snippet

        Args:
            snippet_name (str): The name of the snippet to look up
        """
        pass

    def snippet_create():
        """Triggers snippet creation"""

    def snippet_toggle():
        """Toggles UI for available snippets"""
        if gui.showing:
            gui.hide()
        else:
            gui.show()
