tag: user.go
-
variadic: "..."
logical and: " && "
logical or: " || "
# Many of these add extra terrible spacing under the assumption that
# gofmt/goimports will erase it.
<user.operator> comment: "// "
[line] comment <user.text>:
    key("cmd-right")
    insert(" // ")
    insert(user.formatted_text(text, "sentence"))

# "add comment <user.text> [over]:
#     key("cmd-right")
#     text_with_leading(" // ")
# ]
# "[<user.operator>] context: insert("ctx")
<user.operator> (funk | func | fun): "func "
function (Annette | init) [over]: "func init() {\n"
function <user.text> [over]:
    insert("func ")
    insert(user.formatted_text(text, "PRIVATE_CAMEL_CASE"))
    insert("(")
    sleep(100ms)

method <user.text> [over]:
    insert("meth ")
    insert(user.formatted_text(text, "PRIVATE_CAMEL_CASE"))
    sleep(100ms)

<user.operator> var: "var "
variable [<user.text>] [over]:
    insert("var ")
    insert(user.formatted_text(text, "PRIVATE_CAMEL_CASE"))
    # insert(" ")
    sleep(100ms)

of type [<user.text>] [over]:
    insert(" ")
    insert(user.formatted_text(text, "PRIVATE_CAMEL_CASE"))

# "set <user.text> [over]:
#     insert(user.formatted_text(text, "PRIVATE_CAMEL_CASE"))
#     insert(" := ")
#     sleep(100ms)
# ]
<user.operator> break: "break"
<user.operator> (chan | channel): " chan "
<user.operator> go: "go "
<user.operator> if: "if "
if <user.text> [over]:
    insert("if ")
    insert(user.formatted_text(text, "PRIVATE_CAMEL_CASE"))
spawn <user.text> [over]:
    insert("go ")
    insert(user.formatted_text(text, "PRIVATE_CAMEL_CASE"))
<user.operator> else if: " else if "
else if <user.text> [over]:
    insert(" else if ")
    insert(user.formatted_text(text, "PRIVATE_CAMEL_CASE"))

<user.operator> else: " else "
else <user.text> [over]:
    insert(" else {")
    key("enter")
    insert(user.formatted_text(text, "PRIVATE_CAMEL_CASE"))

<user.operator> while: "while "
while <user.text> [over]:
    insert("while ")
    insert(user.formatted_text(text, "PRIVATE_CAMEL_CASE"))

<user.operator> for: "for "
for <user.text> [over]:
    insert("for ")
    insert(user.formatted_text(text, "PRIVATE_CAMEL_CASE"))

<user.operator> for range: "forr "
range <user.text> [over]:
    insert("forr ")
    insert(user.formatted_text(text, "PRIVATE_CAMEL_CASE"))

<user.operator> format: "fmt"
format <user.text> [over]:
    insert("fmt.")
    insert(user.formatted_text(text, "PUBLIC_CAMEL_CASE"))

<user.operator> switch: "switch "
switch <user.text> [over]:
    insert("switch ")
    insert(user.formatted_text(text, "PRIVATE_CAMEL_CASE"))

<user.operator> select: "select "
# "select <user.text>:insert("select "), insert(user.formatted_text(text, "PRIVATE_CAMEL_CASE")]
<user.operator> (const | constant): " const "
constant <user.text> [over]:
    insert("const ")
    insert(user.formatted_text(text, "PUBLIC_CAMEL_CASE"))

<user.operator> case: " case "
<user.operator> default: " default:"
case <user.text> [over]:
    insert("case ")
    insert(user.formatted_text(text, "PRIVATE_CAMEL_CASE"))

<user.operator> type: " type "
type <user.text> [over]:
    insert("type ")
    insert(user.formatted_text(text, "PUBLIC_CAMEL_CASE"))
<user.operator> true: " true "
<user.operator> false: " false "
<user.operator> (start | struct | struck):
    insert(" struct {")
    key("enter")
(struct | struck) <user.text> [over]:
    insert(" struct {")
    key("enter")
    insert(user.formatted_text(text, "PUBLIC_CAMEL_CASE"))

[<user.operator>] empty interface: " interface{} "
<user.operator> interface:
    insert(" interface {")
    key("enter")
interface <user.text> [over]:
    insert(" interface {")
    key("enter")
    insert(user.formatted_text(text, "PUBLIC_CAMEL_CASE"))

<user.operator> string: " string "
[<user.operator>] (int | integer | ant): "int"
<user.operator> slice: " []"
slice of: "[]"
[<user.operator>] (no | nil): "nil"
<user.operator> (int | integer | ant) sixty four: " int64 "
<user.operator> tag: user.insert_between(" `", "`")
field tag <user.text> [over]:
    user.insert_between(" `", "`")
    sleep(100ms)
    insert(user.formatted_text(text, "snake"))
    insert(" ")
    sleep(100ms)

<user.operator> return: " return "
return <user.text> [over]:
    insert("return ")
    insert(user.formatted_text(text, "PRIVATE_CAMEL_CASE"))

map of string to string: " map[string]string "
map of <user.text> [over]:
    insert("map[")
    insert(user.formatted_text(text, "PRIVATE_CAMEL_CASE"))
    key("right")
    sleep(100ms)

receive: " <- "
make: "make("
loggers [<user.text>] [over]:
    insert("logrus.")
    insert(user.formatted_text(text, "PUBLIC_CAMEL_CASE"))

length <user.text> [over]:
    insert("len(")
    insert(user.formatted_text(text, "PRIVATE_CAMEL_CASE"))

append <user.text> [over]:
    insert("append(")
    insert(user.formatted_text(text, "PRIVATE_CAMEL_CASE"))

<user.operator> (air | err): "err"
error: " err "
loop over [<user.text>] [over]:
    insert("forr ")
    insert(user.formatted_text(text, "PRIVATE_CAMEL_CASE"))

item <user.text> [over]:
    insert(", ")
    insert(user.formatted_text(text, "PRIVATE_CAMEL_CASE"))

value <user.text> [over]:
    insert(": ")
    insert(user.formatted_text(text, "PRIVATE_CAMEL_CASE"))

address of [<user.text>] [over]:
    insert("&")
    insert(user.formatted_text(text, "PRIVATE_CAMEL_CASE"))

pointer to [<user.text>] [over]:
    insert("*")
    insert(user.formatted_text(text, "PRIVATE_CAMEL_CASE"))

swipe [<user.text>] [over]:
    key("right")
    insert(", ")
    insert(user.formatted_text(text, "PRIVATE_CAMEL_CASE"))
