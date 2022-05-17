app: chrome
-

fill password: user.fill_password()
<user.teleport> tab: key("cmd-shift-a")
<user.teleport> tab <user.text> [halt]:
    key("cmd-shift-a")
    sleep(400ms)
    "{text}"
    sleep(100ms)
    key("enter")
<user.show_list> tab <user.text> [halt]:
    key("cmd-shift-a")
    sleep(400ms)
    "{text}"
    sleep(100ms)
