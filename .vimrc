" Unix: Add this as a /home/ndumazet/.vimrc file:
" " Generic settings are supposed to be checked out in .../dotfiles:
" if filereadable("/home/ndumazet/dotfiles/.vimrc")
"   set rtp +=/home/ndumazet/dotfiles/.vim
"   source /home/ndumazet/dotfiles/.vimrc
" endif
"
" " Machine / Google-specific settings are there:
" if filereadable("/home/ndumazet/.vimrc.after")
"   source /home/ndumazet/.vimrc.after
" endif
"
" Windows: Add this as a $HOME\_vimrc file:
" let &runtimepath .= 'D:\dotfiles\.vim'
" source D:\dotfiles\.vimrc

set t_Co=256
syntax off
filetype off
set nocompatible
" mutiple vulnerabilities.
set nomodeline
" Some locales are silly.
set encoding=utf-8

let s:win_shell = (has('win32') || has('win64')) && &shellcmdflag =~ '/'
let s:vimDir = s:win_shell ? '$HOME/vimfiles' : '/home/ndumazet/.vim'


" Magic auto-install, but only on unix.  (Auto-install on windows is a pain)
let s:iCanHazVundle=1
let s:vundle_readme=expand(s:vimDir . '/bundle/vundle/README.md')
if !filereadable(s:vundle_readme) && !s:win_shell
  echo "Installing Vundle.."
  echo ""
  silent !mkdir -p /home/ndumazet/.vim/bundle
  silent !git clone https://github.com/gmarik/vundle /home/ndumazet/.vim/bundle/vundle
  let s:iCanHazVundle=0
endif

let &runtimepath .= ',' . expand(s:vimDir . '/bundle/vundle')
call vundle#begin(expand(s:vimDir . '/bundle'))
Plugin 'gmarik/vundle'

Plugin 'tomasr/molokai'
let g:rehash256 = 1 " have the gui theme as close as possible as cterm
Plugin 'bling/vim-airline'
" This requires fancy patched fonts, e.g. DejaVu Sans Mono for Powerline (10)
" See https://github.com/Lokaltog/powerline-fonts
" The gnome terminal and/or .Xresources must be configured for it.
let g:airline_powerline_fonts = 1
set gfn=DejaVu_Sans_Mono_for_Powerline:h10:cANSI
" blank the fileencoding / fileformat part
let g:airline_section_y=''

Plugin 'scrooloose/syntastic'
" airline may (?) take care of this for us.
"set statusline=%f\ %h%m%r%=%c,%l/%L\ %P\ %#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}%*
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
let g:syntastic_always_populate_loc_list=1
let g:syntastic_check_on_open=1

Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-surround'
Plugin 'vim-scripts/AfterColors.vim'
" Some vcs integration
"Plugin 'vim-scripts/vcscommand.vim'
call vundle#end()

if s:iCanHazVundle == 0
  echo "Installing Bundles, please ignore key map error messages"
  echo ""
  :PluginInstall
endif

syntax on
filetype plugin indent on

colorscheme molokai

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

set formatoptions+=j " Remove comment characters and others on J
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

set shortmess=a
set cmdheight=2

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
autocmd VimEnter * nested :vert ba 3

" brace completion
inoremap {<CR> {<CR><Esc>:call MySmartBraceComplete()<CR>O
function! MySmartBraceComplete()
  if getline(line('.')-1) =~ '^\s*\(class\|struct\)'
    normal i};
  else
    normal i}
  endif
endfunction
