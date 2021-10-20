mode: command
and mode: user.ruby
mode: command
and mode: user.auto_lang
and code.language: ruby
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
    
^funky <user.text>$: user.code_default_function(text)

args pipe:
    insert("||")
    key(left)
    
<user.operator> do: "do "
<user.operator> end: "end"
<user.operator> begin: "begin"
<user.operator> rescue: "rescue "
<user.operator> module: "module "
^instance <user.text>$:
    insert("@")
    user.code_public_variable_formatter(text)
