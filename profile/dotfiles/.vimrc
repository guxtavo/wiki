set number
set ruler
set hlsearch
setlocal smarttab
setlocal expandtab
setlocal shiftround

setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal textwidth=79
setlocal colorcolumn=80

set background=dark
set laststatus=2

hi ColorColumn ctermbg=lightgrey guibg=lightgrey
hi OverLength ctermbg=lightgrey ctermfg=darkblue guibg=#592929
highlight Comment ctermfg=7
highlight Search ctermbg=7

match OverLength /\%80v.\+/
autocmd FileType text,xml,tex setlocal textwidth=78

map <C-l> :w!<CR>:!aspell check %<CR>:e! %<CR>
map <F7> mzgg=G`z

au InsertEnter * hi StatusLine ctermfg=7
au InsertLeave * hi StatusLine ctermfg=2

highlight ExtraWhitespace ctermbg=1 guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()
