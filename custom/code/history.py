from typing import Optional

from talon import Context, actions

ctx = Context()
ctx.matches = """
not mode: user.cursorless_spoken_form_test
"""


@ctx.action_class("user")
class UserActions:
    def history_transform_phrase_text(words: list[str]) -> Optional[str]:
        if not words or not actions.speech.enabled():
            return None

        try:
            words = words[: words.index("drowse")]
        except ValueError:
            pass

        return " ".join(words) if words else None


cursorless_spoken_form_test_ctx = Context()
cursorless_spoken_form_test_ctx.matches = """
mode: user.cursorless_spoken_form_test
"""


@cursorless_spoken_form_test_ctx.action_class("user")
class UserActions:
    def history_transform_phrase_text(words: list[str]) -> Optional[str]:
        return None
