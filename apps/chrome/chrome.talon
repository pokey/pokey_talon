app: chrome
-
tag(): browser
tag(): user.tabs

fill password: user.fill_password()

profile switch: user.chrome_mod("shift-m")

<user.show_list> tab: user.chrome_mod("shift-a")

<user.show_list> tab <user.text> [halt]:
    user.chrome_mod("shift-a")
    sleep(400ms)
    insert("{text}")
    sleep(100ms)
<user.teleport> tab <user.text> [halt]:
    user.chrome_mod("shift-a")
    sleep(400ms)
    insert("{text}")
    sleep(100ms)
    key("enter")
