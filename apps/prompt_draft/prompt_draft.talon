# Commands for creating a new prompt draft

prom draft [<user.text>]$:
    user.prompt_draft()
    user.insert_formatted(text or "", "CAPITALIZE_FIRST_WORD")

prom draft issue:
    user.prompt_draft()
    insert("Implement ")
    sleep(150ms)
    edit.paste()
    insert(". Use gh cli to look up issue, being sure to look at comments.")

prom draft talon:
    user.prompt_draft()
    insert(". You can find documentation about Talon in ~/src/talon-wiki/docs/Customization/")
    edit.file_start()
