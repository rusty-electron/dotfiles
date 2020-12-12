let mapleader=" "

" muh plugins
call plug#begin('~/.local/share/nvim/plugged')
Plug 'vim-airline/vim-airline'
Plug 'tomasiser/vim-code-dark'
Plug 'junegunn/goyo.vim'
Plug 'tpope/vim-commentary'
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'voldikss/vim-floaterm'
Plug 'mattn/emmet-vim'
call plug#end()

" fzf-vim
set rtp+=/bin/
noremap <leader>ff :FZF<cr>

" Replace all is aliased to S.
nnoremap S :%s//g<Left><Left>

" Open corresponding .pdf/.html or preview
map <leader>0 :!opout <c-r>%<CR>

" compile, make, create, do shit!
map <leader>m :w! \| !compiler "<c-r>%"

" disabling auto-comment by default
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

""" external copy-paste
noremap <leader>v :-1r !xclip -o -sel clip<CR>
noremap <leader>y :'<,'>w !xclip -selection clipboard<CR><CR>

" floaterm for python console
" set splitbelow
" autocmd FileType python map <buffer> <F10> :w<CR> :split term://python %<CR>i
autocmd FileType python map <buffer> <F10> :w<CR> :cd %:p:h <CR> :FloatermNew python %<CR>

" config for buffers
nmap <leader>t :enew
nmap <leader>l :bn<CR>
nmap <leader>h :bp<CR>
nmap <leader>bq :bp <BAR> bd #<CR>
nmap <leader>bl :buffers<cr>:b<space>

" run python scripts
autocmd FileType python map <buffer> <F9> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
autocmd FileType python imap <buffer> <F9> <esc>:w<CR>:exec '!python3' shellescape(@%, 1)<CR

" Basic Settings
colorscheme codedark
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

" Automatically deletes all trailing whitespace and newlines at end of file on save.
autocmd BufWritePre * %s/\s\+$//e
autocmd BufWritePre * %s/\n\+\%$//e

""" For Plugins

" floaterm configs
let g:floaterm_winblend = 8

nnoremap   <silent>   <leader>T    :FloatermNew<CR>
tnoremap   <silent>   <leader>T    <C-\><C-n>:FloatermNew<CR>
nnoremap   <silent>   <leader>E    :FloatermNew nnn<CR>
tnoremap   <silent>   <leader>E    <C-\><C-n>:FloatermNew nnn<CR>
nnoremap   <silent>   <leader>n    :FloatermNext<CR>
tnoremap   <silent>   <leader>n   <C-\><C-n>:FloatermNext<CR>
nnoremap   <silent>   <leader>tt   :FloatermToggle<CR>
tnoremap   <silent>   <leader>tt   <C-\><C-n>:FloatermToggle<CR>
tnoremap   <silent>   <leader>tk   <C-\><C-n>:FloatermKill<CR>

" hexokinase configs
set termguicolors
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

" scrape only these files for colour
let g:Hexokinase_ftEnabled = ['css', 'html', 'javascript']

" vim airline
let g:airline_theme = 'codedark'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'

" Goyo
noremap <leader>g :Goyo<CR>

" netrw
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_winsize = 20

function! OpenToRight()
  :normal v
  let g:path=expand('%:p')
  execute 'q!'
  execute 'belowright vnew' g:path
  :normal <C-w>l
endfunction

function! OpenBelow()
  :normal v
  let g:path=expand('%:p')
  execute 'q!'
  execute 'belowright new' g:path
  :normal <C-w>l
endfunction

function! OpenTab()
  :normal v
  let g:path=expand('%:p')
  execute 'q!'
  execute 'tabedit' g:path
  :normal <C-w>l
endfunction

function! NetrwMappings()
    " Hack fix to make ctrl-l work properly
    noremap <buffer> <A-l> <C-w>l
    noremap <buffer> <C-l> <C-w>l
    noremap <silent> <A-f> :call ToggleNetrw()<CR><C-w>l
    noremap <buffer> V :call OpenToRight()<cr>
    noremap <buffer> H :call OpenBelow()<cr>
    noremap <buffer> T :call OpenTab()<cr>
endfunction

augroup netrw_mappings
    autocmd!
    autocmd filetype netrw call NetrwMappings()
augroup END

" Allow for netrw to be toggled
function! ToggleNetrw()
    if g:NetrwIsOpen
        let i = bufnr("$")
        while (i >= 1)
            if (getbufvar(i, "&filetype") == "netrw")
                silent exe "bwipeout " . i
            endif
            let i-=1
        endwhile
        let g:NetrwIsOpen=0
    else
        let g:NetrwIsOpen=1
        silent Lexplore
    endif
endfunction

" Check before opening buffer on any file
function! NetrwOnBufferOpen()
  if exists('b:noNetrw')
      return
  endif
  call ToggleNetrw()
endfun

" Close Netrw if it's the only buffer open
autocmd WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&filetype") == "netrw" || &buftype == 'quickfix' |q|endif

" Make netrw act like a project Draw
augroup ProjectDrawer
  autocmd!
      	" Don't open Netrw
  autocmd VimEnter ~/.config/joplin/tmp/*,/tmp/calcurse*,~/.calcurse/notes/*,~/vimwiki/*,*/.git/COMMIT_EDITMSG let b:noNetrw=1
  autocmd VimEnter * :call NetrwOnBufferOpen()
augroup END

"Move cursor to new window on opening vim
  autocmd VimEnter * wincmd l | :call ToggleNetrw()

let g:NetrwIsOpen=0


" COC-plugins
let g:coc_global_extensions = [
    \ 'coc-snippets',
    \ 'coc-pairs',
    \ 'coc-html',
    \ 'coc-css',
    \ 'coc-json',
    \ 'coc-vimtex',
    \ 'coc-python'
    \ ]

" for jedi + coc-python
let g:python3_host_prog = '~/myfiles/dev/first/bin/python'

" ---------- COC -----------
" -------- settings --------

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>fc  <Plug>(coc-format-selected)
nmap <leader>fc  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to foldcurrent buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
