# https://help.github.com/en/github/getting-started-with-github/keyboard-shortcuts
tag: browser
win.title: /github.com/
-

# site wide shortcuts
focus search: key(s)
go to notifications: insert("gn")
go to dashboard: insert("gd")
show keyboard shortcuts: key(?)
move selection down: key(j)
move selection up: key(k)
toggle selection: key(x)
open selection: key(o)

# repositories
go to code: insert("gc")
go to issues: insert("gi")
go to pull requests: insert("gp")
go to wiki: insert("gw")

# network graph

# source code browsing
find file: key(t)
jump to line: key(l)
switch (branch|tag): key(w)
expand url: key(y)
(show|hide) [all] in line notes: key(i)

# issues
create [an] issue: key(c)
search (issues|[pull] requests): key(/)
(filter by|edit) labels: key(l)
(filter by|edit) milestones: key(m)
(filter by|edit) assignee: key(a)
reply: key(r)
submit comment: key(ctrl-enter)
preview comment: key(ctrl-shift-p)
#go fullscreen: key(ctrl-shift-l)
git hub full screen: key(ctrl-shift-l)

# browsing commit
#submit comment: key(ctrl-enter)
close form: key(escape)
parent commit: key(p)
other parent commit: key(o)

# commit list
#expand url: key(y)

# notifications
mark as read: key(y)
mute thread: key(shift-m)

# pull request list
open issue: key(o)

project <user.text>:
    key(i p)
    sleep(700ms)
    "{user.text}"
    sleep(700ms)
    key(down enter escape)
    sleep(700ms)

assign <user.text>:
    key(i a)
    sleep(250ms)
    "{user.text}"
    sleep(250ms)
    key(down enter escape)
    sleep(250ms)

label <user.text>:
    key(i l)
    sleep(250ms)
    "{user.text}"
    sleep(250ms)
    key(down enter escape)
    sleep(250ms)

milestone <user.number_string>:
    key(i m)
    sleep(250ms)
    "{user.number_string}"
    sleep(250ms)
    key(down enter escape)
    sleep(250ms)

milestone <user.text>:
    key(i m)
    sleep(250ms)
    "{user.text}"
    sleep(250ms)
    key(down enter escape)
    sleep(250ms)