from talon import Context, Module

ctx = Context()
mod = Module()
apps = mod.apps
apps.preview = """
app.name: Preview
"""
ctx.matches = r"""
app: preview
"""
