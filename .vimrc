" On Windows, also use '.vim' instead of 'vimfiles'; this makes synchronization across (heterogeneous) systems easier.
if has('win32') || has('win64')
  set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
endif

execute pathogen#infect()
syntax on

set bg=dark
set colorcolumn=120

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

"" Nerd-tree
"nmap <leader>n :NERDTreeFind<cr>
"
"" update CWD based on NERDTree root
"let g:NERDTreeChDirMode       = 2
"
" Airline
" =======
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_min_count = 2
set laststatus=2
let &t_Co=256
"
"" ======
"" Setup some default ignores
"let g:ctrlp_custom_ignore = {
"  \ 'dir':  '\v[\/](\.(git|hg|svn)|\_site)$',
"  \ 'file': '\v\.(exe|so|dll|class|png|jpg|jpeg)$',
"\}
"
"" Use the nearest .git directory relative to file
""let g:ctrlp_working_path_mode = 'r'
"
"" Use the nearest .git directory relative to CWD
"let g:ctrlp_working_path_mode = 'rw'
"
" " Find in cwd
"nmap <leader>fd :CtrlPMixed<cr>
" " Find in open buffers
"nmap <leader>fb :CtrlPBuffer<cr>
" " Find among recently used
"nmap <leader>fr :CtrlPMRU<cr>
" " Mix of above
"nmap <leader>ff :CtrlP<cr>
"
"let g:ctrlp_regexp = 1
"
"" Buffgator
"" =========
"
"" Use the right side of the screen
"let g:buffergator_viewport_split_policy = 'R'
"" I want my own keymappings...
"let g:buffergator_suppress_keymaps = 1
"" Looper buffers
"let g:buffergator_mru_cycle_loop = 1
"
"nmap <leader>b :BuffergatorOpen<cr>
"nmap <leader>T :enew<cr>
"
"
"
"" Tab/Buffer navigation
"" =====================
"nmap <leader>h :tabp<cr>
"" Go to the previous buffer open
"nmap <leader>j :BuffergatorMruCyclePrev<cr>
"" Go to the next buffer open
"nmap <leader>k :BuffergatorMruCycleNext<cr>
"" View the entire list of buffers open
"nmap <leader>l :tabn<cr>
"
"" quit buffer
"nmap <leader>qb :bp <BAR> bd #<cr>
"
"" quit tab (does not close buffers)
"nmap <leader>qt :tabclose<cr>
"
"" quit other tabs (does not close buffers)
"nmap <leader>qot :tabclose<cr>
"
"" quit window (does not close buffer)
"nmap <leader>qw :close<cr>
"
"" Conque Terminal
"nmap <leader>cb :ConqueTerm bash<cr>
"
"" Screen (vim + gnu screen)
"" =========================
"
"function! GoScreenShell()
"    if g:ScreenShellActive
"        let line=getline('.')
"        :call g:ScreenShellSend(line)
"    else
"        :ScreenShell
"    endif
"endfunction
"
"command! -nargs=+ -complete=file ScreenShellCmd call g:ScreenShellSend("<args>")
"nmap <leader>sc :ScreenShellCmd<space>
"
"nmap <leader>ss :call GoScreenShell()<cr>
"vmap <leader>ss :ScreenSend<cr>
"nmap <leader>sq :ScreenQuit<cr>
"map <leader>s<tab> :call g:ScreenShellFocus()<cr>
