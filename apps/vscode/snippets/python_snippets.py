from talon import Context, actions, ui, Module, app

# from user.knausj_talon.code.snippet_watcher import snippet_watcher
import os

ctx = Context()
ctx.matches = r"""
app: vscode
mode: user.python
mode: user.auto_lang 
and code.language: python
"""
# short name -> ide clip name
# See
# https://github.com/pokey/dotfiles/blob/develop/vscode/snippets/python.json
# for definitions
ctx.lists["user.snippets"] = {
    "if": "if statement",
    "else": "if else statement",
    "with": "with statement",
}
ctx.lists["user.snippet_one_phrase"] = {
    "class": "class declaration",
}

snippet_formatters = {
    "class": ["PUBLIC_CAMEL_CASE"],
}


@ctx.action_class("user")
class UserActions:
    def get_snippet_formatters(snippet_name: str):
        """Get a list of formatters four placeholders in the given snippet

        Args:
            snippet_name (str): The name of the snippet to look up
        """
        return snippet_formatters[snippet_name]


# def update_list(watch_list):
#     ctx.lists["user.snippets"] = watch_list


# # there's probably a way to do this without
# snippet_path = None
# if app.platform == "windows":
#     snippet_path = os.path.expandvars(r"%AppData%\Code\User\snippets")
# elif app.platform == "mac":
#     snippet_path = os.path.expanduser(
#         "~/Library/Application Support/Code/User/snippets"
#     )
# if snippet_path:
#     watcher = snippet_watcher({snippet_path: ["python.json",],}, update_list,)
