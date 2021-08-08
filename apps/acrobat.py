from talon import ctrl, ui, Module, Context, actions, clip, app

ctx = Context()
mod = Module()
apps = mod.apps
apps.acrobat = """
app.name: Acrobat Reader
"""
ctx.matches = r"""
app: acrobat
"""
