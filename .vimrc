" Generic settings are supposed to be versioned in ~/dotfiles:
if filereadable(expand("~/.dotfiles/.vimrc"))
  " TODO: fix this to be cleaner
  set rtp +=~/.dotfiles/.vim
endif

set t_Co=256
syntax off
filetype off
set nocompatible
" mutiple vulnerabilities.
set nomodeline
" Some locales are silly.
set encoding=utf-8

let s:win_shell = (has('win32') || has('win64')) && &shellcmdflag =~ '/'
let s:vimDir = s:win_shell ? '$HOME/vimfiles' : '~/.vim'

let &runtimepath .= ',' . expand(s:vimDir . '/bundle/Vundle.vim')
call vundle#begin(expand(s:vimDir . '/bundle'))
Plugin 'gmarik/Vundle.vim'

Plugin 'tomasr/molokai'
let base16colorspace=256
Plugin 'chriskempson/base16-vim'
let g:rehash256 = 1 " have the gui theme as close as possible as cterm
Plugin 'bling/vim-airline'
" This requires fancy patched fonts, e.g. DejaVu Sans Mono for Powerline (10)
" See https://github.com/Lokaltog/powerline-fonts
" The gnome terminal and/or .Xresources must be configured for it.
let g:airline_powerline_fonts = 1
" Different font names for different OSes. :h11 is for MacOS.
set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 10,DejaVu\ Sans\ Mono\ for\ Powerline:h11
" blank the fileencoding / fileformat part
let g:airline_section_y = ''

Plugin 'scrooloose/syntastic'
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_aggregate_errors = 1

Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'
" Support for color fixes in .vim/after
Plugin 'vim-scripts/AfterColors.vim'
" Snippets!
if v:version >= 704
    Plugin 'SirVer/ultisnips'
endif
let g:UltiSnipsExpandTrigger = "<c-j>"
let g:UltiSnipsListSnippets = "<c-l>"
let g:UltiSnipsJumpForwardTrigger = "<c-j>"
let g:UltiSnipsJumpBackwardTrigger = "<c-k>"
" Some vcs integration
"Plugin 'vim-scripts/vcscommand.vim'
" Open correctly files: vim filename:103
Plugin 'paulhybryant/file-line'
" Export highlighted html to pastebin.
Plugin 'google/maktaba'
Plugin 'google/vim-syncopate'
" See all 256 colors with :XtermColorTable
Plugin 'guns/xterm-color-table.vim'
call vundle#end()

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
set smarttab
set autoindent

set number " Show line numbers
set mouse=a
set laststatus=2 " Always show statusline.

set ruler " Show curser position on statusline.
set scrolloff=5 " 5 lines around the cursor

if (v:version > 703 || v:version == 703 && has("patch541"))
    set formatoptions+=rj " Remove comment characters and others on J
endif
set history=1000 " Be modern

set foldmethod=marker
set fillchars=vert:┃,fold:- " Nicer vertical split

set clipboard=unnamed " unify clipboards

" completions
set wildmode=longest,list,full
set wildignore=*.swp,*.bak,*.pyc,*.class
set wildmenu

" search patterns
set hls
" move in file when typing /pattern
set incsearch
" CTRL-h to toggle search higlight
map <C-H> :se invhls<cr>

" usually we're fast, but with urxvt color it's not always obvious
set ttyfast

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
set backspace=indent,eol,start

" Whitespace and long lines
if v:version >= 703
    let &colorcolumn=join(range(81,400),",")
    autocmd FileType qf setlocal colorcolumn=
endif
set list
set listchars=tab:»·,trail:·,extends:#,nbsp:·  " Show me tabs and trailing
                                               " whitespace

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
