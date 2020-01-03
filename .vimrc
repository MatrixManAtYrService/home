" On Windows, also use '.vim' instead of 'vimfiles'; this makes synchronization across (heterogeneous) systems easier.
if has('win32') || has('win64')
  set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
endif

let mapleader = "\<tab>"

execute pathogen#infect()
syntax on

set colorcolumn=120
"set relativenumber

" Illuminate cursor crosshairs in the current buffer only
au WinLeave * set nocursorline nocursorcolumn
au WinEnter * set cursorline cursorcolumn
set cursorline cursorcolumn

" Don't beep
set noerrorbells visualbell t_vb=
if has('autocmd')
    autocmd GUIEnter * set visualbell t_vb=
endif

" this may need to be changed (1 or 0) depending on the terminal emulator in use
let g:solarized_termtrans = 1
colorscheme solarized

if !empty($CONSOLE_THEME)
    let &bg=$CONSOLE_THEME
else
    set bg=dark
endif

" Spacing stuff
filetype plugin indent on
set tabstop=4
set shiftwidth=4
set expandtab
set backspace=2

" Fix Cygwin Cursor
let &t_ti.="\e[1 q"
let &t_SI.="\e[5 q"
let &t_EI.="\e[1 q"
let &t_te.="\e[0 q"

" Split Navigation

" new split
nnoremap <leader>wv :vsplit<CR>
nnoremap <leader>ws :split<CR>

" move split
nnoremap <leader>wmh <C-W>H
nnoremap <leader>wmj <C-W>J
nnoremap <leader>wmk <C-W>K
nnoremap <leader>wml <C-W>L
" use i3 config to map <C-S-H> to <C-W>H
" use i3 config to map <C-S-J> to <C-W>J
" use i3 config to map <C-S-K> to <C-W>K
" use i3 config to map <C-S-L> to <C-W>L

" move cursor
nnoremap <C-h> <C-W>h
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-l> <C-W>l
nnoremap <leader>wh <C-W>h
nnoremap <leader>wj <C-W>j
nnoremap <leader>wk <C-W>k
nnoremap <leader>wl <C-W>l

" Split navigation from neovim terminal
if has('nvim')
    tnoremap <C-J> <C-\><C-n><C-W><C-J>
    tnoremap <C-K> <C-\><C-n><C-W><C-K>
    tnoremap <C-L> <C-\><C-n><C-W><C-L>
    tnoremap <C-H> <C-\><C-n><C-W><C-H>
    tnoremap <C-Q> <C-\><C-n>
endif

set splitbelow
set splitright

" Allow buffer switch away from unsaved
set hidden

" search for character under cursro
:nnoremap <leader>z xhp/<C-R>-<CR>
:nnoremap <leader>Z xhp?<C-R>-<CR>

" Highlight extra whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()
"
" Airline
" =======
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_min_count = 2
set laststatus=2
let &t_Co=256


" Ctrl-P
" ======
" Setup some default ignores
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.(git|hg|svn)|\_site)$',
  \ 'file': '\v\.(exe|so|dll|class|png|jpg|jpeg)$',
\}

" Use the nearest .git directory relative to file
let g:ctrlp_working_path_mode = 'r'
"
" Use the nearest .git directory relative to CWD
"let g:ctrlp_working_path_mode = 'rw'

 " Find in cwd
nmap <leader>fd :CtrlPMixed<cr>
 " Find in open buffers
nmap <leader>fb :CtrlPBuffer<cr>
 " Find among recently used
nmap <leader>fr :CtrlPMRU<cr>
 " Mix of above
nmap <leader>ff :CtrlP<cr>

let g:ctrlp_regexp = 1

" Nerd-tree
nmap <leader>n :NERDTreeFind<cr>

" update CWD based on NERDTree root
let g:NERDTreeChDirMode       = 2

" Buffergator
" =========

" Use the right side of the screen
let g:buffergator_viewport_split_policy = 'R'
" I want my own keymappings...
let g:buffergator_suppress_keymaps = 1
" Looper buffers
let g:buffergator_mru_cycle_loop = 1
map <leader>T :enew<cr>

nmap <leader>b :BuffergatorOpen<cr>

" ghc-mod
map <silent> tw :GhcModTypeInsert<CR>
map <silent> ts :GhcModSplitFunCase<CR>
map <silent> tq :GhcModType<CR>
map <silent> te :GhcModTypeClear<CR>

" edit vimrc
:nnoremap <leader>ev :vsplit $MYVIMRC<cr>
:nnoremap <leader>sv :source $MYVIMRC<cr>

" ack.vim
let g:ackprg = 'ag --vimgrep --smart-case'
cnoreabbrev ag Ack
cnoreabbrev aG Ack
cnoreabbrev Ag Ack
cnoreabbrev AG Ack

" system clipboard
vmap <C-c> "+y
