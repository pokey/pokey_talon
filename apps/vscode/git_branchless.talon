app: vscode
-
^git graft <user.revset> <user.git_destination>$:
    user.branchless_move_exact(revset, git_destination)
^git graft <user.revset> <user.git_destination_commitish> [<phrase>] cancel$:
    app.notify("git move cancelled")
git log: user.vscode("git-branchless.smartlog")
^git auto branch <user.revset>$: user.branchless_autobranch(revset)
