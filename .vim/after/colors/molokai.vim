hi Normal ctermfg=07 ctermbg=00
" Better background past 80 characters
hi ColorColumn ctermbg=08

hi DiffText ctermbg=208
hi DiffChange ctermbg=241
hi DiffAdd ctermbg=107
hi DiffDelete ctermbg=88

" Don't kill my eyes on compile errors.
"hi SpellBad cterm=undercurl ctermfg=190 ctermbg=NONE

hi Question term=standout ctermfg=2 gui=bold guifg=SeaGreen

" Sober left line numbers
hi LineNr term=underline ctermfg=08 guifg=Red3 ctermbg=00
" Pimp the splits/statuses
"hi StatusLine cterm=bold ctermbg=166 ctermfg=7
"hi StatusLineNC cterm=none ctermfg=24 ctermbg=black
hi StatusLine cterm=none ctermbg=none ctermfg=08
hi VertSplit cterm=none ctermbg=none ctermfg=08

" Better (blue) comments
hi Comment ctermfg=4
" But if I do this todos need to stand out better.
hi Todo ctermbg=red
" red constants/strings
hi Constant cterm=bold ctermfg=1
hi String cterm=none ctermfg=1
