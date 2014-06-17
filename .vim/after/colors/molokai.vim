" Better background past 80 characters
hi ColorColumn ctermbg=235

hi DiffText ctermbg=208
hi DiffChange ctermbg=241
hi DiffAdd ctermbg=107
hi DiffDelete ctermbg=88

" Don't kill my eyes on compile errors.
"hi SpellBad cterm=undercurl ctermfg=190 ctermbg=NONE

hi Question term=standout ctermfg=2 gui=bold guifg=SeaGreen

" Sober left line numbers
hi LineNr term=underline ctermfg=242 guifg=Red3
" Pimp the splits/statuses
hi StatusLine term=bold,reverse cterm=bold ctermbg=166 ctermfg=7 guifg=Gray80 guibg=#c00058
hi StatusLineNC term=reverse cterm=none ctermfg=24 ctermbg=black gui=bold guifg=PeachPuff guibg=Gray45
hi VertSplit term=reverse cterm=none ctermbg=24 ctermfg=black gui=bold guifg=White guibg=Gray45

" Better (blue) comments
hi Comment ctermfg=4
" But if I do this todos need to stand out better.
hi Todo ctermbg=red
" red constants/strings
hi Constant cterm=bold ctermfg=1
hi String cterm=none ctermfg=1
