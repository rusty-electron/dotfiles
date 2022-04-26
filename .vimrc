" set leader key
let mapleader=" "

set t_md=
set number relativenumber
syntax on
set tabstop=4
set shiftwidth=4
set expandtab
set cursorline

" for vim wiki
set nocompatible
filetype plugin on
let g:vimwiki_global_ext = 0
let g:vimwiki_table_mappings = 0

let g:vimwiki_list = [{'path': '~/myfiles/vimwiki/', 'path_html': '~/myfiles/vimwiki/public_html/'}]

" netrw defaults
let g:netrw_liststyle = 3 " make tree liststyle the default
let g:netrw_keepdir = 0

" enable dictionary - british english
set spelllang=en_gb
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

" map vim +clipboard to system clipboard
" I had to install gVim for to make this work
set clipboard=unnamedplus

call plug#begin('~/.vim/plugged')
" Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
Plug 'ap/vim-css-color'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-surround'
Plug 'vimwiki/vimwiki'
Plug 'unblevable/quick-scope'
Plug 'SirVer/ultisnips'
Plug 'tpope/vim-capslock' " I can't stand toggling capslock key so often
Plug 'junegunn/goyo.vim'
Plug 'jayli/vim-easycomplete'
Plug 'ferrine/md-img-paste.vim'
Plug 'honza/vim-snippets'
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-rooter'
Plug 'vim-airline/vim-airline'

" themes
Plug 'cocopon/iceberg.vim'
Plug 'sonph/onehalf', { 'rtp': 'vim' }
Plug 'joshdick/onedark.vim'
call plug#end()

" theming
colorscheme onedark
set background=dark

" fix transparency when theme is active
hi Normal guibg=NONE ctermbg=NONE

" Shortcutting split navigation
map <silent> <Esc>k :wincmd k<cr>
map <silent> <Esc>j :wincmd j<cr>
map <silent> <Esc>h :wincmd h<cr>
map <silent> <Esc>l :wincmd l<cr>

" quickscope keybindings
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

augroup qs_colors
  autocmd!
  autocmd ColorScheme * highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
  autocmd ColorScheme * highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline
augroup END

" Automatically deletes all trailing whitespace and newlines at end of file on save.
autocmd BufWritePre * %s/\s\+$//e
autocmd BufWritePre * %s/\n\+\%$//e

" view any url in current buffer
command Vurl :!urlview %

autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" commenting in yaml files
autocmd FileType yaml setlocal commentstring=#\ %s

" twiddle case
" use ~ to switch between lowercase, Titlecase and UPPERCASE
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
" now obsolete after enabling the system clipboard but might be
" useful to keep it around for now
" noremap <leader>p :-1r !xclip -o -sel clipboard<CR>
" noremap <leader>y :'<,'>w !xclip -selection clipboard<CR><CR>

" md-img-paste.vim
autocmd FileType markdown nmap <buffer><silent> <leader>p :call mdip#MarkdownClipboardImage()<CR>

" compiling suckless utilities
au BufWritePost config.def.h !rm -f config.h && sudo make install

" refresh font cache after editing fonts.conf
au BufWritePost fonts.conf !fc-cache -f -v<CR>

" jemdoc make
au BufWritePost *.jemdoc !make

" run xrdb on .Xresources file edit
autocmd BufWritePost *Xresources,*Xdefaults !xrdb %

" goyo-mode
" fixes transparency bug: https://github.com/junegunn/goyo.vim/issues/224
function! s:goyo_leave()
         hi Normal guibg=NONE ctermbg=NONE
endfunction
autocmd! User GoyoLeave nested call <SID>goyo_leave()
" add key binding
noremap <leader>g :Goyo<CR>

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

" plugin config stuff
" -------------------------------------------------
let g:UltiSnipsSnippetDirectories=["UltiSnips", "mysnippets"]
let g:UltiSnipsUsePythonVersion = 3
let g:UltiSnipsExpandTrigger = '<c-a>' " no sure if this is needed
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'

let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

" fzf-vim mappings
nnoremap <leader>ff <cmd>:Files <cr>
nnoremap <leader>fg <cmd>:Rg<cr>
nnoremap <leader>fb <cmd>:Buffers<cr>
nnoremap <leader>fh <cmd>:HelpTags<cr>

" vim-rooter settings
let g:rooter_change_directory_for_non_project_files = 'current'

" airline
let g:airline#extensions#tabline#enabled = 1
