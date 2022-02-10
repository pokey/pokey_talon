import json
from pathlib import Path
import subprocess
import time
from typing import Any
import uuid
from talon import Module, Context, actions, app, ui, speech_system, scope

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

recording_screen_ctx = Context()
recording_screen_ctx.matches = r"""
tag: user.recording_screen
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


GIT = "/usr/local/bin/git"

recording_start_time = 0
recording_log_directory = ""
recording_log_file = ""
recordings_root_dir = Path.home() / "talon-recording-logs"


def log_object(output_object):
    with open(recording_log_file, "a") as out:
        out.write(json.dumps(output_object) + "\n")


def git(*args: str, cwd: Path):
    return subprocess.run(
        [GIT, *args],
        capture_output=True,
        text=True,
        cwd=cwd,
    ).stdout.strip()


@mod.action_class
class Actions:
    def record_screen_start():
        """Start recording screen"""
        global recording_start_time
        global recording_log_directory
        global recording_log_file

        # First ensure that OBS is running
        try:
            next(app for app in ui.apps(background=False) if app.name == "OBS")
        except StopIteration:
            app.notify("ERROR: Please launch OBS")
            raise

        ctx.tags = ["user.recording_screen"]

        # Disable notifications
        actions.user.run_shortcut("Turn Do Not Disturb On")

        # Slow down cursorless decorations
        actions.user.change_setting("cursorless.pendingEditDecorationTime", 200)

        # Start OBS face recording
        menu = show_obs_menu()
        menu.children.find_one(AXRole="AXMenuItem", AXTitle="Start Recording").perform(
            "AXPress"
        )

        # Start quicktime screen recording
        actions.key("cmd-shift-5")
        actions.sleep("500ms")
        actions.key("enter")

        recording_start_time = time.perf_counter()
        recording_log_directory = recordings_root_dir / time.strftime("%Y%m%dT%H%M%S")
        recording_log_directory.mkdir(parents=True)
        recording_log_file = recording_log_directory / "talon-log.jsonl"

        # TODO: Enable silent cursorless record mode

        user_dir: Path = actions.path.talon_user()
        for directory in user_dir.iterdir():
            if not directory.is_dir():
                continue

            repo_remote_url = git("config", "--get", "remote.origin.url", cwd=directory)

            if not repo_remote_url:
                continue

            commit_sha = git("rev-parse", "HEAD", cwd=directory)

            # Represents the path of the given folder within the git repo in
            # which it is contained. This occurs when we sim link a subdirectory
            # of a repository into our talon user directory such as we do with
            # cursorless talon.
            repo_prefix = git("rev-parse", "--show-prefix", cwd=directory)

            log_object(
                {
                    "type": "directoryInfo",
                    "localPath": str(directory),
                    "localRealPath": str(directory.resolve(strict=True)),
                    "repoRemoteUrl": repo_remote_url,
                    "repoPrefix": repo_prefix,
                    "commitSha": commit_sha,
                }
            )

        actions.user.sleep_all()

    def record_screen_stop():
        """Stop recording screen"""
        ctx.tags = []

        # Enable notifications
        actions.user.run_shortcut("Turn Do Not Disturb Off")

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

        # TODO: Disable silent cursorless record mode

    def maybe_capture_phrase(j: Any):
        """Possibly capture a phrase; does nothing unless screen recording is active"""
        pass


@sleeping_recording_screen_ctx.action_class("user")
class SleepUserActions:
    def maybe_show_history():
        pass


@ctx.action_class("user")
class UserActions:
    def maybe_capture_phrase(j: Any):
        # Turn this one off globally
        pass


@recording_screen_ctx.action_class("user")
class UserActions:
    def maybe_capture_phrase(j: Any):
        global recording_start_time
        words = j.get("text")

        if text := actions.user.history_transform_phrase_text(words):
            # TODO: Parse sim output and dump to file
            # TODO: Get github link to talon file, making sure to follow symlinks
            # QUESTION: Should we spy actions?

            sim = None
            commands = None
            try:
                sim = speech_system._sim(text)
                commands = actions.user.parse_sim(sim)
            except Exception as e:
                app.notify(f'Couldn\'t sim for "{text}"', f"{e}")

            log_object(
                {
                    "type": "talonCommandPhrase",
                    "id": str(uuid.uuid4()),
                    "timeOffset": time.perf_counter() - recording_start_time,
                    "phraseStartTimeOffset": j["_ts"] - recording_start_time,
                    "phrase": text,
                    "rawSim": sim,
                    "commands": commands,
                    "modes": list(scope.get("mode")),
                    "tags": list(scope.get("tag")),
                }
            )


def on_phrase(j):
    actions.user.maybe_capture_phrase(j)


speech_system.register("phrase", on_phrase)
