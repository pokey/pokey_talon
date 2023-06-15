from talon import Context, Module, actions, settings

mod = Module()
ctx = Context()
ctx.matches = r"""
tag: user.typescript
"""

ctx.lists["user.code_type"] = {
    "bool": "boolean",
    "integer": "int",
    "string": "string",
    "null": "null",
    "undefined": "undefined",
    "unknown": "unknown",
    "number": "number",
    "numb": "number",
    "any": "any",
    "never": "never",
    "void": "void",
}

mod.list("code_typescript_keyword", desc="List of extra keywords for typescript")
ctx.lists["user.code_typescript_keyword"] = {
    "cast": " as ",
    "extends": " extends ",
    "implements": " implements ",
    "satisfies": " satisfies ",
    "interface": "interface ",
    "readonly": "readonly ",
    "type": "type ",
    "type of": "typeof ",
    "key of": "keyof ",
}


@mod.capture(rule=("{user.code_keyword} | {user.code_typescript_keyword}"))
def code_keyword(m) -> str:
    return str(m)


@ctx.action_class("user")
class UserActions:
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

    def code_protected_function(text: str):
        result = "protected function {}".format(
            actions.user.formatted_text(
                text, settings.get("user.code_protected_function_formatter")
            )
        )

        actions.user.code_insert_function(result, None)

    def code_public_function(text: str):
        result = "public function {}".format(
            actions.user.formatted_text(
                text, settings.get("user.code_public_function_formatter")
            )
        )

        actions.user.code_insert_function(result, None)

    def code_insert_type_annotation(type: str):
        actions.insert(f": {type}")

    def code_insert_return_type(type: str):
        actions.insert(f": {type}")
