set t_md=
set number relativenumber
syntax on
set tabstop=4
set shiftwidth=4
set expandtab

" indent
nnoremap > v>
nnoremap < v<
vnoremap > >gv
vnoremap < <gv

" dict stuff??
set spelllang=en_gb
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

" map vim +clipboard to system clipboard
set clipboard=unnamedplus

" Automatically deletes all trailing whitespace and newlines at end of file on save.
autocmd BufWritePre * %s/\s\+$//e
autocmd BufWritePre * %s/\n\+\%$//e

" view any url in current buffer
" command Vurl :!urlview %

autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" commenting in yaml files
autocmd FileType yaml setlocal commentstring=#\ %s

" twiddle case
function! TwiddleCase(str)
  if a:str ==# toupper(a:str)
    let result = tolower(a:str)
  elseif a:str ==# tolower(a:str)
    let result = substitute(a:str,'\(\<\w\+\>\)', '\u\1', 'g')
  else
    let result = toupper(a:str)
  endif
  return result
endfunction
vnoremap ~ y:call setreg('', TwiddleCase(@"), getregtype(''))<CR>gv""Pgv

" external copy/paste
noremap <leader>p :-1r !xclip -o -sel clipboard<CR>
noremap <leader>y :'<,'>w !xclip -selection clipboard<CR><CR>

" compiling suckless utilities
au BufWritePost config.def.h !rm -f config.h && sudo make install

" run xrdb on .Xresources file edit
autocmd BufWritePost *Xresources,*Xdefaults !xrdb %

" toggle relative numbering
noremap <F3> :set invnumber invrelativenumber<CR>
