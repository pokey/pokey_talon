from typing import Optional
from talon import Context, actions

ctx = Context()


@ctx.action_class("user")
class UserActions:
    def history_transform_phrase_text(words: list[str]) -> Optional[str]:
        if not words or not actions.speech.enabled():
            return None

        try:
            words = words[: words.index("drowse")]
        except ValueError:
            pass

        return " ".join(words)
