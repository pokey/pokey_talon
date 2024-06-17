# Zoom
zoom in: edit.zoom_in()
zoom out: edit.zoom_out()
zoom reset: edit.zoom_reset()

# Searching
find it: edit.find()
next one: edit.find_next()

# Navigation

# The reason for these spoken forms is that "page up" and "page down" are globally defined as keys.
scroll up: edit.page_up()
scroll down: edit.page_down()

drain: edit.word_left()
drain <number_small> times: user.words_left(number_small)
step: edit.word_right()
step <number_small> times: user.words_right(number_small)

tug: edit.left()
tug <number_small> times: user.left_n(number_small)
push: edit.right()
push <number_small> times: user.right_n(number_small)
north: edit.up()
north <number_small> times: user.up_n(number_small)
south: edit.down()
south <number_small> times: user.down_n(number_small)

go line start | head: edit.line_start()
go line end | tail: edit.line_end()

go way left:
    edit.line_start()
    edit.line_start()
go way right: edit.line_end()
go way up: edit.file_start()
go way down: edit.file_end()

go top: edit.file_start()
go bottom: edit.file_end()

go page up: edit.page_up()
go page down: edit.page_down()

# Selecting
select all: edit.select_all()
# select line: edit.select_line()
# select line start: user.select_line_start()
# select line end: user.select_line_end()

# select left: edit.extend_left()
# select right: edit.extend_right()
# select up: edit.extend_line_up()
# select down: edit.extend_line_down()

# select word: edit.select_word()
# select word left: edit.extend_word_left()
# select word right: edit.extend_word_right()

# select way left: edit.extend_line_start()
# select way right: edit.extend_line_end()
# select way up: edit.extend_file_start()
# select way down: edit.extend_file_end()

# Indentation
indent [more]: edit.indent_more()
(indent less | out dent): edit.indent_less()

# Delete
<user.delete> all: user.delete_all()
# clear line: edit.delete_line()
# clear line start: user.delete_line_start()
# clear line end: user.delete_line_end()
# clear left: edit.delete()
# clear right: user.delete_right()

scratch <number_small> times: user.delete_left_n(number_small)
drill <number_small> times: user.delete_right_n(number_small)

# clear up:
#     edit.extend_line_up()
#     edit.delete()

# clear down:
#     edit.extend_line_down()
#     edit.delete()

# clear word: edit.delete_word()

scratcher: user.delete_word_left_n(1)
scratcher <number_small> times: user.delete_word_left_n(number_small)

swallow: user.delete_word_right_n(1)
swallow <number_small> times: user.delete_word_right_n(number_small)

# clear way left:
#     edit.extend_line_start()
#     edit.delete()

# clear way right:
#     edit.extend_line_end()
#     edit.delete()

<user.delete> way up:
    edit.extend_file_start()
    edit.delete()

<user.delete> way down:
    edit.extend_file_end()
    edit.delete()

# Copy
copy that: edit.copy()
copy all: user.copy_all()
# copy line: user.copy_line()
# copy line start: user.copy_line_start()
# copy line end: user.copy_line_end()
# copy word: user.copy_word()
# copy word left: user.copy_word_left()
# copy word right: user.copy_word_right()

#to do: do we want these variants, seem to conflict
# copy left:
#      edit.extend_left()
#      edit.copy()
# copy right:
#     edit.extend_right()
#     edit.copy()
# copy up:
#     edit.extend_up()
#     edit.copy()
# copy down:
#     edit.extend_down()
#     edit.copy()

# Cut
cut that: edit.cut()
cut all: user.cut_all()
# cut line: user.cut_line()
# cut line start: user.cut_line_start()
# cut line end: user.cut_line_end()
# cut word: user.cut_word()
# cut word left: user.cut_word_left()
# cut word right: user.cut_word_right()

#to do: do we want these variants
# cut left:
#      edit.select_all()
#      edit.cut()
# cut right:
#      edit.select_all()
#      edit.cut()
# cut up:
#      edit.select_all()
#     edit.cut()
# cut down:
#     edit.select_all()
#     edit.cut()

# Paste
(pace | paste) that: edit.paste()
# (pace | paste) enter:
#     edit.paste()
#     key(enter)
paste match: edit.paste_match_style()
# (pace | paste) all: user.paste_all()
# (pace | paste) line: user.paste_line()
# (pace | paste) line start: user.paste_line_start()
# (pace | paste) line end: user.paste_line_end()
# (pace | paste) word: user.paste_word()

show clip:
    key(cmd-shift-v)
    sleep(100ms)
# (pace | paste) <user.ordinals_small>:
#     key(cmd-shift-v)
#     sleep(100ms)
#     insert("{user.ordinals_small}")
#     sleep(100ms)
# (pace | paste) rough <number_small>:
#     key(cmd-shift-v)
#     sleep(100ms)
#     key("alt-{number_small}")

# Duplication
# clone that: edit.selection_clone()
# clone line: edit.line_clone()

# Insert new line
# new line above: edit.line_insert_up()
# new line below | slap: edit.line_insert_down()

# Insert padding with optional symbols
(pad | padding): user.insert_between(" ", " ")
# (pad | padding) <user.symbol_key>+:
#     insert(" ")
#     user.insert_many(symbol_key_list)
#     insert(" ")

# Undo/redo
(undo that | nope | blast): edit.undo()
(redo that | yes indeed): edit.redo()

# Save
disk: edit.save()
disk oliver: edit.save_all()

pour: edit.line_insert_down()
drink: edit.line_insert_up()

emoji scout [<user.text>]:
    key(cmd-ctrl-space)
    sleep(200ms)
    insert(user.text or "")
