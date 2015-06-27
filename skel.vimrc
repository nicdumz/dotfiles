" Generic settings are supposed to be versioned in ~/dotfiles:
if filereadable(expand("__DOTFILESDIR__/.vimrc"))
  set rtp +=__DOTFILESDIR__/.vim
  source __DOTFILESDIR__/.vimrc
endif

" Machine / Google-specific settings are there:
if filereadable(expand("~/.vimrc.after"))
  source ~/.vimrc.after
endif

" Windows: Add this as a $HOME\_vimrc file:
" let &runtimepath .= 'D:\dotfiles\.vim'
" source D:\dotfiles\.vimrc
