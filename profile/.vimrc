set number
set ruler

set shiftwidth=8
set softtabstop=2

highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%81v.\+/

autocmd FileType text,xml,tex setlocal textwidth=78
