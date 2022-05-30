from talon import Context, Module

ctx = Context()
mod = Module()
apps = mod.apps
apps.acrobat = """
app.name: Acrobat Reader
"""
ctx.matches = r"""
app: acrobat
"""
