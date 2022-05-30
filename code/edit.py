from talon import Context, Module, actions, clip

# import re

ctx = Context()
mod = Module()


# From https://github.com/AndreasArvidsson/andreas-talon/blob/4f4ac64376c3c2623d7a0871bb5d2997e8a10be9/misc/edit.py#L11-L20
# @ctx.action_class("main")
# class MainActions:
#     def insert(text: str):
#         if isinstance(text, str) and len(text) > 2 and re.search(r"[ /-]|\n", text):
#             actions.user.paste(text)
#         else:
#             actions.next(text)


@ctx.action_class("edit")
class EditActions:
    def selected_text() -> str:
        with clip.capture() as s:
            actions.edit.copy()
        try:
            return s.get()
        except clip.NoChange:
            return ""

    def line_insert_down():
        actions.edit.line_end()
        actions.key("enter")


@mod.action_class
class Actions:
    def paste(text: str):
        """Pastes text and preserves clipboard"""

        with clip.revert():
            clip.set_text(text)
            # actions.sleep("150ms")
            actions.edit.paste()
            # sleep here so that clip.revert doesn't revert the clipboard too soon
            actions.sleep("150ms")

    def down_n(n: int):
        """Goes down n lines"""
        for _ in range(n):
            actions.edit.down()
            actions.sleep("10ms")

    def up_n(n: int):
        """Goes up n lines"""
        for _ in range(n):
            actions.edit.up()
            actions.sleep("10ms")

    def left_n(n: int):
        """Goes left n lines"""
        for _ in range(n):
            actions.edit.left()

    def delete_left_n(n: int):
        """Goes left n lines"""
        actions.key(f"backspace:{n}")

    def delete_right_n(n: int):
        """Goes left n lines"""
        actions.key(f"delete:{n}")

    def right_n(n: int):
        """Goes right n lines"""
        for _ in range(n):
            actions.edit.right()

    def delete_word_right_n(n: int):
        """Delete right n words"""
        for _ in range(n):
            actions.edit.extend_word_right()
        actions.edit.delete()

    def delete_word_left_n(n: int):
        """Delete left n words"""
        for _ in range(n):
            actions.edit.extend_word_left()
        actions.edit.delete()

    def words_left(n: int):
        """Moves left by n words."""
        for _ in range(n):
            actions.edit.word_left()

    def words_right(n: int):
        """Moves right by n words."""
        for _ in range(n):
            actions.edit.word_right()
