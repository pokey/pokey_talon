from talon import Module, actions, app

mod = Module()
mod.mode("sketch", "Sketch mode")


def on_ready():
    """Called when the Talon engine is ready."""
    # Enable the sketch mode always as a hack to get Talon's mode
    # chaining to restrict chaining dictation with other commands.
    actions.mode.enable("user.sketch")


app.register("ready", on_ready)
