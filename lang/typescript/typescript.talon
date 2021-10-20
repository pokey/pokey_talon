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
    user.code_typename_formatter = "PUBLIC_CAMEL_CASE"

is loose equal: " == "
is not loose equal: " != "
<user.operator> null coal: " ?? "
<user.operator> cast: " as "

<user.operator> throw: "throw "
<user.operator> const: "const "

<user.operator> let: "let "

<user.operator> var: "var "

<user.operator> async: "async "

<user.operator> await: "await "

<user.operator> map:
    insert(".map()")
    key(left)
    
<user.operator> filter:
    insert(".filter()")
    key(left)
    
<user.operator> reduce:
  insert(".reduce()")
  key(left)

<user.operator> concat:
  insert(".concat()")
  key(left)

<user.operator> length: insert(".length")

<user.operator> log:
  insert("console.log()")
  key(left)

<user.operator> quote var:
  insert("${}")
  key(left)

<user.operator> spread: "..."
<user.operator> type: "type "
<user.operator> extends: " extends "
<user.operator> interface: "interface "
<user.operator> cast: " as "

funky <user.text>$: user.code_default_function(text)
pro funky <user.text>$: user.code_protected_function(text)
pub funky <user.text>$: user.code_public_function(text)

<user.operator> new: insert("new ")  

<user.operator> export: "export "
<user.operator> export const: "export const "
<user.operator> export default: "export default "
<user.operator> try: "try "