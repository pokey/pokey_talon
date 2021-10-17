app: chrome
-

fill password: user.fill_password()
<user.teleport> tab: key("escape ^")
<user.teleport> tab <user.text> [halt]:
    key("escape shift-t")
    sleep(100ms)
    "{text}"
    sleep(100ms)
    key("enter")
<user.find> tab <user.text> [halt]:
    key("escape shift-t")
    sleep(100ms)
    "{text}"
    sleep(100ms)