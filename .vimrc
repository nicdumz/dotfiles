" Versioned .vim/ is symlinked to ~/.vim/dotfiles-symlink
set rtp +=~/.vim/dotfiles-symlink

set t_Co=256
syntax off
filetype off

" lots of things that neovim does for me already
if !has('nvim')
    set autoindent
    set backspace=indent,eol,start
    " Some locales are silly.
    set encoding=utf-8
    " search patterns
    set hlsearch
    " move in file when typing /pattern
    set incsearch
    set laststatus=2 " Always show statusline.
    set mouse=a
    set nocompatible
    set smarttab
    " usually we're fast, but with urxvt color it's not always obvious
    set ttyfast
    set wildmenu
endif

" mutiple vulnerabilities.
set nomodeline

let s:win_shell = (has('win32') || has('win64')) && &shellcmdflag =~ '/'
let s:vimDir = s:win_shell ? '$HOME/vimfiles' : '~/.vim'
" Avoid issues when running in fish.
set shell=/bin/bash

call plug#begin(expand(s:vimDir . '/plugged'))
Plug 'tomasr/molokai'
let base16colorspace=256
Plug 'chriskempson/base16-vim'
let g:rehash256 = 1 " have the gui theme as close as possible as cterm
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" This requires fancy patched fonts, e.g. DejaVu Sans Mono for Powerline (10)
" See https://github.com/Lokaltog/powerline-fonts
" The gnome terminal and/or .Xresources must be configured for it.
let g:airline_powerline_fonts = 1
" Different font names for different OSes. :h11 is for MacOS.
set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 10,DejaVu\ Sans\ Mono\ for\ Powerline:h11
" blank the fileencoding / fileformat part
let g:airline_section_y = ''

Plug 'scrooloose/syntastic'
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_aggregate_errors = 1

Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
" Support for color fixes in .vim/after
Plug 'vim-scripts/AfterColors.vim'
" Snippets!
if v:version >= 704
    "Plug 'SirVer/ultisnips'
endif
let g:UltiSnipsExpandTrigger = "<c-j>"
let g:UltiSnipsListSnippets = "<c-l>"
let g:UltiSnipsJumpForwardTrigger = "<c-j>"
let g:UltiSnipsJumpBackwardTrigger = "<c-k>"
" Some vcs integration
"Plugin 'vim-scripts/vcscommand.vim'
" Open correctly files: vim filename:103
Plug 'paulhybryant/file-line'
" Export highlighted html to pastebin.
Plug 'google/maktaba' | Plug 'google/vim-syncopate'
" See all 256 colors with :XtermColorTable
Plug 'guns/xterm-color-table.vim'
" git / perforce side colors
Plug 'mhinz/vim-signify'
let g:signify_vcs_list = ['git', 'perforce']
let g:signify_vcs_cmds = {
    \ 'perforce': 'p4 info >& /dev/null && env G4MULTIDIFF=0 P4DIFF=%d p4 diff -dU0 %f'
    \ }
let g:signify_sign_delete = '-'
" Whitespace highlighting / :StripWhitespace
Plug 'ntpeters/vim-better-whitespace'

Plug 'google/vim-ft-bzl'
call plug#end()

syntax on
filetype plugin indent on

set background=dark
if !empty(globpath(&rtp, 'colors/molokai.vim'))
    " Not here during first installation
    colorscheme molokai
endif
au GUIEnter * colorscheme base16-flat
" colorscheme base16-solarized

set expandtab
set tabstop=4
set shiftwidth=4

set number " Show line numbers

set ruler " Show curser position on statusline.
set scrolloff=5 " 5 lines around the cursor

if (v:version > 703 || v:version == 703 && has("patch541"))
    set formatoptions+=rj " Remove comment characters and others on J
endif
set history=10000 " Be modern

set foldmethod=marker
set fillchars=vert:┃,fold:- " Nicer vertical split

set clipboard=unnamed " unify clipboards

" completions
set wildmode=longest,list,full
set wildignore=*.swp,*.bak,*.pyc,*.class

" CTRL-h to toggle search higlight
map <C-H> :se invhls<cr>

" no flashing or beeping
set vb t_vb=
set novisualbell

set nocursorline
set nocursorcolumn

" c was introduced in 7.04
if v:version >= 704
    set shortmess=aToOc
else
    set shortmess=aToO
endif

set cmdheight=2
set noswapfile

set hidden

" Whitespace and long lines
if v:version >= 703
    let &colorcolumn=join(range(81,400),",")
    autocmd FileType qf setlocal colorcolumn=
endif
set list
set listchars=tab:»·,extends:#,nbsp:·  " Show me tabs and nbsp

augroup filetypedetect
    autocmd BufRead,BufNewFile */*localhost*.js* setf javascript
    autocmd BufRead,BufNewFile */mediawiki* setlocal noexpandtab

    " It's all text/external editor support
    " Mail?
    autocmd BufRead *mail.google.com* setf mail
    autocmd BufRead *tmp/*flagfile* setf sh

    autocmd FileType gitcommit DiffGitCached | wincmd p
augroup END

"{{{ Keyboard
    " Unbind the cursor keys in insert, normal and visual modes.
    for prefix in ['i', 'n', 'v']
      for key in ['<Up>', '<Down>', '<Left>', '<Right>']
        exe prefix . "noremap " . key . " <Nop>"
      endfor
    endfor

    " similar to vimperator
    map <space> <C-f>

    " easier keyboard
    map <F1> <Esc>
    imap <F1> <Esc>
    imap <M-Space> <Esc>
    nmap :W :w
"}}}


" Use <F7> to toggle between 'paste' and 'nopaste'
set pastetoggle=<F7>

let g:ackprg="ack -H --nocolor --nogroup --column --ignore-dir build"

function! SetupDiffFunc()
  if &readonly
    set nomod nolist noma filetype=diff
    map q :q<CR>
  endif
endfunction
command! SetupDiff call SetupDiffFunc()

" If we have several files, open the first three ones in vert splits
" vim -O3 does the same things
" autocmd VimEnter * nested :vert ba 3

" brace completion
inoremap {<CR> {<CR><Esc>:call MySmartBraceComplete()<CR>O
function! MySmartBraceComplete()
  if getline(line('.')-1) =~ '^\s*\(class\|struct\)'
    normal i};
  else
    normal i}
  endif
endfunction

" Maximize gvim on startup.
if s:win_shell
  au GUIEnter * simalt ~x
endif

" map OSC52 copy-paste (from osc52.vim plugin)
vmap <C-c> y:call SendViaOSC52(getreg('"'))<cr>

" No damn bell in gvim
au GUIEnter * set visualbell t_vb=

" And last, machine / Google-specific settings are there:
if filereadable(expand("~/.vimrc.after"))
  source ~/.vimrc.after
endif

let mapleader=","
map <leader>v :Vex!<cr>
map <leader>s :Hex<cr>
