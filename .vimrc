execute pathogen#infect()
set nu
syntax on
set mouse=a
filetype plugin indent on
set runtimepath^=~/.vim/bundle/ctrlp.vim
set splitright
set tabstop=4 " number of visual spaces per TAB
set softtabstop=4 " number of spaces in tab when editing
set shiftwidth=4 " Indents will have a width of 4
set expandtab " tabs are spaces
set number " show line numbers
set showcmd " show command in bottom bar
set wildmenu " visual autocomplete for command menu
set showmatch " highlight matching [{()}]
set incsearch " search as characters are entered
set backspace=start,eol,indent " fix backspace
set clipboard=unnamed " copy/paste to system clipboard
set laststatus=2 " always display status line
set noshowmode " Don't show the current mode (airline.vim takes care of us)
set title " Show the filename in the window titlebar
set visualbell " Use visual bell instead of audible bell
set wildchar=<TAB> " Character for CLI expansion (TAB-completion)
set smartcase " find based on case
set undofile " Maintain undo history between sessions
set undodir=~/.vim/undodir
set pastetoggle=<F6> " Turn off autoident when pasting code.  :set paste :set nopaste
set list lcs=tab:\�\ ,trail:�

" Trying Plug we'll see
call plug#begin('~/.vim/plugged')
Plug 'sheerun/vim-polyglot'

" Use ripgrep when using Ctrl-P
if executable('rg')
  set grepprg=rg\ --color=never
  let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
  let g:ctrlp_use_caching = 0
endif

let g:ackprg = 'rg --vimgrep --no-heading' " Use ack.vim to search via ag

" ignore binary and Mac files
set wildignore+=*.a,*.o
set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png
set wildignore+=.DS_Store
set wildignore+=*/.git/*,*/tmp/*,~,*.swp,*.tmp

" NERDTree leader
let mapleader = "\<Space>"  " leader is space key
map <silent> <C-n> :NERDTreeFocus<CR>

" CtrlP - Set this to 1 to set searching by filename (as opposed to full path) as the default: >
let g:ctrlp_by_filename = 1

" Ack leader
nnoremap <Leader>a :Ack!<space>

" Git blame
nnoremap <Leader>b :<C-u>call gitblame#echo()<CR>

" disable arrow keys
nnoremap <Left> :echo "No left for you!"<CR>
nnoremap <Right> :echo "No right for you!"<CR>
nnoremap <Up> :echo "No up for you!"<CR>
nnoremap <Down> :echo "No down for you!"<CR>

" Move focus on window panes
nnoremap <Leader>l <C-w>l
nnoremap <Leader>h <C-w>h
nnoremap <Leader>k <C-w>k
nnoremap <Leader>j <C-w>j

" Color scheme and visuals
set background=dark
colorscheme gruvbox
set t_Co=256  " vim-monokai now only support 256 colours in terminal.
let g:airline_theme='gruvbox'

" Enable ALE
let g:ale_linters = {
    \ 'yaml': ['yamllint'],
    \}
" Enable linting on text change and save
let g:ale_lint_on_text_changed = 'always'
let g:ale_lint_on_insert_leave = 1

let g:ale_fixers = {
\   'yaml': ['prettier'],
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['eslint'],
\}

let g:ale_completion_enabled = 1

" Set this variable to 1 to fix files when you save them.
let g:ale_fix_on_save = 1

" Fix Yaml and sh file editing
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType sh setlocal ts=2 sts=2 sw=2 expandtab

" hightlight extra white space
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" Daren
iabbrev istd #include <stdio.h><CR>#include <stdlib.h><CR>#include <string.h><CR>int main() {<CR><CR>}
let @i = 'i�PS#include <stdio.h>int main() {}[201~�ku'
command! FindString call FindStringFunction()
function! FindStringFunction()
    let searchString = input('Enter search string: ')
    execute 'vim ' . searchString . ' **/* | copen'
endfunction

nnoremap <leader>f :FindString<CR>


" Quit NERDTree & Startify
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Auto start NERDTree & Startify
autocmd VimEnter *
                \   if !argc()
                \ |   Startify
                \ |   NERDTree
                \ |   wincmd w
                \ | elseif argc()
                \ |   NERDTree
                \ |   wincmd w
                \ | endif
