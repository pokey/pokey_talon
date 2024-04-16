import os
from posixpath import expanduser

with open(expanduser("~/envs/openai/OPENAI_API_KEY"), "r") as f:
    os.environ["OPENAI_API_KEY"] = f.read().strip()
