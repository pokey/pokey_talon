from talon import Context

ctx = Context()
ctx.matches = """
os: mac
"""


@ctx.capture(rule="<user.number_key> | {user.letter} [{user.letter}]")
def clippy_hint(m) -> str:
    try:
        return str(m.number_key)
    except AttributeError:
        return "".join(m.letter_list)
