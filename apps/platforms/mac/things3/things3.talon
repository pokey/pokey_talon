app: things3
-
tag(): user.todo_list

new task: key(cmd-n)
<user.teleport> tag {user.things_tag}: user.show_tag(things_tag)
<user.teleport> list {user.things_project}: user.show_things_list(things_project)

follow link: key(cmd-alt-enter)

tag this <user.things_tags>:
    user.tag_todo(things_tags)
    sleep(100ms)
move this [to] {user.things_project}:
    user.move_todo(things_project)
    sleep(100ms)
move this [to] inbox:
    user.move_todo("Inbox")
    sleep(100ms)

do this today: key(cmd-t)
do this evening: key(cmd-e)
do this (anytime | any time): key(cmd-r)
do this someday: key(cmd-o)
do this <user.text>:
    key(cmd-s)
    insert(text)
    key(enter)

deadline <user.text>:
    key(cmd-shift-d)
    insert(text)
    key(enter)

repeat this:
    key(cmd-shift-r)

clear deadline:
    key(cmd-shift-d backspace enter)

filter [tag] <user.things_tags>: user.filter_by_tag(things_tags)
clear filter: key(ctrl-escape)

add checklist: key(cmd-shift-c)

drag [this] way up: key(cmd-alt-up)
drag [this] way down: key(cmd-alt-down)
drag [this] up: key(cmd-up)
drag [this] down: key(cmd-down)
