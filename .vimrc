set nocompatible
syntax on
filetype plugin on

colorscheme nicdumz

set expandtab
set tabstop=4
set shiftwidth=4
set smarttab
set number
set mouse=a

set autoindent
set laststatus=2
set ruler

" completion on commandline
set wildmode=longest,list
set wildmenu

" usually we're fast, but with urxvt color it's not always obvious
set ttyfast

" move in file when typing /pattern
set incsearch

autocmd BufRead,BufNewFile */*localhost*.js* setlocal filetype=javascript
autocmd BufRead,BufNewFile */mediawiki* setlocal noexpandtab
autocmd BufRead,BufNewFile */*nexedi* setlocal tabstop=2 shiftwidth=2 tags=~/nexedi/buildout/tags
autocmd BufRead bt5/*/bt/* setlocal binary

" It's all text support
" Mail?
autocmd BufRead mail.google.com.* setlocal ft=mail

fu! DoRunPyBuffer()
    pclose! " force preview window closed
    setlocal ft=python

    " copy the buffer into a new window, then run that buffer through python
    sil %y a | below new | sil put a | sil %!python -
    " indicate the output window as the current previewwindow
    setlocal previewwindow ro nomodifiable nomodified

    " back into the original window
    winc p
endfu

command! XyzRunPyBuffer call DoRunPyBuffer()
map <C-p> :XyzRunPyBuffer<CR>

" Use <F7> to toggle between 'paste' and 'nopaste'
set pastetoggle=<F7>

nmap :W :w

" CTRL-h to toggle search higlight
map <C-H> :se invhls<cr>

" Unbind the cursor keys in insert, normal and visual modes.
for prefix in ['i', 'n', 'v']
  for key in ['<Up>', '<Down>', '<Left>', '<Right>']
    exe prefix . "noremap " . key . " <Nop>"
  endfor
endfor

fu! DoEnableDirs()
  for prefix in ['i', 'n', 'v']
    for key in ['<Up>', '<Down>', '<Left>', '<Right>']
      exe prefix . "unmap " . key
    endfor
  endfor
endfu
command! EnableDirs call DoEnableDirs()
map <C-Down> :EnableDirs<CR>
map <C-Up> :EnableDirs<CR>
map <C-Left> :EnableDirs<CR>
map <C-Right> :EnableDirs<CR>

command! Pyflakes :!pyflakes %

"123456789098732345678732356765434567865432345678987654345678767676767654345676544345345
au BufWinEnter * if &textwidth >4
"\ | let w:m1=matchadd('MatchParen', printf('\%%<%dv.\%%>%dv', 81, 76), -1)
\ | let w:m2=matchadd('ErrorMsg', printf('\%%>%dv.\+', 80), -1)
\ | endif

"
" Show trailing whitepace and spaces before a tab:         
highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\t/ containedin=ALL


" Override comment color
"hi Comment term=bold ctermfg=blue

map <F1> <Esc>
imap <F1> <Esc>
imap <M-Space> <Esc>

augroup VCSCommand
  au VCSCommand User VCSBufferCreated silent! map <unique> <buffer> q :bwipeout<cr>
augroup END

let VCSCommandSVNDiffExt = "/usr/bin/diff"
nmap <Leader>cr <Plug>VCSRevert

if &diff
    noremap <Leader>u :diffupdate<cr>
    noremap <Leader>g :diffget<cr>
    noremap <Leader>p :diffput<cr>
endif

nnoremap <Leader>pdb Oimport pdb; pdb.set_trace()<esc>==

command! TrailingWhitespace :%s/\s\+$//g
command! Gvim :!gvim -c 'set noro' %:p
command! RunTest :!python run-tests.py -i %
