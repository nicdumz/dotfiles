" Vim color file
" Maintainer: David Ne\v{c}as (Yeti) <yeti@physics.muni.cz>
" Last Change: 2003-04-23
" URL: http://trific.ath.cx/Ftp/vim/colors/peachpuff.vim

" This color scheme uses a peachpuff background (what you've expected when it's
" called peachpuff?).
"
" Note: Only GUI colors differ from default, on terminal it's just `light'.

set background=dark

let colors_name = "peachpuff"

hi Normal guibg=Black guifg=White

hi SpecialKey term=bold ctermfg=4 guifg=Blue
hi NonText term=bold cterm=bold ctermfg=4 gui=bold guifg=Blue
hi Directory term=bold ctermfg=4 guifg=Blue
hi ErrorMsg term=standout cterm=bold ctermfg=7 ctermbg=1 gui=bold guifg=White guibg=Red
hi IncSearch term=reverse cterm=reverse gui=reverse
hi Search term=reverse ctermbg=202 guibg=Gold2
hi MoreMsg term=bold ctermfg=2 gui=bold guifg=SeaGreen
hi ModeMsg term=bold cterm=bold gui=bold
hi LineNr term=underline ctermfg=242 guifg=Red3
hi Question term=standout ctermfg=2 gui=bold guifg=SeaGreen
hi StatusLine term=bold,reverse cterm=bold ctermbg=166 ctermfg=7 guifg=Gray80 guibg=#c00058
hi StatusLineNC term=reverse ctermfg=24 ctermbg=black gui=bold guifg=PeachPuff guibg=Gray45
hi VertSplit term=reverse cterm=none ctermbg=24 ctermfg=black gui=bold guifg=White guibg=Gray45
hi Title term=bold ctermfg=5 gui=bold guifg=DeepPink3
hi Visual term=reverse cterm=bold ctermbg=238 gui=reverse guifg=Grey80 guibg=fg
hi VisualNOS term=bold,underline cterm=bold,underline gui=bold,underline
hi WarningMsg term=standout ctermfg=1 gui=bold guifg=Red
hi WildMenu term=standout ctermfg=Black ctermbg=3 guifg=Black guibg=Yellow
hi Folded term=standout cterm=bold ctermfg=7 ctermbg=8 guifg=Black guibg=#e3c1a5
hi FoldColumn term=standout ctermfg=4 ctermbg=7 guifg=DarkBlue guibg=Gray80
hi DiffAdd term=bold ctermbg=4 guibg=White
hi DiffChange term=bold ctermbg=5 guibg=#edb5cd
hi DiffDelete term=bold cterm=bold ctermfg=4 ctermbg=6 gui=bold guifg=LightBlue guibg=#f6e8d0
hi DiffText term=reverse cterm=bold ctermbg=1 gui=bold guibg=#ff8060
hi Cursor guifg=bg guibg=fg
hi lCursor guifg=bg guibg=fg

hi MatchParen ctermbg=green guibg=#592929

" Colors for syntax highlighting
hi Comment term=bold ctermfg=4 guifg=#406090
hi Constant term=underline ctermfg=1 guifg=#c00058
hi Special term=bold ctermfg=5 guifg=SlateBlue
hi Identifier term=underline ctermbg=234 ctermfg=2 cterm=bold guifg=DarkCyan
hi Statement term=bold ctermfg=220 gui=bold guifg=Brown
hi PreProc term=underline ctermfg=5 guifg=Magenta3
hi Type term=underline ctermfg=2 gui=bold guifg=SeaGreen
hi Ignore cterm=bold ctermfg=7 guifg=bg
hi Error term=reverse cterm=bold ctermfg=7 ctermbg=1 gui=bold guifg=White guibg=Red
hi Todo term=standout ctermfg=Black ctermbg=3 guifg=Blue guibg=Yellow

hi SpellBad cterm=reverse ctermbg=black


" CUSTOM

highlight DiffAdd cterm=none ctermfg=Black ctermbg=Green gui=none guifg=Black guibg=Green
highlight DiffDelete cterm=none ctermfg=Black ctermbg=Red gui=none guifg=Black guibg=Red
highlight DiffChange cterm=none ctermfg=Black ctermbg=Yellow gui=none guifg=Black guibg=Yellow
highlight DiffText cterm=none ctermfg=Black ctermbg=Magenta gui=none guifg=Black guibg=Magenta

highlight PmenuSel ctermfg=blue ctermbg=gray
highlight PmenuThumb ctermfg=darkgreen
highlight Pmenu ctermbg=yellow ctermfg=black

highlight SpellBad cterm=reverse ctermbg=black

hi TabLine cterm=none ctermfg=White ctermbg=Black
hi TabLineSel cterm=bold ctermfg=Black ctermbg=7
hi TabLineFill cterm=none ctermfg=White ctermbg=Black

hi ColorColumn term=none ctermfg=red ctermbg=none cterm=bold
