from talon import actions, speech_system
from talon import Context, Module, app


ctx = Context()
mod = Module()
ABORT_WORDS = ["fuck", "shit", "abort", "cancel"]

mod.list("abort_word", desc="Aborts the current command if heard")
ctx.lists["self.abort_word"] = ABORT_WORDS


def fn(d):
    words = d["parsed"]._unmapped
    if words[-1] in ABORT_WORDS and actions.speech.enabled():
        d["parsed"]._sequence = []
        app.notify("Command aborted")


speech_system.register("pre:phrase", fn)
