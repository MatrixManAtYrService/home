" On Windows, also use '.vim' instead of 'vimfiles'; this makes synchronization across (heterogeneous) systems easier.
if has('win32') || has('win64')
  set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
endif

let mapleader = ","

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
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

set splitbelow
set splitright

" Allow buffer switch away from unsaved
set hidden

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
