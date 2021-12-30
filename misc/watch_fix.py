"""
This file is a hack. For some reason settings watching doesn't work if I don't
have this file here.
"""
from talon import fs, app
import pathlib

root = pathlib.Path(__file__).parent.parent.resolve()


path = str(root / "cursorless-settings")
print(path)


def on_watch(_1, _2):
    pass


def on_ready():
    fs.watch(path, on_watch)


app.register("ready", on_ready)