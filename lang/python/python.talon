mode: command
and mode: user.python
mode: command
and mode: user.auto_lang
and code.language: python
-
tag(): user.code_operators
tag(): user.code_comment
tag(): user.code_generic
settings():
    user.code_private_function_formatter = "SNAKE_CASE"
    user.code_protected_function_formatter = "SNAKE_CASE"
    user.code_public_function_formatter = "SNAKE_CASE"
    user.code_private_variable_formatter = "SNAKE_CASE"
    user.code_protected_variable_formatter = "SNAKE_CASE"
    user.code_public_variable_formatter = "SNAKE_CASE"

#python-specific grammars
dunder in it: "__init__"
<user.operator> (def | deaf | deft): "def "
<user.operator> try: "try:\n"
<user.operator> except: "except "
<user.operator> raise: "raise "
self taught: "self."
pie test: "pytest"
<user.operator> past: "pass"
<user.operator> not: "not "
<user.operator> global: "global "

raise {user.python_exception}: user.insert_cursor("raise {python_exception}([|])")
except {user.python_exception}: "except {python_exception}:"

dock {user.python_docstring_fields}:
    insert("{python_docstring_fields}")
    edit.left()
dock type {user.code_type}:
    user.insert_cursor(":type [|]: {code_type}")
dock returns type {user.code_type}:
    user.insert_cursor(":rtype [|]: {code_type}")
toggle imports: user.code_toggle_libraries()
import <user.code_libraries>:
    user.code_insert_library(code_libraries, "")
    key(end enter)

for <user.text> in:
    insert("for  in ")
    key(left:4)
    user.code_public_variable_formatter(text)
    key(right:4)