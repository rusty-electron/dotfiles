let mapleader=" "

set t_md=
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
set number relativenumber
syntax on
" set clipboard=unnamedplus

call plug#begin('~/.vim/plugged')
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'tpope/vim-vinegar'
call plug#end()

" Remove trailing whitespace on save
autocmd BufWritePre * %s/\s\+$//e

autocmd FileType yaml setlocal commentstring=#\ %s

" external copy/paste
noremap <leader>p :-1r !xclip -o -sel clip<CR>
noremap <leader>y :'<,'>w !xclip -selection clipboard<CR><CR>

" compiling suckless utilities
au BufWritePost config.def.h !rm -f config.h && sudo make install

" run xrdb on .Xresources file edit
autocmd BufWritePost *Xresources,*Xdefaults !xrdb %

" toggle relative numbering
noremap <F3> :set invnumber invrelativenumber<CR>

" run python scripts
autocmd FileType python map <buffer> <F9> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
autocmd FileType python imap <buffer> <F9> <esc>:w<CR>:exec '!python3' shellescape(@%, 1)<CR>

" run cpp
autocmd FileType cpp map <buffer> <F9> :!g++ -o  %:r.out % -std=c++11<CR>
autocmd FileType cpp map <buffer> <F10> :!./%:r.out<CR>

" Open corresponding .pdf/.html or preview
map <leader>0 :!opout <c-r>%<CR>

" compile, make, create, do shit!
map <leader>m :w! \| !compiler "<c-r>%"<CR><CR>

" " stuff for groff
" function! Preview()
"         :call Compile()<CR><CR>
"         execute "! zathura /tmp/op.pdf &"
" endfunction

" " [1] Get the extension of the file
" " [2] Apply appropriate compilation command
" " [3] Save PDF as /tmp/op.pdf
" function! Compile()
"         let extension = expand('%:e')
"         if extension == "ms"
"                 execute "! groff -ms % -T pdf > /tmp/op.pdf"
"         elseif extension == "tex"
"                 execute "! pandoc -f latex -t latex % -o /tmp/op.pdf"
"         elseif extension == "md"
"                 execute "! pandoc % -s -o /tmp/op.pdf"
"         endif
" endfunction

" leader p to preview
" noremap <leader>v :call Preview()<CR><CR>

" leader q to compile
" noremap <leader>c :w<CR> :call Compile()<CR>

" plugin config stuff
" -------------------------------------------------
" hexokinase configs
noremap <buffer> <F11> :HexokinaseToggle<CR>

let g:Hexokinase_highlighters = [ 'backgroundfull' ]
let g:Hexokinase_refreshEvents = ['InsertLeave']

let g:Hexokinase_optInPatterns = [
  \     'full_hex',
  \     'triple_hex',
  \     'rgb',
  \     'rgba',
  \     'hsl',
  \     'hsla',
  \     'colour_names'
  \ ]

let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
