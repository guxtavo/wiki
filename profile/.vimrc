" $Id: vimrc,v 1.14 2006/03/07 17:31:45 winfried Exp $

set nocompatible

set backup

set backspace=indent,eol,start
set ruler
set ai
set history=50
set showcmd
set incsearch
set notitle
" w sumie mysza jest badziewna jak nieszczê¶cie
"set mouse=a
set autoread

set foldmethod=indent
"na wstêpie siê nie folduj, geju
set nofoldenable

"jako¶ nie mam do tego zaufania
set nomodeline

syntax on
set hlsearch

set pastetoggle=<C-P>

map Q gq
map <C-K> :nohlsearch<CR>

map! <C-E> <ESC>A
map! <C-A> <ESC>0i

" kolorki
set background=dark

hi clear
if exists("syntax_on")
	syntax reset
endif

hi Comment term=bold ctermfg=Brown

hi Constant term=underline  ctermfg=Magenta
hi String term=underline  ctermfg=DarkGreen
hi Character term=underline ctermfg=LightGreen
hi link Number  Constant
hi link Boolean Constant
hi link Float       Number

hi Identifier term=underline    cterm=bold          ctermfg=Cyan
hi Function term=bold       ctermfg=White

hi Statement term=bold      ctermfg=Yellow
hi Repeat   term=underline  ctermfg=White
hi Operator             ctermfg=Red
hi link Conditional Repeat
hi link Label       Statement
hi link Keyword Statement
hi link Exception   Repeat

hi PreProc  term=underline  ctermfg=LightRed
hi link Include PreProc
hi link Define  PreProc
hi link Macro       PreProc
hi link PreCondit   PreProc

hi Type term=underline      ctermfg=Yellow
hi link StorageClass    Type
hi link Structure   Type
hi link Typedef Type


hi Special  term=bold       ctermfg=DarkMagenta
hi SpecialComment term=bold ctermfg=DarkCyan
hi link Tag     Special
hi link SpecialChar Special
hi link Delimiter   Special
hi link Debug       Special

hi Ignore               ctermfg=black

hi Error    term=reverse ctermbg=Red ctermfg=White

hi Todo term=standout ctermbg=Yellow ctermfg=Black

hi Underlined cterm=underline ctermfg=White



if has("autocmd")
	filetype plugin indent on
	autocmd FileType text,xml,tex setlocal textwidth=78
	" maile trza potraktowaæ po swojemu ;)
	autocmd FileType mail setlocal textwidth=72
	autocmd FileType mail hi Comment ctermfg=DarkCyan
	autocmd FileType mail hi PreProc ctermfg=Blue
	autocmd FileType mail hi Type ctermfg=Green
	autocmd BufReadPre *.xml setlocal fileencodings=utf-8,latin2
	autocmd BufNewFile *.xml setlocal fileencoding=utf-8
	autocmd BufReadPre *.dtd setlocal fileencodings=utf-8,latin2
	autocmd BufNewFile *.dtd setlocal fileencoding=utf-8
	autocmd BufReadPre mutt-*-* set filetype=mail
	autocmd BufReadPost *
		\ if line("'\"") > 0 && line("'\"") <= line("$") |
		\   exe "normal g`\"" |
		\ endif
endif " has("autocmd")

highlight ExtraWhitespace ctermbg=red guibg=red
autocmd BufWinEnter *.{c,pl,pm} match ExtraWhitespace /^\s*     \|\s\+$/
autocmd InsertEnter *.{c,pl,pm} match ExtraWhitespace /^\s*     \|\s\+\%#\@<!$/
autocmd InsertLeave *.{c,pl,pm} match ExtraWhitespace /^\s*     \|\s\+$/
autocmd BufWinLeave *.{c,pl,pm} call clearmatches()

highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%81v.\+/

set expandtab
set shiftwidth=2
set softtabstop=2

set number
