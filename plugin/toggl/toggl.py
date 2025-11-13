import json
from base64 import b64encode
from datetime import datetime, timezone
from pathlib import Path
from typing import Optional

import requests
from talon import Module, actions, app

API_TOKEN = Path("~/envs/toggl/TOGGL_API_TOKEN").expanduser().read_text().strip()

# FIXME: This should be a setting
WORKSPACE_ID = 8497458

# FIXME: We should support custom projects in a map returned by an action
projects = {
    "coding": 203834862,
    "meetings": 203834863,
    "middleware": 214174007,
    "brm-agent": 214712767,
}


headers = {
    "Content-Type": "application/json",
    "Authorization": "Basic " + b64encode(f"{API_TOKEN}:api_token".encode()).decode(),
}


def start_time_entry(description: str, project_id: int) -> dict:
    url = f"https://api.track.toggl.com/api/v9/workspaces/{WORKSPACE_ID}/time_entries"

    data = {
        "description": description,
        "start": datetime.now(timezone.utc).isoformat(timespec="seconds"),
        "created_with": "Talon",
        "project_id": project_id,
        "workspace_id": WORKSPACE_ID,
        "duration": -1,
    }

    response = requests.post(url, headers=headers, data=json.dumps(data))
    response.raise_for_status()
    return response.json()


class NoCurrentTimeEntry(Exception):
    pass


def stop_time_entry() -> dict:
    current_entry = get_current_time_entry()
    if current_entry is None:
        raise NoCurrentTimeEntry("No current time entry found")
    print(current_entry)
    id = current_entry["id"]

    url = f"https://api.track.toggl.com/api/v9/workspaces/{WORKSPACE_ID}/time_entries/{id}/stop"
    response = requests.patch(url, headers=headers)
    stopped_entry = response.json()
    response.raise_for_status()
    print(stopped_entry)

    return stopped_entry


def get_current_time_entry() -> Optional[dict]:
    url = "https://api.track.toggl.com/api/v9/me/time_entries/current"
    response = requests.get(url, headers=headers)
    response.raise_for_status()
    return response.json()


mod = Module()


@mod.action_class
class Actions:
    def start_time_entry(description: str, project_name: str):
        """Start a new time entry"""
        try:
            stopped_entry = stop_time_entry()
            app.notify(f"Stopped time entry: {stopped_entry['description']}")
        except NoCurrentTimeEntry:
            pass

        try:
            formatted = actions.user.formatted_text(
                description, "CAPITALIZE_FIRST_WORD"
            )
            response = start_time_entry(
                formatted, project_id=projects[project_name.lower()]
            )
            print(response)
            app.notify(f"Started time entry: {response['description']}")
        except Exception as e:
            app.notify(f"Failed to start time entry: {e}")
            raise

    def stop_time_entry():
        """Stop the current time entry"""
        try:
            response = stop_time_entry()
            print(response)
            app.notify(f"Stopped time entry: {response['description']}")
        except Exception as e:
            app.notify(f"Failed to stop time entry: {e}")
            raise
