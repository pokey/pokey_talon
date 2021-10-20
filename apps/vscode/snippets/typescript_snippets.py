from talon import Context, actions, ui, Module, app

# from user.knausj_talon.code.snippet_watcher import snippet_watcher
import os

ctx = Context()
ctx.matches = r"""
app: vscode
mode: user.typescript
mode: user.auto_lang 
and code.language: typescript
"""
# short name -> ide clip name
# See
# https://github.com/pokey/dotfiles/blob/develop/vscode/snippets/typescript.json
# for definitions
ctx.lists["user.snippets"] = {
    "binder": "bind class function",
    "if": "if statement",
    "else": "if else statement",
}
ctx.lists["user.snippet_one_phrase"] = {
    "face": "interface",
    "con": "const declaration",
    "let": "let declaration",
}

snippet_formatters = {
    "interface": ["PUBLIC_CAMEL_CASE"],
    "const declaration": ["PRIVATE_CAMEL_CASE"],
    "let declaration": ["PRIVATE_CAMEL_CASE"],
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
#     watcher = snippet_watcher({snippet_path: ["typescript.json",],}, update_list,)
