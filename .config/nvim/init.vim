" #####################
"     nvim configs
" ####################

let mapleader=" "
set tabstop=4
set shiftwidth=4
set expandtab
set hidden

set clipboard=unnamedplus

" Automatically deletes all trailing whitespace and newlines at end of file on save.
autocmd BufWritePre * %s/\s\+$//e
autocmd BufWritePre * %s/\n\+\%$//e

" muh plugins
call plug#begin('~/.local/share/nvim/plugged')
Plug 'vim-airline/vim-airline'
Plug 'sainnhe/sonokai'
Plug 'junegunn/goyo.vim'
Plug 'tpope/vim-commentary'
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
Plug 'voldikss/vim-floaterm'
Plug 'mattn/emmet-vim'
Plug 'preservim/nerdtree'
Plug 'yggdroot/indentline'
Plug 'mhinz/vim-startify', {'branch': 'center'}
Plug 'airblade/vim-rooter'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'

Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

Plug 'phaazon/hop.nvim'
Plug 'akinsho/nvim-toggleterm.lua'
call plug#end()

" quickscope
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

augroup qs_colors
    autocmd!
    autocmd ColorScheme * highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
    autocmd ColorScheme * highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline
augroup END

" fzf-vim
set rtp+=/bin/
noremap <leader>fz :FZF<cr>

" Replace all is aliased to S.
nnoremap S :%s//gc<Left><Left>

" Open corresponding .pdf/.html or preview
map <leader>0 :!opout <c-r>%<CR>

" compile, make, create, do shit!
map <leader>m :w! \| !compiler "<c-r>%"

" disabling auto-comment by default
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

""" external copy-paste
noremap <leader>p :-1r !xclip -o -sel clip<CR>
noremap <leader>y :'<,'>w !xclip -selection clipboard<CR><CR>

" floaterm for python console
" set splitbelow
" autocmd FileType python map <buffer> <F10> :w<CR> :split term://python %<CR>i
" autocmd FileType python map <buffer> <F10> :w<CR> :cd %:p:h <CR> :FloatermNew python %<CR>

" config for buffers
" nmap <leader>t :enew " i don't think i need this
nmap <leader>l :bn<CR>
nmap <leader>h :bp<CR>
nmap <C-q> :bp <BAR> bd #<CR>
nmap <leader>bl :buffers<cr>:b<space>

" run python scripts
" autocmd FileType python map <buffer> <F9> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
" autocmd FileType python imap <buffer> <F9> <esc>:w<CR>:exec '!python3' shellescape(@%, 1)<CR

" sonokai colors
let g:sonokai_style = "maia"

" Basic Settings
colorscheme sonokai
set noshowmode
set number relativenumber

" Shortcutting split navigation
map <A-h> <C-w>h
map <A-j> <C-w>j
map <A-k> <C-w>k
map <A-l> <C-w>l

" Enable and disable auto comment
" map <leader>c :setlocal formatoptions-=cro<CR>
" map <leader>C :setlocal formatoptions=cro<CR>

" Enable spell checking, s for spell check
map <leader>s :setlocal spell! spelllang=en_us<CR>

" Enable Disable Auto Indent
map <leader>i :setlocal autoindent<CR>
map <leader>I :setlocal noautoindent<CR>

""" For Plugins

" floaterm configs
let g:floaterm_winblend = 8

nnoremap   <silent>   <F8>   :FloatermNew<CR>
tnoremap   <silent>   <F8>   <C-\><C-n>:FloatermNew<CR>
nnoremap   <silent>   <F9>   :FloatermNext<CR>
tnoremap   <silent>   <F9>  <C-\><C-n>:FloatermNext<CR>
nnoremap   <silent>   <F10>   :FloatermToggle<CR>
tnoremap   <silent>   <F10>   <C-\><C-n>:FloatermToggle<CR>
tnoremap   <silent>   <F11>   <C-\><C-n>:FloatermKill<CR>

" hexokinase configs
set termguicolors
nnoremap <F12> :HexokinaseToggle<CR>

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

" scrape only these files for colour
" let g:Hexokinase_ftEnabled = ['css', 'html', 'javascript']

" vim airline
let g:airline_theme = 'sonokai'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'

" Goyo
noremap <leader>g :Goyo<CR>

" external config files
luafile ~/.config/nvim/lsp.lua
luafile ~/.config/nvim/compe-config.lua
luafile ~/.config/nvim/plugins.lua

" nerdtree
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
    \ quit | endif

" compe mappings
inoremap <silent><expr> <C-Space> compe#complete()
" inoremap <silent><expr> <CR>      compe#confirm('<CR>')
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })

" nvim-telescope
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
