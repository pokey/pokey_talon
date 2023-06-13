#custom vscode commands go here
app: vscode
-
tag(): user.find_and_replace
tag(): user.line_commands
tag(): user.multiple_cursors
tag(): user.snippets
tag(): user.splits
tag(): user.tabs

settings():
    key_wait = 2

<user.delete> line: user.vscode_and_wait("editor.action.deleteLines")

#talon app actions
<user.teleport> last:
    user.vscode("workbench.action.openPreviousRecentlyUsedEditorInGroup")
<user.teleport> next:
    user.vscode("workbench.action.openNextRecentlyUsedEditorInGroup")

cross: user.split_next()

window reload: user.vscode("workbench.action.reloadWindow")
window close: user.vscode("workbench.action.closeWindow")
#multiple_cursor.py support end

please [<user.text>]:
    user.vscode("workbench.action.showCommands")
    insert(user.text or "")

# Sidebar
bar explore: user.vscode("workbench.view.explorer")
bar extensions: user.vscode("workbench.view.extensions")
bar outline: user.vscode("outline.focus")
bar run: user.vscode("workbench.view.debug")
bar source: user.vscode("workbench.view.scm")
list wreck: user.vscode("pr:github.focus")
bar test: user.vscode("workbench.view.testing.focus")
side dog: user.vscode("workbench.action.toggleSidebarVisibility")
search next: user.vscode("search.action.focusNextSearchResult")
search last: user.vscode("search.action.focusPreviousSearchResult")
bar collapse: user.vscode("workbench.files.action.collapseExplorerFolders")

<user.show_list> symbol here [<user.text>] [halt]:
    user.vscode("workbench.action.gotoSymbol")
    sleep(50ms)
    user.insert_formatted(text or "", "NO_SPACES")

<user.teleport> symbol here <user.text> [halt]:
    user.vscode("workbench.action.gotoSymbol")
    sleep(50ms)
    user.insert_formatted(text or "", "NO_SPACES")
    sleep(250ms)
    key(enter)
    sleep(50ms)

<user.show_list> symbol [<user.text>] [halt]:
    user.vscode("workbench.action.showAllSymbols")
    sleep(50ms)
    user.insert_formatted(text or "", "NO_SPACES")

<user.teleport> symbol <user.text> [halt]:
    user.vscode("workbench.action.showAllSymbols")
    sleep(50ms)
    user.insert_formatted(text or "", "NO_SPACES")
    sleep(250ms)
    key(enter)
    sleep(50ms)

symbol last: user.vscode("gotoNextPreviousMember.previousMember")
symbol next: user.vscode("gotoNextPreviousMember.nextMember")

# Panels
panel control: user.vscode("workbench.panel.repl.view.focus")
panel output: user.vscode("workbench.panel.output.focus")
problem show: user.vscode("workbench.panel.markers.view.focus")
low dog: user.vscode("workbench.action.togglePanel")
term show:
    user.vscode("workbench.action.terminal.focus")
    sleep(250ms)
low show: user.vscode("workbench.action.focusPanel")
pan edit: user.vscode("workbench.action.focusActiveEditorGroup")

# Settings
show settings:
    sleep(50ms)
    user.vscode("workbench.action.openGlobalSettings")
    sleep(250ms)
show settings json: user.vscode("workbench.action.openSettingsJson")
show settings folder: user.vscode("workbench.action.openFolderSettings")
show settings folder json:
    user.vscode("workbench.action.openFolderSettingsFile")
show settings workspace: user.vscode("workbench.action.openWorkspaceSettings")
show settings workspace json:
    user.vscode("workbench.action.openWorkspaceSettingsFile")
show shortcuts: user.vscode("workbench.action.openGlobalKeybindings")
show shortcuts json: user.vscode("workbench.action.openGlobalKeybindingsFile")
show snippets: user.vscode("workbench.action.openSnippets")

# Display
centered switch: user.vscode("workbench.action.toggleCenteredLayout")
fullscreen switch: user.vscode("workbench.action.toggleFullScreen")
theme switch: user.vscode("workbench.action.selectTheme")
wrap dog: user.vscode("editor.action.toggleWordWrap")
zen switch: user.vscode("workbench.action.toggleZenMode")
zen mode:
    user.vscode("workbench.action.closeSidebar")
    user.vscode("workbench.action.closePanel")
# File Commands
<user.show_list> dock [<user.text>] [{user.file_extension}] [halt]:
    user.vscode("workbench.action.quickOpen")
    sleep(400ms)
    insert(text or "")
    insert(file_extension or "")
    sleep(300ms)
<user.teleport> dock clip:
    user.vscode("workbench.action.quickOpen")
    sleep(400ms)
    edit.paste()
    sleep(300ms)
    key(enter)
    sleep(150ms)
<user.teleport> dock <user.text> [{user.file_extension}] [halt]:
    user.vscode("workbench.action.quickOpen")
    sleep(400ms)
    insert(text or "")
    insert(file_extension or "")
    sleep(300ms)
    key(enter)
    sleep(150ms)
split dock <user.text> [{user.file_extension}] [halt]:
    user.vscode("workbench.action.quickOpen")
    sleep(400ms)
    insert(text or "")
    insert(file_extension or "")
    sleep(300ms)
    key(cmd-right)
    sleep(150ms)
    key(escape)
    user.split_next()
<user.teleport> dock:
    user.vscode("workbench.action.openPreviousRecentlyUsedEditorInGroup")
<user.teleport> alter: user.vscode("alternate.alternateFile")
make alter: user.vscode("alternate.createAlternateFile")
split alter: user.vscode("alternate.alternateFileInSplit")
dock copy name: user.vscode("fileutils.copyFileName")
dock copy path: user.vscode("copyFilePath")
dock copy relative: user.vscode("copyRelativeFilePath")
dock make [<user.format_text>] [<user.word>] [{user.file_extension}]:
    formatted = format_text or ""
    word_raw = word or ""
    extension = file_extension or ""
    user.vscode_with_plugin("andreas.newFile", "{formatted}{word_raw}{extension}")
    sleep(150ms)
dock make root: user.vscode("fileutils.newFileAtRoot")
dock rename:
    user.vscode("fileutils.renameFile")
    sleep(150ms)
dock move:
    user.vscode("fileutils.moveFile")
    sleep(150ms)
dock clone:
    user.vscode("fileutils.duplicateFile")
    sleep(150ms)
dock delete: user.vscode("fileutils.removeFile")
dock open folder: user.vscode("revealFileInOS")
dock reveal: user.vscode("workbench.files.action.showActiveFileInExplorer")
disk ugly: user.vscode("workbench.action.files.saveWithoutFormatting")
disk:
    edit.save()
    sleep(150ms)
    user.vscode("hideSuggestWidget")
disclose:
    key(esc:5)
    edit.save()
    sleep(150ms)
    key(cmd-w)
disk gentle: edit.save()

# Language Features
suggest show: user.vscode("editor.action.triggerSuggest")
hint show: user.vscode("editor.action.triggerParameterHints")
def show: user.vscode("editor.action.revealDefinition")
definition peek: user.vscode("editor.action.peekDefinition")
definition side: user.vscode("editor.action.revealDefinitionAside")
references show: user.vscode("editor.action.goToReferences")
ref show: user.vscode("references-view.find")
format that: user.vscode("editor.action.formatDocument")
format selection: user.vscode("editor.action.formatSelection")
problem next: user.vscode("editor.action.marker.nextInFiles")
disk problem next:
    key(esc:5)
    edit.save()
    sleep(500ms)
    user.vscode("editor.action.marker.nextInFiles")
problem last: user.vscode("editor.action.marker.prevInFiles")
problem fix: user.vscode("problems.action.showQuickFixes")
rename that:
    user.vscode("editor.action.rename")
    sleep(100ms)
refactor that: user.vscode("editor.action.refactor")
whitespace trim: user.vscode("editor.action.trimTrailingWhitespace")
language switch: user.vscode("workbench.action.editor.changeLanguageMode")
refactor rename: user.vscode("editor.action.rename")
refactor this: user.vscode("editor.action.refactor")
ref next:
    user.vscode("references-view.tree.focus")
    key(down enter)
ref last:
    user.vscode("references-view.tree.focus")
    key(up enter)

#code navigation
(<user.teleport> declaration | follow):
    user.vscode("editor.action.revealDefinition")
spring back: user.vscode("workbench.action.navigateBack")
spring forward: user.vscode("workbench.action.navigateForward")
<user.teleport> implementation: user.vscode("editor.action.goToImplementation")
<user.teleport> type: user.vscode("editor.action.goToTypeDefinition")
<user.teleport> usage: user.vscode("references-view.find")

# Bookmarks. Requires Bookmarks plugin
<user.show_list> sesh [<user.text>] [halt]:
    user.vscode("workbench.action.openRecent")
    sleep(250ms)
    user.insert_formatted(text or "", "DASH_SEPARATED,ALL_LOWERCASE")
    sleep(250ms)
<user.teleport> sesh [<user.text>] [halt]:
    user.vscode("workbench.action.openRecent")
    sleep(250ms)
    user.insert_formatted(text or "", "DASH_SEPARATED,ALL_LOWERCASE")
    key(enter)
    sleep(250ms)
new sesh [<user.text>]:
    user.vscode("workbench.action.newWindow")
    sleep(3s)
    user.vscode("workbench.action.openRecent")
    sleep(250ms)
    insert(text or "")
    sleep(250ms)
go edit: user.vscode("workbench.action.navigateToLastEditLocation")

<user.show_list> win [<user.text>]:
    user.vscode("workbench.action.switchWindow")
    sleep(250ms)
    insert(text or "")
    sleep(250ms)
<user.teleport> win [<user.text>]:
    user.vscode("workbench.action.switchWindow")
    sleep(50ms)
    insert(text or "")
    key(enter)
    sleep(250ms)

<user.teleport> marks: user.vscode("workbench.view.extension.bookmarks")
toggle mark: user.vscode("bookmarks.toggle")
<user.teleport> next mark: user.vscode("bookmarks.jumpToNext")
<user.teleport> last mark: user.vscode("bookmarks.jumpToPrevious")

close other tabs: user.vscode("workbench.action.closeOtherEditors")
close all tabs: user.vscode("workbench.action.closeAllEditors")
close tabs way right: user.vscode("workbench.action.closeEditorsToTheRight")
close tabs way left: user.vscode("workbench.action.closeEditorsToTheLeft")

# Folding
# fold that: user.vscode("editor.fold")
# unfold that: user.vscode("editor.unfold")
fold those: user.vscode("editor.foldAllMarkerRegions")
unfold those: user.vscode("editor.unfoldRecursively")
fold all: user.vscode("editor.foldAll")
unfold all: user.vscode("editor.unfoldAll")
fold comments: user.vscode("editor.foldAllBlockComments")
fold one: user.vscode("editor.foldLevel1")
fold two: user.vscode("editor.foldLevel2")
fold three: user.vscode("editor.foldLevel3")
fold four: user.vscode("editor.foldLevel4")
fold five: user.vscode("editor.foldLevel5")
fold six: user.vscode("editor.foldLevel6")
fold seven: user.vscode("editor.foldLevel7")

# Git / Github (not using verb-noun-adjective pattern, mirroring terminal commands.)
git branch: user.vscode("git.branchFrom")
git branch this: user.vscode("git.branch")
<user.show_list> branch [<user.text>] [halt]:
    user.vscode("git.checkout")
    sleep(50ms)
    user.insert_formatted(text or "", "DASH_SEPARATED,ALL_LOWERCASE")
branch make [<user.text>] [halt]:
    user.vscode("git.checkout")
    sleep(50ms)
    "pokey/"
    user.insert_formatted(text or "", "DASH_SEPARATED,ALL_LOWERCASE")
<user.teleport> branch {user.git_branch}:
    user.vscode("git.checkout")
    sleep(450ms)
    "{git_branch}"
    key(enter)
    sleep(500ms)
git rebase [<user.text>] [halt]:
    user.vscode("git.rebase")
    sleep(50ms)
    user.insert_formatted(text or "", "DASH_SEPARATED,ALL_LOWERCASE")
git rebase {user.git_branch}:
    user.vscode("git.rebase")
    sleep(50ms)
    "{git_branch}"
    key(enter)
    sleep(250ms)
git commit [<user.prose>]$: user.git_commit(prose or "")
git commit [<user.prose>] halt: user.git_commit(prose or "")
git commit <user.prose> disclose:
    user.git_commit(prose or "")
    edit.save()
    sleep(150ms)
    app.tab_close()
    sleep(250ms)
disk git commit [<user.prose>]$:
    key(esc:5)
    edit.save()
    sleep(1500ms)
    user.git_commit(prose or "")
disk git commit [<user.prose>] halt:
    key(esc:5)
    edit.save()
    sleep(1500ms)
    user.git_commit(prose or "")
disk git commit <user.prose> disclose:
    key(esc:5)
    edit.save()
    sleep(1500ms)
    user.git_commit(prose or "")
    edit.save()
    sleep(150ms)
    app.tab_close()
    sleep(250ms)
git stash [<user.prose>] [halt]:
    user.vscode("git.stash")
    sleep(100ms)
    user.insert_formatted(prose or "", "CAPITALIZE_FIRST_WORD")
git branches: user.vscode("gitlens.views.branches.focus")
git commit undo: user.vscode("git.undoCommit")
git diff: user.vscode("git.openChange")
git fetch: user.vscode("git.fetch")
git fetch all: user.vscode("git.fetchAll")
git ignore: user.vscode("git.ignore")
git merge: user.vscode("git.merge")
git output: user.vscode("git.showOutput")
git pull: user.vscode("git.pullRebase")
git push:
    sleep(100ms)
    user.vscode("git.push")
git push focus: user.vscode("git.pushForce")
git rebase abort: user.vscode("git.rebaseAbort")
git reveal: user.vscode("git.revealInExplorer")
git revert: user.vscode("git.revertChange")
git stash: user.vscode("git.stash")
git stash pop: user.vscode("git.stashPop")
git status: user.vscode("workbench.scm.focus")
git stage: user.vscode("git.stage")
git stage oliver: user.vscode("git.stageAll")
git stage all merge: user.vscode("git.stageAllMerge")
git unstage: user.vscode("git.unstage")
git unstage all: user.vscode("git.unstageAll")
git sync: user.vscode("git.sync")
git a mend:
    user.vscode_with_plugin("workbench.action.tasks.runTask", "Git amend")
git reword:
    user.vscode_with_plugin("workbench.action.tasks.runTask", "Git reword")
git push force:
    user.vscode_with_plugin("workbench.action.tasks.runTask", "Git push force")
git update main:
    user.vscode_with_plugin("workbench.action.tasks.runTask", "Git update main")
git commit empty:
    user.vscode_with_plugin("workbench.action.tasks.runTask", "Git commit empty")
git continue:
    user.vscode_with_plugin("workbench.action.tasks.runTask", "Git imerge continue")
git full continue:
    user.vscode("git.stageAllMerge")
    user.git_commit(prose or "")
    user.vscode_with_plugin("workbench.action.tasks.runTask", "Git imerge continue")

# Commands for use with git-branchless
^git push stack head$:
    user.vscode_with_plugin("workbench.action.tasks.runTask", "Git push current stack")
^git shadow parent$:
    user.vscode_with_plugin("workbench.action.tasks.runTask", "Git shadow parent")
^branch make this <user.text>$:
    commit = edit.selected_text()
    user.vscode_with_plugin("workbench.action.tasks.runTask", "Git branch commit")
    sleep(350ms)
    insert("pokey/")
    user.insert_formatted(text or "", "DASH_SEPARATED,ALL_LOWERCASE")
    key(enter)
    sleep(100ms)
    insert(commit)
    key(enter)
pop patch last [<user.repetition_count>]:
    user.vscode_with_plugin("workbench.action.tasks.runTask", "Git previous")
    sleep(500ms)
    insert("{repetition_count or 1}")
    key(enter)
pop branch last [<user.repetition_count>]:
    user.vscode_with_plugin("workbench.action.tasks.runTask", "Git previous branch")
    sleep(500ms)
    insert("{repetition_count or 1}")
    key(enter)
pop patch next [<user.repetition_count>]:
    user.vscode_with_plugin("workbench.action.tasks.runTask", "Git next")
    sleep(500ms)
    insert("{repetition_count or 1}")
    key(enter)
pop branch next [<user.repetition_count>]:
    user.vscode_with_plugin("workbench.action.tasks.runTask", "Git next branch")
    sleep(500ms)
    insert("{repetition_count or 1}")
    key(enter)
^{user.branchless_command}$:
    commit = edit.selected_text()
    user.vscode_with_plugin("workbench.action.tasks.runTask", branchless_command)
    sleep(500ms)
    insert(commit)
    key(enter)

dock open: user.vscode("gitlens.openWorkingFile")
wreck make: user.vscode("pr.create")
wreck show: user.vscode("prStatus:github.focus")
dock viewed: user.vscode("pr.markFileAsViewed")
wreck web: user.vscode("pr.openPullRequestOnGitHub")
# Use keyboard shortcuts because VSCode relies on when clause contexts to choose the appropriate
# action: https://code.visualstudio.com/api/references/when-clause-contexts
change next: key(alt-f5)
change last: key(shift-alt-f5)

accept incoming: user.vscode("merge-conflict.accept.incoming")
accept both: user.vscode("merge-conflict.accept.both")
accept current: user.vscode("merge-conflict.accept.current")
accept all current: user.vscode("merge-conflict.accept.all-current")
accept all incoming: user.vscode("merge-conflict.accept.all-incoming")
conflict next: user.vscode("merge-conflict.next")

# Run this command after you run a git command on a multi route workspace and it
# will just apply the text of the commit or whatever to the default workspace
default repo:
    edit.select_all()
    edit.cut()
    key(enter)
    sleep(450ms)
    edit.paste()
    edit.save()
    sleep(150ms)
    key(cmd-w)

#Debugging
step over: user.vscode("workbench.action.debug.stepOver")
step into: user.vscode("workbench.action.debug.stepInto")
debug step out [of]: user.vscode("workbench.action.debug.stepOut")
debug start: user.vscode("workbench.action.debug.start")
debug pause: user.vscode("workbench.action.debug.pause")
debug stopper: user.vscode("workbench.action.debug.stop")
debug continue: user.vscode("workbench.action.debug.continue")
debug restart: user.vscode("workbench.action.debug.restart")
debug console: user.vscode("workbench.debug.action.toggleRepl")
alternate highlight <user.cursorless_target>:
    user.cursorless_single_target_command("highlight", cursorless_target, "highlight1")

consul clear: user.vscode("workbench.debug.panel.action.clearReplAction")
debug stench:
    user.vscode_with_plugin("commands.startDebugging", "Run Extension")
debug test:
    user.vscode_with_plugin("commands.startDebugging", "Extension Tests")
<user.teleport> stopper:
    user.vscode("workbench.action.openRecent")
    sleep(50ms)
    key(enter)
    sleep(250ms)
    user.vscode("workbench.action.debug.stop")
debug clean: user.vscode("workbench.debug.panel.action.clearReplAction")

# Terminal
term external: user.vscode("workbench.action.terminal.openNativeConsole")
term new: user.vscode("workbench.action.terminal.new")
term next: user.vscode("workbench.action.terminal.focusNext")
term last: user.vscode("workbench.action.terminal.focusPrevious")
term split: user.vscode("workbench.action.terminal.split")
term zoom: user.vscode("workbench.action.toggleMaximizedPanel")
term trash: user.vscode("workbench.action.terminal.kill")
term dog: user.vscode_and_wait("workbench.action.terminal.toggleTerminal")
term scroll up: user.vscode("workbench.action.terminal.scrollUp")
term scroll down: user.vscode("workbench.action.terminal.scrollDown")
term <number_small>: user.vscode_terminal(number_small)

#TODO: should this be added to linecommands?
copy line down: user.vscode("editor.action.copyLinesDownAction")
copy line up: user.vscode("editor.action.copyLinesUpAction")

#Expand/Shrink AST Selection
<user.select> less: user.vscode("editor.action.smartSelect.shrink")
<user.select> more: user.vscode("editor.action.smartSelect.expand")

minimap: user.vscode("editor.action.toggleMinimap")
maximize: user.vscode("workbench.action.minimizeOtherEditors")
restore: user.vscode("workbench.action.evenEditorWidths")

debug hover: user.vscode("editor.debug.action.showDebugHover")

edit last: user.vscode("editsHistory.moveCursorToPreviousEdit")
edit next: user.vscode("editsHistory.moveCursorToNextEdit")
edit add: user.vscode("editsHistory.createEditAtCursor")
edit last here: user.vscode("editsHistory.moveCursorToPreviousEditInSameFile")
edit next here: user.vscode("editsHistory.moveCursorToNextEditInSameFile")

commode:
    user.vscode_and_wait("vscode-neovim.enable")
    user.vscode("vscode-neovim.escape")
    sleep(25ms)

voice mode:
    user.vscode_and_wait("vscode-neovim.disable")
    key(i)
    sleep(25ms)

replace smart:
    key(:)
    sleep(50ms)
    key(S)
    key(/)

swap this: user.vscode("extension.swap")

reload window: user.vscode("workbench.action.reloadWindow")
close window: user.vscode("workbench.action.closeWindow")

stage on:
    user.vscode_and_wait("git.stage")
    key(cmd-w)
    user.vscode_and_wait("workbench.scm.focus")
    key(shift-tab)
    key(down:100)
    sleep(100ms)
    key(enter)
#breadcrumb
select breadcrumb: user.vscode("breadcrumbs.focusAndSelect")
# Use `alt-left` and `alt-right` to navigate the bread crumb

replace here:
    user.replace("")
    key(cmd-alt-l)

full screen: user.vscode("workbench.action.toggleFullScreen")

curse undo: user.vscode("cursorUndo")

breed skip: user.vscode("editor.action.moveSelectionToNextFindMatch")
breed last: user.vscode("editor.action.addSelectionToPreviousFindMatch")

# jupyter
cell next: user.vscode("list.focusDown")
cell last: user.vscode("list.focusUp")
run head notebook: user.vscode("jupyter.runallcellsabove.palette")
run cell: user.vscode("notebook.cell.executeAndSelectBelow")
run cell stay: user.vscode("notebook.cell.execute")
run notebook: user.vscode("jupyter.runallcells")
cell run above: user.vscode("notebook.cell.executeCellsAbove")
cell edit: user.vscode("notebook.cell.edit")
cell last edit: user.vscode("notebook.focusPreviousEditor")
cell exit: user.vscode("notebook.cell.quitEdit")

jest: key(ctrl-space)
yes:
    sleep(100ms)
    key(tab)

zoom (talk | demo | big): user.set_zoom_level(4)

zoom (normal | regular): user.set_zoom_level(1)

make executable: user.vscode("chmod.plusX")

add dock string: user.vscode("autoDocstring.generateDocstring")

issue make [<user.text>]$:
    user.vscode("issue.createIssue")
    sleep(250ms)
    edit.delete_line()
    user.insert_formatted(text or "", "CAPITALIZE_FIRST_WORD")
issue (submit | save): user.vscode("issue.createIssueFromFile")

draft (save | submit): user.draft_editor_save()
draft discard: user.draft_editor_discard()

dev tools: user.vscode("workbench.action.toggleDevTools")
show in finder: user.vscode("revealFileInOS")

next: user.vscode_and_wait("jumpToNextSnippetPlaceholder")
snip last: user.vscode("jumpToPrevSnippetPlaceholder")
skip:
    key("backspace")
    user.vscode("jumpToNextSnippetPlaceholder")

comment next: user.vscode("editor.action.nextCommentThreadAction")

line numbers on: user.change_setting("editor.lineNumbers", "on")
line numbers off: user.change_setting("editor.lineNumbers", "off")

han solo: user.vscode("workbench.action.joinAllGroups")

reflow: user.vscode("rewrap.rewrapComment")

mode {user.language_id}:
    user.vscode_with_plugin("commands.setEditorLanguage", language_id)

break <user.cursorless_target>:
    user.cursorless_command("setSelectionBefore", cursorless_target)
    user.vscode("hideSuggestWidget")
    key("enter")
break:
    user.vscode("hideSuggestWidget")
    key("enter")

dock string <user.cursorless_target>:
    user.cursorless_command("editNewLineBefore", cursorless_target)
    "/**"
    sleep(350ms)
    key(tab)

dock short <user.cursorless_target>:
    user.cursorless_command("editNewLineBefore", cursorless_target)
    "/** "

elm wrap <user.cursorless_target>:
    user.cursorless_command("setSelection", cursorless_target)
    user.vscode("editor.emmet.action.wrapWithAbbreviation")
    sleep(250ms)

^tag version$:
    user.vscode_with_plugin("workbench.action.tasks.runTask", "Tag version")
^install sandbox$:
    user.vscode_with_plugin("workbench.action.tasks.runTask", "Install into cursorless sandbox")
^extension publish$:
    user.vscode_with_plugin("workbench.action.tasks.runTask", "Publish extension")
^{user.cursorless_homophone} local split$:
    user.vscode_with_plugin("workbench.action.tasks.runTask", "Cursorless local split")
^tunnel start$:
    user.vscode_with_plugin("workbench.action.tasks.runTask", "Start tunnel")
^tunnel stop$:
    user.vscode("workbench.action.tasks.terminate")
    insert("Start tunnel")
    key(enter)
line edit: key(ctrl-q e)
^move recording [<user.text>] [halt]:
    user.vscode_with_plugin("workbench.action.tasks.runTask", "Move recorded video")
    sleep(650ms)
    user.insert_formatted(text or "", "DASH_SEPARATED")

copy command: user.copy_command_id()
copy command <number_small>:
    key("down:{number_small-1}")
    sleep(350ms)
    user.copy_command_id()

aline that: user.vscode("rainbow-csv.Align")

format doc:
    user.vscode("editor.action.formatDocument")
    user.vscode("editor.action.organizeImports")

show extensions:
    user.vscode("workbench.extensions.action.showEnabledExtensions")

run python: user.vscode("python.execInTerminal")

run tests: user.vscode("testing.runAll")

note make [<user.text>] [halt]:
    user.vscode("foam-vscode.create-note")
    sleep(100ms)
    user.insert_formatted(text or "", "CAPITALIZE_FIRST_WORD")

note make clip:
    user.vscode("foam-vscode.create-note")
    sleep(100ms)
    edit.paste()

# Imports
# from https://github.com/AndreasArvidsson/andreas-talon/blob/a098969bd6b35f5ed0fc99805aa529efc08569a2/apps/vscode/vscode.talon#L25-L31
imports organize: user.vscode("editor.action.organizeImports")
imports add: user.vscode_add_missing_imports()
imports fix:
    sleep(600ms)
    user.vscode_add_missing_imports()
    sleep(250ms)
    user.vscode("editor.action.organizeImports")

search again: user.vscode("rerunSearchEditorSearch")
preview markdown: user.vscode("markdown.showPreview")

typescript restart: user.vscode("typescript.restartTsServer")
(close all editors | tab close all): user.vscode("workbench.action.closeAllGroups")

hay Github <user.text>$:
    user.vscode("agent-chat-panel.focus")
    sleep(100ms)
    user.vscode("agent-chat-panel.focus")
    sleep(100ms)
    insert("{text}")
hay Github <user.text> clap:
    user.vscode("agent-chat-panel.focus")
    sleep(100ms)
    user.vscode("agent-chat-panel.focus")
    sleep(100ms)
    insert("{text}")
    key(enter)
Github yes:
    insert("accept")
    key(enter)
Github no:
    insert("reject")
    key(enter)
