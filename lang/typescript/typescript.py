from talon import Module, Context, actions, ui, imgui, settings

mod = Module()
ctx = Context()
ctx.matches = r"""
mode: user.typescript
mode: user.auto_lang 
and code.language: typescript
"""
# tbd

mod.list("code_chain_function", "Function to use in a chain")

ctx.lists["user.code_chain_function"] = {
    "concat": "concat",
    "filter": "filter",
    "find": "find",
    "flat map": "flatMap",
    "for each": "forEach",
    "map": "map",
    "push": "push",
    "some": "some",
    "split": "split",
    "substring": "substring",
}

ctx.lists["user.code_functions"] = {
    "entries": "Object.entries",
    "flatten": "flatten",
    "from entries": "Object.fromEntries",
    "keys": "Object.keys",
    "max": "Math.max",
    "min": "Math.min",
    "print": "console.log",
    "values": "Object.values",
    #     "integer": "int.TryParse",,
    #     "string": ".ToString",
}

ctx.lists["user.code_type"] = {
    "boolean": "boolean",
    "integer": "int",
    "string": "string",
    "null": "null",
    "undefined": "undefined",
    "unknown": "unknown",
    "number": "number",
    "any": "any",
}

ctx.lists["user.code_keyword"] = {
    "a sink": "async ",
    "await": "await ",
    "break": "break",
    "cast": " as ",
    "class": "class ",
    "const": "const ",
    "continue": "continue",
    "export": "export ",
    "extends": " extends ",
    "false": "false",
    "implements": " implements ",
    "import": "import ",
    "interface": "interface ",
    "let": "let ",
    "new": "new ",
    "null": "null",
    "private": "private ",
    "protected": "protected ",
    "public": "public ",
    "return": "return ",
    "throw": "throw ",
    "true": "true",
    "try": "try ",
    "type": "type ",
    "undefined": "undefined",
    "yield": "yield ",
}


@ctx.action_class("user")
class UserActions:
    def code_is_not_null():
        actions.auto_insert(" != null")

    def code_is_null():
        actions.auto_insert(" == null")

    def code_state_if():
        actions.insert("if ()")
        actions.key("left")

    def code_state_else_if():
        actions.insert(" else if ()")
        actions.key("left")

    def code_state_else():
        actions.insert(" else {}")
        actions.key("left enter")

    def code_block():
        actions.insert("{}")
        actions.key("left enter")

    def code_self():
        actions.auto_insert("this")

    def code_state_while():
        actions.insert("while ()")
        actions.key("left")

    def code_state_do():
        actions.insert("do ")

    def code_state_return():
        actions.insert("return ")

    def code_state_for():
        actions.insert("for ()")
        actions.key("left")

    def code_state_switch():
        actions.insert("switch ()")
        actions.key("left")

    def code_state_case():
        actions.auto_insert("case :")
        actions.key("left")

    def code_state_go_to():
        actions.auto_insert("")

    def code_import():
        actions.auto_insert("import ")

    def code_from_import():
        actions.insert(' from  ""')
        actions.key("left")

    def code_type_class():
        actions.auto_insert("class ")

    def code_include():
        actions.auto_insert("")

    def code_include_system():
        actions.auto_insert("")

    def code_include_local():
        actions.auto_insert("")

    def code_type_definition():
        actions.auto_insert("")

    def code_typedef_struct():
        actions.auto_insert("")

    def code_state_for_each():
        actions.insert(".forEach()")
        actions.key("left")

    def code_break():
        actions.auto_insert("break;")

    def code_next():
        actions.auto_insert("continue;")

    def code_true():
        actions.auto_insert("true")

    def code_false():
        actions.auto_insert("false")

    def code_null():
        actions.auto_insert("null")

    def code_operator_indirection():
        actions.auto_insert("")

    def code_operator_address_of():
        actions.auto_insert("")

    def code_operator_structure_dereference():
        actions.auto_insert("")

    def code_operator_lambda():
        actions.auto_insert(" => ")

    def code_operator_subscript():
        actions.insert("[]")
        actions.key("left")

    def code_operator_assignment():
        actions.auto_insert(" = ")

    def code_operator_subtraction():
        actions.auto_insert(" - ")

    def code_operator_subtraction_assignment():
        actions.auto_insert(" -= ")

    def code_operator_addition():
        actions.auto_insert(" + ")

    def code_operator_addition_assignment():
        actions.auto_insert(" += ")

    def code_operator_multiplication():
        actions.auto_insert(" * ")

    def code_operator_multiplication_assignment():
        actions.auto_insert(" *= ")

    def code_operator_exponent():
        actions.auto_insert(" ** ")

    def code_operator_division():
        actions.auto_insert(" / ")

    def code_operator_division_assignment():
        actions.auto_insert(" /= ")

    def code_operator_modulo():
        actions.auto_insert(" % ")

    def code_operator_modulo_assignment():
        actions.auto_insert(" %= ")

    def code_operator_equal():
        actions.auto_insert(" === ")

    def code_operator_not_equal():
        actions.auto_insert(" !== ")

    def code_operator_greater_than():
        actions.auto_insert(" > ")

    def code_operator_greater_than_or_equal_to():
        actions.auto_insert(" >= ")

    def code_operator_less_than():
        actions.auto_insert(" < ")

    def code_operator_less_than_or_equal_to():
        actions.auto_insert(" <= ")

    def code_operator_and():
        actions.auto_insert(" && ")

    def code_operator_or():
        actions.auto_insert(" || ")

    def code_operator_bitwise_and():
        actions.auto_insert(" & ")

    def code_operator_bitwise_and_assignment():
        actions.auto_insert(" &= ")

    def code_operator_bitwise_or():
        actions.auto_insert(" | ")

    def code_operator_bitwise_or_assignment():
        actions.auto_insert(" |= ")

    def code_operator_bitwise_exclusive_or():
        actions.auto_insert(" ^ ")

    def code_operator_bitwise_exclusive_or_assignment():
        actions.auto_insert(" ^= ")

    def code_operator_bitwise_left_shift():
        actions.auto_insert(" << ")

    def code_operator_bitwise_left_shift_assignment():
        actions.auto_insert(" <<= ")

    def code_operator_bitwise_right_shift():
        actions.auto_insert(" >> ")

    def code_operator_bitwise_right_shift_assignment():
        actions.auto_insert(" >>= ")

    def code_insert_function(text: str, selection: str):
        if selection:
            text = text + "({})".format(selection)
        else:
            text = text + "()"

        actions.user.paste(text)
        actions.edit.left()

    def code_private_function(text: str):
        """Inserts private function declaration"""
        result = "private function {}".format(
            actions.user.formatted_text(
                text, settings.get("user.code_private_function_formatter")
            )
        )

        actions.user.code_insert_function(result, None)

    def code_interface(text: str):
        """Inserts interface declaration"""
        type_name = actions.user.formatted_text(
            text, settings.get("user.code_typename_formatter")
        )
        actions.insert(f"interface {type_name} {{}}")
        actions.key("left enter")

    # def code_private_static_function(text: str):
    #     """Inserts private static function"""
    #     result = "private static void {}".format(
    #         actions.user.formatted_text(
    #             text, settings.get("user.code_private_function_formatter")
    #         )
    #     )

    #     actions.user.code_insert_function(result, None)

    def code_protected_function(text: str):
        result = "protected function {}".format(
            actions.user.formatted_text(
                text, settings.get("user.code_protected_function_formatter")
            )
        )

        actions.user.code_insert_function(result, None)

    # def code_protected_static_function(text: str):
    #     result = "protected static void {}".format(
    #         actions.user.formatted_text(
    #             text, settings.get("user.code_protected_function_formatter")
    #         )
    #     )

    #     actions.user.code_insert_function(result, None)

    def code_public_function(text: str):
        result = "public function {}".format(
            actions.user.formatted_text(
                text, settings.get("user.code_public_function_formatter")
            )
        )

        actions.user.code_insert_function(result, None)

    # def code_public_static_function(text: str):
    #     result = "public static void {}".format(
    #         actions.user.formatted_text(
    #             text, settings.get("user.code_public_function_formatter")
    #         )
    #     )

    #     actions.user.code_insert_function(result, None)

    def code_insert_type_annotation(type: str):
        actions.insert(f": {type}")

    def code_insert_return_type(type: str):
        actions.insert(f" => {type}")
