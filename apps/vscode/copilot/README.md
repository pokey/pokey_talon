# VSCode Copilot

This directory contains some very experimental commands for interacting with Copilot.

## Inline chat / refactoring / code generation

There are some commands to interact with the inline chat:

- `"pilot change funk air"` selects function containing air token and opens inline chat to enable typing instructions for how Copilot should change the function.
- `"pilot change funk air to <phrase>"`: tells Copilot to apply the instructions in `<phrase>` to the function containing air token. For example, `"pilot change funk air to remove arguments"`.
- `"pilot test funk air"`: Asks copilot to generate a test for the function containing air token.
- `"pilot doc funk air"`: Asks copilot to generate documentation for the function containing air token.
- `"pilot fix funk air"`: Tells copilot to fix the function containing air token.
- `"pilot fix funk air to <phrase>"`: Tells copilot to fix the function containing air token using the instructions in `<phrase>`. For example, `"pilot fix funk air to remove warnings"`.
- `"pilot make <phrase>"`: Tells copilot to generate code using the instructions in `<phrase>`, at the current cursor position. For example, `"pilot make a function that returns the sum of two numbers"`.

## Chat sidebar

There are some commands to interact with the chat sidebar:

- `"pilot chat"`: opens chat to enable typing
- `"pilot chat hello world"`: opens chat, types "hello world" and hits enter
- `"pilot bring first"`: inserts first code block in most recent chat response into your editor at cursor position
- `"pilot copy first"`: copies first code block in most recent chat response
- `"pilot bring second last"`: inserts second-to-last code block in most recent chat response into your editor at cursor position
- `"pilot bring first after state air"`: inserts first code block in most recent chat response into your editor after statement containing air token
- `"pilot bring first to funk"`: replaces function containing your cursor with first code block in most recent chat response
