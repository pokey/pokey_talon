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
    key_wait = 5

<user.delete> line:
    user.vscode_and_wait("editor.action.deleteLines")

#talon app actions
<user.teleport> last: user.vscode("workbench.action.openPreviousRecentlyUsedEditorInGroup")
<user.teleport> next: user.vscode("workbench.action.openNextRecentlyUsedEditorInGroup")

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
bar pull request: user.vscode("pr:github.focus")
side dog: user.vscode("workbench.action.toggleSidebarVisibility")
search next: user.vscode("search.action.focusNextSearchResult")
search last: user.vscode("search.action.focusPreviousSearchResult")

<user.show_list> symbol [<user.text>] [halt]:
    user.vscode("workbench.action.gotoSymbol")
    sleep(50ms)
    insert(text or "")

<user.teleport> symbol <user.text> [halt]:
    user.vscode("workbench.action.gotoSymbol")
    sleep(50ms)
    insert(text or "")
    sleep(250ms)
    key(enter)
    sleep(50ms)

<user.show_list> all symbol [<user.text>] [halt]:
    user.vscode("workbench.action.showAllSymbols")
    sleep(50ms)
    insert(text or "")

<user.teleport> all symbol <user.text> [halt]:
    user.vscode("workbench.action.showAllSymbols")
    sleep(50ms)
    insert(text or "")
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
panel terminal: user.vscode("workbench.action.terminal.focus")
pan edit: user.vscode("workbench.action.focusActiveEditorGroup")

# Settings
show settings:
    sleep(50ms)
    user.vscode("workbench.action.openGlobalSettings")
    sleep(250ms)
show settings json: user.vscode("workbench.action.openSettingsJson")
show shortcuts: user.vscode("workbench.action.openGlobalKeybindings")
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
<user.teleport> dock <user.text> [{user.file_extension}] [halt]:
    user.vscode("workbench.action.quickOpen")
    sleep(400ms)
    insert(text or "")
    insert(file_extension or "")
    sleep(300ms)
    key(enter)
    sleep(150ms)
<user.teleport> dock: user.vscode("workbench.action.openPreviousRecentlyUsedEditorInGroup")
file copy path: user.vscode("copyFilePath")
file create sibling <user.format_text>* [<user.word>] [{user.file_extension}]:
    user.vscode_and_wait("explorer.newFile")
    sleep(500ms)
    user.insert_many(format_text_list or "")
    user.insert_formatted(user.word or "", "NOOP")
    insert(file_extension or "")
file clone:
    user.vscode("fileutils.duplicateFile")
    sleep(150ms)
file create: user.vscode("workbench.action.files.newUntitledFile")
file rename:
    user.vscode("fileutils.renameFile")
    sleep(150ms)
file move:
    user.vscode("fileutils.moveFile")
    sleep(150ms)
file open folder: user.vscode("revealFileInOS")
file reveal: user.vscode("workbench.files.action.showActiveFileInExplorer")
disk ugly: user.vscode("workbench.action.files.saveWithoutFormatting")
disk:
    key(esc:5)
    edit.save()
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
imports fix: user.vscode("editor.action.organizeImports")
problem next: user.vscode("editor.action.marker.nextInFiles")
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
spring back:
    user.vscode("workbench.action.navigateBack")
spring forward: user.vscode("workbench.action.navigateForward")
<user.teleport> implementation:
    user.vscode("editor.action.goToImplementation")
<user.teleport> type:
    user.vscode("editor.action.goToTypeDefinition")
<user.teleport> usage:
    user.vscode("references-view.find")

# Bookmarks. Requires Bookmarks plugin
<user.show_list> sesh [<user.text>] [halt]:
    user.vscode("workbench.action.openRecent")
    sleep(50ms)
    user.insert_formatted(text or "", "DASH_SEPARATED,ALL_LOWERCASE")
    sleep(250ms)
<user.teleport> sesh [<user.text>] [halt]:
    user.vscode("workbench.action.openRecent")
    sleep(50ms)
    user.insert_formatted(text or "", "DASH_SEPARATED,ALL_LOWERCASE")
    key(enter)
    sleep(250ms)
new sesh [<user.text>]:
    user.vscode("workbench.action.newWindow")
    sleep(3s)
    user.vscode("workbench.action.openRecent")
    sleep(50ms)
    insert(text or "")
    sleep(250ms)

<user.show_list> win [<user.text>]:
    user.vscode("workbench.action.switchWindow")
    sleep(50ms)
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

# Folding
# fold that: user.vscode("editor.fold")
# unfold that: user.vscode("editor.unfold")
fold those: user.vscode("editor.foldAllMarkerRegions")
unfold those: user.vscode("editor.unfoldRecursively")
fold all: user.vscode("editor.foldAll")
unfold all: user.vscode("editor.unfoldAll")
fold comments: user.vscode("editor.foldAllBlockComments")

# Git / Github (not using verb-noun-adjective pattern, mirroring terminal commands.)
git branch: user.vscode("git.branchFrom")
git branch this: user.vscode("git.branch")
<user.show_list> branch [<user.text>] [halt]:
    user.vscode("git.checkout")
    sleep(50ms)
    user.insert_formatted(text or "", "DASH_SEPARATED,ALL_LOWERCASE")
<user.teleport> branch {user.git_branch}:
    user.vscode("git.checkout")
    sleep(50ms)
    '{git_branch}'
    key(enter)
    sleep(250ms)
git commit [<user.text>]:
    user.vscode("git.commitStaged")
    sleep(250ms)
    user.insert_formatted(text or "", "CAPITALIZE_FIRST_WORD")
git stash [<user.text>]:
    user.vscode("git.stash")
    sleep(100ms)
    user.insert_formatted(text or "", "CAPITALIZE_FIRST_WORD")
git commit undo: user.vscode("git.undoCommit")
git commit ammend: user.vscode("git.commitStagedAmend")
git diff: user.vscode("git.openChange")
git ignore: user.vscode("git.ignore")
git merge: user.vscode("git.merge")
git output: user.vscode("git.showOutput")
git pull: user.vscode("git.pullRebase")
git push: user.vscode("git.push")
git push focus: user.vscode("git.pushForce")
git rebase abort: user.vscode("git.rebaseAbort")
git reveal: user.vscode("git.revealInExplorer")
git revert: user.vscode("git.revertChange")
git stash: user.vscode("git.stash")
git stash pop: user.vscode("git.stashPop")
git status: user.vscode("workbench.scm.focus")
git stage: user.vscode("git.stage")
git stage all: user.vscode("git.stageAll")
git unstage: user.vscode("git.unstage")
git unstage all: user.vscode("git.unstageAll")
git log: user.vscode("git-graph.view")
file open: user.vscode("gitlens.openWorkingFile")
pull request: user.vscode("pr.create")
file viewed: user.vscode("pr.markFileAsViewed")
(open | show) pull request: user.vscode("pr.openPullRequestOnGitHub")
change next: key(alt-f5)
change last: key(shift-alt-f5)

#Debugging
break point: user.vscode("editor.debug.action.toggleBreakpoint")
step over: user.vscode("workbench.action.debug.stepOver")
step into: user.vscode("workbench.action.debug.stepInto")
debug step out [of]: user.vscode("workbench.action.debug.stepOut")
debug start: user.vscode("workbench.action.debug.start")
debug pause: user.vscode("workbench.action.debug.pause")
debug stopper: user.vscode("workbench.action.debug.stop")
debug continue: user.vscode("workbench.action.debug.continue")
debug restart: user.vscode("workbench.action.debug.restart")
debug console: user.vscode("workbench.debug.action.toggleRepl")
debug stench:
    user.vscode("workbench.action.debug.selectandstart")
    "run extension"
    key(enter)
debug test:
    user.vscode("workbench.action.debug.selectandstart")
    "extension tests"
    key(enter)
<user.teleport> stopper:
    user.vscode("workbench.action.openRecent")
    sleep(50ms)
    key(enter)
    sleep(250ms)
    user.vscode("workbench.action.debug.stop")

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
<user.select> (more|this): user.vscode("editor.action.smartSelect.expand")

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

voice code:
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

Github open:
    user.vscode("openInGithub.openInGitHubFile")
    sleep(350ms)

stage on:
    user.vscode_and_wait("git.stage")
    key(cmd-w)
    user.vscode_and_wait("workbench.scm.focus")
    key(shift-tab)
    key(down:100)
    sleep(100ms)
    key(enter)

replace here:
    user.replace("")
    key(cmd-alt-l)
    
join lines: user.vscode("editor.action.joinLines")

full screen: user.vscode("workbench.action.toggleFullScreen")

curse undo: user.vscode("cursorUndo")

breed skip: user.vscode("editor.action.moveSelectionToNextFindMatch")
breed last: user.vscode("editor.action.addSelectionToPreviousFindMatch")

# jupyter
cell next: user.vscode("jupyter.gotoNextCellInFile")
cell last: user.vscode("jupyter.gotoPrevCellInFile")
cell run above: user.vscode("jupyter.runallcellsabove.palette")
cell run: user.vscode("jupyter.runcurrentcell")
cell run all: user.vscode("jupyter.runallcells")

jest: key(ctrl-space)
yes:
    sleep(100ms)
    key(tab)

zoom (talk | demo | big):
    user.set_zoom_level(4)

zoom (normal | regular):
    user.set_zoom_level(1)

make executable: user.vscode("chmod.plusX")

add dock string: user.vscode("autoDocstring.generateDocstring")

issue create [<user.text>]$:
    user.vscode("issue.createIssue")
    sleep(250ms)
    edit.delete_line()
    user.insert_formatted(text or "", "CAPITALIZE_FIRST_WORD")
issue (submit | save): user.vscode("issue.createIssueFromFile")

draft (save | submit):
    user.draft_editor_save()
draft discard:
    user.draft_editor_discard()

dev tools: user.vscode("workbench.action.toggleDevTools")
show in finder: user.vscode("revealFileInOS")

file delete: user.vscode("fileutils.removeFile")
next: user.vscode("jumpToNextSnippetPlaceholder")
snip last: user.vscode("jumpToPrevSnippetPlaceholder")
skip:
    key("backspace")
    user.vscode("jumpToNextSnippetPlaceholder")
previous: user.vscode("jumpToPrevSnippetPlaceholder")

cursorless record: user.vscode("cursorless.recordTestCase")
cursorless record navigation:
    user.vscode_with_plugin("cursorless.recordTestCase", 1)

comment next: user.vscode("editor.action.nextCommentThreadAction")

line numbers on: user.set_line_number_mode("on")
line numbers off: user.set_line_number_mode("off")

solo: user.vscode("workbench.action.closeEditorsInOtherGroups")

break line: user.vscode("rewrap.rewrapComment")

mode {user.language_id}:
    user.vscode("workbench.action.editor.changeLanguageMode")
    "{language_id}"
    key("enter")