# Commands only active when editing a prompt draft in VS Code

mode: user.sketch
and not mode: sleep
app: vscode
win.filename: /PROMPT_DRAFT.md/
-

# Process arbitrary prose when spoken and insert it directly
# This allows dictation-like behavior without switching to dictation mode
<user.prose>: user.dictation_insert(prose)

# Quick formatting commands
boom: key(. space)
spam: key(, space)
clap$: key(enter)

# Command to save the prompt to clipboard and backup the file
prom save | draft save: user.prompt_save()
prom sketch:
    user.prompt_save()
    user.run_rpc_command("workbench.action.tasks.runTask", "sketch clipboard")
prom sketch branch:
    user.prompt_save()
    user.run_rpc_command("workbench.action.tasks.runTask", "sketch clipboard in worktree")
