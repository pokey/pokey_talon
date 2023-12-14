# VSCode Copilot

This directory contains some very experimental commands for interacting with Copilot.

## Inline chat / refactoring / code generation

There are some commands to interact with the inline chat:

| Command                               | Description                                                                                                 |
| ------------------------------------- | ----------------------------------------------------------------------------------------------------------- |
| `"pilot chat"`                        | Opens chat to enable typing                                                                                 |
| `"pilot chat hello world"`            | Opens chat, types "hello world" and hits enter                                                              |
| `"pilot bring first"`                 | Inserts first code block in most recent chat response into your editor at cursor position                   |
| `"pilot copy first"`                  | Copies first code block in most recent chat response                                                        |
| `"pilot bring second last"`           | Inserts second-to-last code block in most recent chat response into your editor at cursor position          |
| `"pilot bring first after state air"` | Inserts first code block in most recent chat response into your editor after statement containing air token |
| `"pilot bring first to funk"`         | Replaces function containing your cursor with first code block in most recent chat response                 |
| `"pilot change funk air"`             | Selects function containing air token and opens inline chat to enable typing instructions                   |
| `"pilot change funk air to <phrase>"` | Tells Copilot to apply the instructions in `<phrase>` to the function containing air token                  |
| `"pilot test funk air"`               | Asks Copilot to generate a test for the function containing air token                                       |
| `"pilot doc funk air"`                | Asks Copilot to generate documentation for the function containing air token                                |
| `"pilot fix funk air"`                | Tells Copilot to fix the function containing air token                                                      |
| `"pilot fix funk air to <phrase>"`    | Tells Copilot to fix the function containing air token using the instructions in `<phrase>`                 |
| `"pilot make <phrase>"`               | Tells Copilot to generate code using the instructions in `<phrase>`, at the current cursor position         |

## Chat sidebar

There are some commands to interact with the chat sidebar:

| Command                               | Description                                                                                                 |
| ------------------------------------- | ----------------------------------------------------------------------------------------------------------- |
| `"pilot chat"`                        | Opens chat to enable typing                                                                                 |
| `"pilot chat hello world"`            | Opens chat, types "hello world" and hits enter                                                              |
| `"pilot bring first"`                 | Inserts first code block in most recent chat response into your editor at cursor position                   |
| `"pilot copy first"`                  | Copies first code block in most recent chat response                                                        |
| `"pilot bring second last"`           | Inserts second-to-last code block in most recent chat response into your editor at cursor position          |
| `"pilot bring first after state air"` | Inserts first code block in most recent chat response into your editor after statement containing air token |
| `"pilot bring first to funk"`         | Replaces function containing your cursor with first code block in most recent chat response                 |
