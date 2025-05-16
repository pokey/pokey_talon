tag: browser
-
press <user.letter>: key(letter)
address bar | go address | go url: browser.focus_address()
go page | page focus: browser.focus_page()
address copy | url copy | copy address | copy url:
    browser.focus_address()
    sleep(50ms)
    edit.copy()
go home: browser.go_home()
[go] forward: browser.go_forward()
go (back | backward): browser.go_back()
go to {user.website}: browser.go(website)
go private: browser.open_private_window()

bookmark it: browser.bookmark()
bookmark tabs: browser.bookmark_tabs()
bookmark link active:
    address = browser.address()
    clip.set_text(address)
    user.system_command("code ~/notes")
    user.run_rpc_command("workbench.action.tasks.runTask", "Add note for URL")
(refresh | reload) it: browser.reload()
(refresh | reload) it hard: browser.reload_hard()

bookmark show: browser.bookmarks()
bookmark bar [show]: browser.bookmarks_bar()
downloads show: browser.show_downloads()
extensions show: browser.show_extensions()
history show: browser.show_history()
cache show: browser.show_clear_cache()
dev tools [show]: browser.toggle_dev_tools()

# Legacy [verb noun] commands to be removed at a later time
show downloads: browser.show_downloads()
show extensions: browser.show_extensions()
show history: browser.show_history()
show cache: browser.show_clear_cache()

(passwordless | password list) <user.text>:
    key(cmd-.)
    sleep(300ms)
    insert("{text}")

password pop <user.text>:
    key(cmd-.)
    sleep(300ms)
    insert("{text}")
    sleep(250ms)
    key(enter)
