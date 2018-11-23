set number
set ruler
set hlsearch
set smarttab
set expandtab
set shiftround
set nobackup
" set relativenumber
set ignorecase
" set noswapfile
" set incsearch
" set smartcase

set tabstop=4
set softtabstop=4
set shiftwidth=4
set textwidth=79
set background=dark
set showtabline=2

" .vim/plugin/listtrans.vim
nmap  l   :call ListTrans_toggle_format()<CR>
vmap  l   :call ListTrans_toggle_format('visual')<CR>

" drag visuals
runtime plugin/dragvisuals.vim
let g:DVB_TrimWS = 1
vmap  <expr>  h        DVB_Drag('left')
vmap  <expr>  l        DVB_Drag('right')
vmap  <expr>  j        DVB_Drag('down')
vmap  <expr>  k        DVB_Drag('up')
vmap  <expr>  D        DVB_Duplicate()
"setlocal colorcolumn=80
call matchadd('ColorColumn', '\%80v', 100)

" highlights
hi ColorColumn ctermbg=lightgrey
hi OverLength ctermbg=lightgrey ctermfg=darkblue
highlight Comment ctermfg=7
highlight Search ctermbg=7
match OverLength /\%80v.\+/
autocmd FileType text,xml,tex setlocal textwidth=78
au BufRead /tmp/mutt-* set tw=72

" set style guide for each language
autocmd FileType html setlocal shiftwidth=2 tabstop=2
autocmd FileType python setlocal shiftwidth=4 tabstop=4
autocmd FileType ruby setlocal shiftwidth=2 tabstop=2
autocmd FileType c setlocal shiftwidth=2 tabstop=2
autocmd FileType sh setlocal shiftwidth=2 tabstop=2

" key maps
" Control-l to spell check
map <C-l> :w!<CR>:!aspell check %<CR>:e! %<CR>
" F7 to reformat file
map <F7> mzgg=G`z
map <F1> <nop>

" change status line color when in normal and insert mode
au InsertEnter * hi StatusLine ctermfg=7
au InsertLeave * hi StatusLine ctermfg=70

" highlight extra chars
highlight ExtraWhitespace ctermbg=1 guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" show invisible chars
exec "set listchars=tab:\uBB\uBB,trail:\uB7,nbsp:~"
set list

" status line
set laststatus=2
set statusline+=\ %F
set statusline+=%=
set statusline+=\ %y
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\[%{&fileformat}\]
set statusline+=\ %p%%
set statusline+=\ %l:%c

" pathogen
execute pathogen#infect()
filetype plugin indent on
