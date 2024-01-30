code.language: markdown
-
level one:
    edit.line_start()
    "# "
level two:
    edit.line_start()
    "## "
level three:
    edit.line_start()
    "### "
level four:
    edit.line_start()
    "#### "
level five:
    edit.line_start()
    "##### "
level six:
    edit.line_start()
    "###### "

list [one]:
    edit.line_start()
    "- "
list two:
    edit.line_start()
    "    - "
list three:
    edit.line_start()
    "        - "
list four:
    edit.line_start()
    "            - "
list five:
    edit.line_start()
    "                - "
list six:
    edit.line_start()
    "                    - "

{user.markdown_code_block_language} block:
    user.insert_snippet("```{markdown_code_block_language}\n$0\n```")

pour task:
    edit.line_end()
    edit.line_insert_down()
    "- [ ] "

link:
    "[]()"
    key(left:3)
