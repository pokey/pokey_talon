from contextlib import contextmanager
from datetime import datetime
import json
from pathlib import Path
import subprocess
import time
from typing import Any, Iterable, Optional
import uuid
from talon import Module, Context, actions, app, ui, speech_system, scope, screen, cron
from talon.canvas import Canvas

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

recording_start_time: float
recording_log_directory: Path
screenshots_directory: Path
recording_log_file: Path
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
        global screenshots_directory
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

        actions.sleep("3s")

        # Flash a rectangle so that we can synchronize the recording start time
        flash_rect()

        recording_start_time = time.perf_counter()

        recording_log_directory = recordings_root_dir / time.strftime("%Y%m%dT%H%M%S")
        recording_log_directory.mkdir(parents=True)
        recording_log_file = recording_log_directory / "talon-log.jsonl"

        commands_directory = recording_log_directory / "commands"
        commands_directory.mkdir(parents=True)

        screenshots_directory = recording_log_directory / "screenshots"
        screenshots_directory.mkdir(parents=True)

        # Start cursorless recording
        actions.user.vscode_with_plugin(
            "cursorless.recordTestCase",
            {
                "isSilent": True,
                "directory": str(commands_directory),
                "extraSnapshotFields": ["timeOffsetSeconds"],
            },
        )

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

        actions.sleep("250ms")

        # Stop cursorless recording
        actions.user.vscode("cursorless.recordTestCase")

    def maybe_capture_phrase(j: Any):
        """Possibly capture a phrase; does nothing unless screen recording is active"""
        pass

    def maybe_capture_post_phrase(j: Any):
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

    def maybe_capture_post_phrase(j: Any):
        # Turn this one off globally
        pass


def json_safe(arg: Any):
    """
    Checks whether arg can be json serialized and if so just returns arg as is
    otherwise returns none

    """
    try:
        json.dumps(arg)
        return arg
    except:
        return None


phrase_capture: Optional[dict]


@recording_screen_ctx.action_class("user")
class UserActions:
    def maybe_capture_phrase(j: Any):
        global phrase_capture
        words = j.get("text")

        text = actions.user.history_transform_phrase_text(words)

        if text is None:
            phrase_capture = None
            return

        sim = None
        commands = None
        try:
            sim = speech_system._sim(text)
            commands = actions.user.parse_sim(sim)
        except Exception as e:
            app.notify(f'Couldn\'t sim for "{text}"', f"{e}")

        parsed = j["parsed"]

        if commands is not None:
            for idx, capture_list in enumerate(parsed):
                commands[idx]["captures"] = [
                    json_safe(capture) for capture in capture_list
                ]

        pre_command_screenshot = capture_screen(
            screenshots_directory, recording_start_time
        )
        mark_screenshots = take_mark_screenshots(
            parsed, screenshots_directory, recording_start_time
        )

        phrase_capture = {
            "type": "talonCommandPhrase",
            "id": str(uuid.uuid4()),
            "timeOffset": time.perf_counter() - recording_start_time,
            "phraseStartTimeOffset": j["_ts"] - recording_start_time,
            "phrase": text,
            "rawSim": sim,
            "commands": commands,
            "modes": list(scope.get("mode")),
            "tags": list(scope.get("tag")),
            "markScreenshots": mark_screenshots,
            "preCommandScreenshot": pre_command_screenshot,
        }

    def maybe_capture_post_phrase(j: Any):
        if phrase_capture is not None:
            log_object(
                {
                    **phrase_capture,
                    "postCommandScreenshot": capture_screen(
                        screenshots_directory, recording_start_time
                    ),
                }
            )


def flash_rect():
    rect = screen.main_screen().rect

    def on_draw(c):
        c.paint.style = c.paint.Style.FILL
        c.paint.color = "#1b0026"
        c.draw_rect(rect)
        cron.after("30ms", canvas.close)

    canvas = Canvas.from_rect(rect)
    canvas.register("draw", on_draw)
    canvas.freeze()


def take_mark_screenshots(
    parsed: Iterable[list[Any]],
    screenshots_directory: Path,
    recording_start_time: float,
):
    decorated_marks = list(extract_decorated_marks(parsed))

    if not decorated_marks:
        return None

    all_decorated_marks_target = {
        "type": "list",
        "elements": [{"type": "primitive", "mark": mark} for mark in decorated_marks],
    }

    with cursorless_recording_paused():
        actions.user.cursorless_single_target_command(
            "highlight", all_decorated_marks_target, "highlight1"
        )

        actions.sleep("50ms")

        all_decorated_marks_screenshot = capture_screen(
            screenshots_directory, recording_start_time
        )

        actions.user.cursorless_single_target_command(
            "highlight",
            {
                "type": "primitive",
                "mark": {"type": "nothing"},
            },
            "highlight1",
        )

    return {"allDecoratedMarks": all_decorated_marks_screenshot}


@contextmanager
def cursorless_recording_paused():
    actions.user.vscode("cursorless.pauseRecording")
    yield
    actions.user.vscode("cursorless.resumeRecording")


def capture_screen(directory: Path, start_time: float):
    img = screen.capture_rect(screen.main_screen().rect)
    date = datetime.now().strftime("%Y-%m-%dT%H-%M-%S-%f")
    filename = f"{date}.png"
    path = directory / filename
    # NB: Writing the image to the file is expensive so we do it asynchronously
    cron.after("50ms", lambda: img.write_file(path))

    return {
        "filename": filename,
        "timestamp": time.perf_counter() - start_time,
    }


def extract_decorated_marks(parsed: Iterable[list[Any]]):
    for capture_list in parsed:
        for capture in capture_list:
            try:
                type = capture["type"]
            except (IndexError, TypeError):
                continue

            if type not in {"primitive", "list", "range"}:
                continue

            yield from extract_decorated_marks_from_target(capture)


def extract_decorated_marks_from_target(target: dict):
    type = target["type"]

    if type == "primitive":
        yield from extract_decorated_marks_from_primitive_target(target)
    elif type == "range":
        yield from extract_decorated_marks_from_primitive_target(target["start"])
        yield from extract_decorated_marks_from_primitive_target(target["end"])
    elif type == "list":
        for element in target["elements"]:
            yield from extract_decorated_marks_from_target(element)


def extract_decorated_marks_from_primitive_target(target: dict):
    try:
        mark = target["mark"]
    except IndexError:
        return

    if mark["type"] == "decoratedSymbol":
        yield mark


last_phrase = None


def on_phrase(j):
    actions.user.maybe_capture_phrase(j)


def on_post_phrase(j):
    actions.user.maybe_capture_post_phrase(j)


speech_system.register("pre:phrase", on_phrase)
speech_system.register("post:phrase", on_post_phrase)
