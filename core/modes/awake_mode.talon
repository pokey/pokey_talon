not mode: sleep
-
# Note: I don't put these in modes_not_dragon.talon because I don't want any
# spoken forms active when Talon is asleep, so it can optimize and not turn on
# the speech engine
drowse [<phrase>]$: user.sleep_all()
drowse <phrase> resume$: skip()
# Leave up overlays, etc
drowse light [<phrase>]$: speech.disable()
