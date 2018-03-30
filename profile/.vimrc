set number
set ruler
set hlsearch

set shiftwidth=8
set softtabstop=2
set showtabline=2
set textwidth=79
set colorcolumn=80


#pep8
setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal smarttab
setlocal expandtab
setlocal shiftround
setlocal autoindent
setlocal textwidth=79
setlocal colorcolumn=80

highlight ColorColumn ctermbg=lightgrey guibg=lightgrey
highlight OverLength ctermbg=lightgray ctermfg=darkblue guibg=#592929

match OverLength /\%80v.\+/
autocmd FileType text,xml,tex setlocal textwidth=78
map  :w!<CR>:!aspell check %<CR>:e! %<CR>
