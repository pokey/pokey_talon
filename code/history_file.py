# Based on https://github.com/phillco/knausj_talon/blob/7b1703ba293b3eb4c3976d16946d28f363034488/phil/history_file.py
import re

from talon import Module, app
from talon_init import TALON_HOME

# ==============================================================================
# NOTE(pcohen): Parsing the output of sim() is almost certainly to break in a
# future version of Talon, per aegis, and is recommended against.
# *Don't use this for anything important.*
# ==============================================================================

mod = Module()


@mod.action_class
class Actions:
    def parse_sim(sim: str):
        """Attempts to parse {sim} (the output of `sim()`) into a richer object with the phrase, grammar, file,
        and possibly the matched rule(s).
        """
        results = SIM_RE.findall(sim)
        if not results:
            return None

        commands = []
        for str, num, phrase, file, grammar in results:
            cmd = {
                "num": int(num),
                "phrase": phrase,
                "file": file,
                "grammar": grammar,
            }
            match = attempt_match_rule(file, grammar)
            if match:
                cmd["user_rule"] = match
            else:
                app.notify(f"No rules found for grammar", f"{grammar} in {file}")
            commands.append(cmd)

        return commands


SIM_RE = re.compile(r"""(\[(\d+)] "([^"]+)"\s+path: ([^\n]+)\s+rule: "([^"]+))+""")


def attempt_match_rule(file_path: str, grammar: str):
    """sim() returns a filepath and the grammar that was run; this attempts to
    match it to the specific rule in that file.
    Returns the match, if we found it, with a line number and the line contents
    from the .talon file.
    """
    path = TALON_HOME / file_path
    with open(path) as f:
        lines = f.readlines()

    # The grammar from sim() has most of it; we need to match the optional white space,
    # anchoring characters, and the :.
    regex = re.compile(rf"\s*\^?\s*{re.escape(grammar)}\s*\$?\s*:")
    for i in range(len(lines)):
        line = lines[i]

        if not regex.match(line):
            continue

        return {"line": i + 1, "rule": line.strip()}

    return None
