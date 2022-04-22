from talon import ctrl, ui, Module, Context, actions, clip, app
from talon.experimental.locate import locate_hover

ctx = Context()
mod = Module()

mod.apps.chrome = "app.name: Google Chrome"
mod.apps.chrome = """
os: windows
and app.exe: chrome.exe
"""
mod.apps.chrome = """
os: mac
and app.bundle: com.google.Chrome
"""
mod.apps.chrome = """
os: mac
and app.bundle: org.chromium.Chromium
"""
mod.apps.chrome = """
os: linux
app.exe: chrome
app.exe: chromium-browser
"""
mod.apps.chrome = """
os: linux
and app.name: Google-chrome
"""
ctx.matches = r"""
app: chrome
"""

@ctx.action_class("user")
class user_actions:
    def tab_jump(number: int):
        if number < 9:
            if app.platform == "mac":
                actions.key("cmd-{}".format(number))
            else:
                actions.key("ctrl-{}".format(number))

    def tab_final():
        if app.platform == "mac":
            actions.key("cmd-9")
        else:
            actions.key("ctrl-9")

    def tab_close_wrapper():
        actions.sleep("180ms")
        actions.app.tab_close()

    def dental_click():
        actions.key("escape f")

    def tab_duplicate():
        """Limitation: this will not work if the text in your address bar has been manually edited.
        Long-term we want a better shortcut from browsers.
        """
        actions.browser.focus_address()
        actions.sleep("180ms")
        actions.key("alt-enter")


@mod.action_class
class Actions:
    def fill_password():
        """Move mouse to last pass fill password button"""
        locate_hover("templates/fill-password.png")


@ctx.action_class("browser")
class browser_actions:
    def go(url: str):
        actions.browser.focus_address()
        actions.sleep("50ms")
        actions.insert(url)
        actions.key("enter")
