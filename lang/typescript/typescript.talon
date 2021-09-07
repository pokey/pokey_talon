mode: command
and mode: user.typescript
mode: command
and mode: user.auto_lang
and code.language: typescript
-
tag(): user.code_operators
tag(): user.code_comment
tag(): user.code_generic

settings():
    user.code_private_function_formatter = "PRIVATE_CAMEL_CASE"
    user.code_protected_function_formatter = "PRIVATE_CAMEL_CASE"
    user.code_public_function_formatter = "PRIVATE_CAMEL_CASE"
    user.code_private_variable_formatter = "PRIVATE_CAMEL_CASE"
    user.code_protected_variable_formatter = "PRIVATE_CAMEL_CASE"
    user.code_public_variable_formatter = "PRIVATE_CAMEL_CASE"

is loose equal: " == "
is not loose equal: " != "
<user.operator> null coal: " ?? "
<user.operator> cast: " as "

state throw: "throw "
state const: "const "

state let: "let "

state var: "var "

state async: "async "

<user.operator> await: "await "

state map:
    insert(".map()")
    key(left)
    
state filter:
    insert(".filter()")
    key(left)
    
state reduce:
  insert(".reduce()")
  key(left)

state concat:
  insert(".concat()")
  key(left)

state length: insert(".length")

state log:
  insert("console.log()")
  key(left)

state quote var:
  insert("${}")
  key(left)

state spread: "..."

funky <user.text>$: user.code_default_function(text)
pro funky <user.text>$: user.code_protected_function(text)
pub funky <user.text>$: user.code_public_function(text)

<user.operator> new: insert("new ")  
