hi Normal ctermbg=00
"Same background as normal
hi VertSplit ctermbg=00
hi SignColumn ctermbg=00
hi LineNr ctermbg=00

" Better background past 80 characters
hi ColorColumn ctermbg=18

hi DiffText ctermbg=17
hi DiffChange ctermbg=241
hi DiffAdd ctermbg=22
hi DiffDelete ctermbg=52

hi Question term=standout ctermfg=2 gui=bold guifg=SeaGreen

" Better contrast for line numbers
hi LineNr ctermfg=08 guifg=Red3

" Better (blue) comments
hi Comment ctermfg=4
" But if I do this todos need to stand out better.
hi Todo ctermbg=red
" red strings
hi String ctermfg=1

hi FoldColumn ctermbg=none
hi Folded ctermbg=18 ctermfg=8
