from talon import Context, Module

ctx = Context()
mod = Module()
apps = mod.apps
apps.linear = """
app.name: Linear
"""
ctx.matches = r"""
app: linear
"""
