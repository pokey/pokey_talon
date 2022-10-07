app: vscode
-
^git move <user.revset> to <user.commitish>$:
    user.branchless_move_exact(revset, commitish)
^git move <user.revset> to <user.commitish> [<phrase>] cancel$:
    app.notify("git move cancelled")
git log: user.vscode("git-branchless.smartlog")
^git auto branch <user.revset>$: user.branchless_autobranch(revset)
