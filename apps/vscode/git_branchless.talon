app: vscode
-
git move <user.branchless_commitish> <user.branchless_destination>:
    user.branchless_move_source(branchless_commitish, branchless_destination)
git move <user.branchless_revset_required_modifier> <user.branchless_destination>:
    user.branchless_move_exact(branchless_revset_required_modifier, branchless_destination)
git point <user.branchless_branch> <user.branchless_destination>:
    user.branchless_move_branch(branchless_branch, branchless_destination)
git pop <user.branchless_destination>:
    user.branchless_switch_to_commit(branchless_destination)
git log: user.vscode("git-branchless.smartlog")
git detach: user.vscode("git-branchless.custom.detachHead")
git {user.branchless_simple_command} <user.branchless_revset>:
    user.branchless_simple_command(branchless_simple_command, branchless_revset)
