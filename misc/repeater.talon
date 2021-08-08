# -1 because we are repeating, so the initial command counts as one
<number_small> now: core.repeat_phrase(number_small-1)
twice: core.repeat_phrase(1)
thrice: core.repeat_phrase(2)
(repeat that|again): core.repeat_phrase(1)
repeat that <number_small> [times]: core.repeat_phrase(number_small)
