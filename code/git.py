from talon import Module, Context

ctx = Context()
mod = Module()

mod.list("git_branch", desc="Git branch")

ctx.lists["self.git_branch"] = ["main", "master", "develop"]
