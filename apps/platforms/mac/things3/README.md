# Experimental Things support

Provides deep integration with the [Things](https://culturedcode.com/things/) todo list manager, exposing commands to interact with lists, tags, projects, etc. In order to populate lists based on your Things database, relies on the [`things3-api` Python package](https://pypi.org/project/things3-api/).

Note that Things is Mac only.

## Prerequisites

You must install `things3-api` into your Talon pip enviroment:

```bash
~/.talon/bin/pip install things3-api
```

## Available commands

See [`things3.talon`](./things3.talon)
