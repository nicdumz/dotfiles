if exists("did_load_filetypes")
  finish
endif

augroup filetypedetect

" when BufRead or BufNewFile event is triggered on a stupid perforce stuff
" manually restart filetype autocommands
autocmd! BufRead    *#* execute 'doautocmd filetypedetect BufRead ' . substitute(expand('%'), '#.*$', '', '')
autocmd! BufNewFile *#* execute 'doautocmd filetypedetect BufNewFile ' . substitute(expand('%'), '#.*$', '', '')

augroup END
