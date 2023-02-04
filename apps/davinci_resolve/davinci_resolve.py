from talon import Module

mod = Module()

mod.apps.davinci_resolve = """
os: mac
and app.bundle: com.blackmagic-design.DaVinciResolve
"""

mod.mode("davinci_resolve", "Mode for DaVinci Resolve")
