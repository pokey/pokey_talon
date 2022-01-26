from talon import Module, Context, actions, app, ui
from talon.mac import applescript

mod = Module()
mod.tag(
    "recording_screen", f"tag to to indicate that screen is currently being recorded"
)

ctx = Context()

sleeping_recording_screen_ctx = Context()
sleeping_recording_screen_ctx.matches = r"""
mode: sleep
and tag: user.recording_screen
"""


def show_obs_menu():
    menu = ui.apps(bundle="com.obsproject.obs-studio")[0].children.find_one(
        AXRole="AXMenuBarItem", AXSubrole="AXMenuExtra"
    )
    try:
        menu.perform("AXPress")
    except:
        pass
    return menu


def run_shortcut(name: str):
    applescript.run(f"""
    tell application "Shortcuts Events"
        run shortcut "{name}"
    end tell
    """)
        
        
@mod.action_class
class Actions:
    def record_screen_start():
        """Start recording screen"""
        
        # First ensure that OBS is running
        try:
            next(app for app in ui.apps(background=False) if app.name == "OBS")
        except StopIteration:
            app.notify("ERROR: Please launch OBS")
            raise

        ctx.tags = ["user.recording_screen"]

        # Disable notifications
        run_shortcut("Turn Do Not Disturb On")

        # Slow down cursorless decorations
        actions.user.change_setting("cursorless.pendingEditDecorationTime", 200)

        # Start OBS face recording
        menu = show_obs_menu()
        menu.children.find_one(AXRole="AXMenuItem", AXTitle="Start Recording").perform(
            "AXPress"
        )

        # Start quick time screen recording
        actions.key("cmd-shift-5")
        actions.sleep("500ms")
        actions.key("enter")

        actions.user.sleep_all()

    def record_screen_stop():
        """Stop recording screen"""
        ctx.tags = []

        # Enable notifications
        run_shortcut("Turn Do Not Disturb Off")

        # Restore cursorless decoration speed
        actions.user.change_setting("cursorless.pendingEditDecorationTime", 100)

        # Stop OBS face recording
        menu = show_obs_menu()
        menu.children.find_one(AXRole="AXMenuItem", AXTitle="Stop Recording").perform(
            "AXPress"
        )
        
        # Stop quick time screen recording
        ui.apps(bundle="com.apple.screencaptureui")[0].children.find_one(
            AXRole="AXMenuBarItem"
        ).perform("AXPress")


@sleeping_recording_screen_ctx.action_class("user")
class UserActions:
    def maybe_show_history():
        pass
