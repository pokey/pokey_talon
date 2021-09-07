from talon import actions, speech_system


def fn(d):
    try:
        words = d["parsed"]._unmapped
    except KeyError:
        return
    if words[0] == "keeper" and actions.speech.enabled():
        actions.insert(" ".join(words[1:]))
        d["parsed"]._sequence = []


speech_system.register("pre:phrase", fn)
