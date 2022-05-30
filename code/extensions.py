from talon import Context, Module

from .user_settings import get_list_from_csv

mod = Module()
mod.list("file_extension", desc="A file extension, such as .py")

_file_extensions_defaults = {
    "point pie": ".py",
    "point talon": ".talon",
    "point mark down": ".md",
    "point shell": ".sh",
    "point vim": ".vim",
    "point see": ".c",
    "point see sharp": ".cs",
    "point com": ".com",
    "point net": ".net",
    "point org": ".org",
    "point us": ".us",
    "point U S": ".us",
    "point exe": ".exe",
    "point bin": ".bin",
    "point bend": ".bin",
    "point jason": ".json",
    "point jay son": ".json",
    "point J S": ".js",
    "point java script": ".js",
    "point TS": ".ts",
    "point type script": ".ts",
    "point csv": ".csv",
    "totssv": ".csv",
    "tot csv": ".csv",
    "point cassie": ".csv",
    "point text": ".txt",
}

file_extensions = get_list_from_csv(
    "file_extensions.csv",
    headers=("File extension", "Name"),
    default=_file_extensions_defaults,
)

ctx = Context()
ctx.lists["self.file_extension"] = file_extensions
