" "Add this as a /home/ndumazet/.vimrc file:
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

set t_Co=256
syntax off
filetype off
set nocompatible
" mutiple vulnerabilities.
set nomodeline

" Magic auto-install
let iCanHazVundle=1
let vundle_readme=expand('/home/ndumazet/.vim/bundle/vundle/README.md')
if !filereadable(vundle_readme)
  echo "Installing Vundle.."
  echo ""
  silent !mkdir -p /home/ndumazet/.vim/bundle
  silent !git clone https://github.com/gmarik/vundle /home/ndumazet/.vim/bundle/vundle
  let iCanHazVundle=0
endif

set rtp +=/home/ndumazet/.vim/bundle/vundle
call vundle#begin("/home/ndumazet/.vim/bundle")
Plugin 'gmarik/vundle'

Plugin 'scrooloose/syntastic'
set statusline=%f\ %h%m%r%=%c,%l/%L\ %P\ %#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}%*
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
let g:syntastic_always_populate_loc_list=1
let g:syntastic_check_on_open=1

Plugin 'tomasr/molokai'
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-surround'
Plugin 'vim-scripts/AfterColors.vim'
" Some vcs integration
"Plugin 'vim-scripts/vcscommand.vim'
call vundle#end()

if iCanHazVundle == 0
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
set number
set mouse=a
set autoindent
set laststatus=2
set ruler
set hls

" 5 lines around the cursor
set scrolloff=5

set foldmethod=marker

" unify clipboards
set clipboard=unnamed

" completion on commandline
set wildmode=longest,list,full
set wildmenu

" move in file when typing /pattern
set incsearch
" CTRL-h to toggle search higlight
map <C-H> :se invhls<cr>

" strange vulnerability
set modelines=0
" usually we're fast, but with urxvt color it's not always obvious
set ttyfast

" no flashing or beeping
set vb t_vb=
set novisualbell

set nocursorline
set nocursorcolumn

set shortmess=a
set cmdheight=2

"{{{ Whitespace and long lines
if v:version >= 703
    let &colorcolumn=join(range(81,400),",")
else
    "123456789098732345678732356765434567865432345678987654345678767676767654345676544345345
    au BufWinEnter * if &textwidth >4
    \ | let w:m2=matchadd('ErrorMsg', printf('\%%>%dv.\+', 80), -1)
    \ | endif
endif

" Show trailing whitepace and spaces before a tab:         
highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\t/ containedin=ALL
"}}}


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
command SetupDiff call SetupDiffFunc()

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
