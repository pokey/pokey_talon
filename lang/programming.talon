tag: user.code_generic
-
block: user.code_block()

#todo should we have a keyword list? type list capture? stick with "word"?
<user.operator> in: insert(" in ")
is not (none|null): user.code_is_not_null()
is (none|null): user.code_is_null()
#todo: types?
#word (dickt | dictionary): user.code_type_dictionary()
<user.operator> if: user.code_state_if()
<user.operator> else if: user.code_state_else_if()
<user.operator> else: user.code_state_else()
<user.operator> self: user.code_self()
#todo: this is valid for many languages,
# but probably not all
self point:
    user.code_self()
    insert(".")
<user.operator> while: user.code_state_while()
<user.operator> for: user.code_state_for()
<user.operator> for in: user.code_state_for_each()
<user.operator> switch: user.code_state_switch()
<user.operator> case: user.code_state_case()
<user.operator> do: user.code_state_do()
<user.operator> goto: user.code_state_go_to()
<user.operator> return: user.code_state_return()
<user.operator> import: user.code_import()
from import: user.code_from_import()
<user.operator> class: user.code_type_class()
<user.operator> include: user.code_include()
<user.operator> include system: user.code_include_system()
<user.operator> include local: user.code_include_local()
<user.operator> type deaf: user.code_type_definition()
<user.operator> type deaf struct: user.code_typedef_struct()
<user.operator> (no | nil | null): user.code_null()
<user.operator> break: user.code_break()
<user.operator> next: user.code_next()
<user.operator> true: user.code_true()
<user.operator> false: user.code_false()

# show and print functions and libraries
toggle funk: user.code_toggle_functions()
funk <user.code_functions>:
    user.code_insert_function(code_functions, "")
funk cell <number>:
    user.code_select_function(number - 1, "")
funk wrap <user.code_functions>:
    user.code_insert_function(code_functions, edit.selected_text())
funk wrap <number>:
    user.code_select_function(number - 1, edit.selected_text())
dock string: user.code_document_string()

# for annotating function parameters
is type {user.code_type}: user.code_insert_type_annotation(code_type)
returns [type] {user.code_type}: user.code_insert_return_type(code_type)
# for generic reference of types
type {user.code_type}: insert("{code_type}")