call plug#begin('~/.vim/plugged')
Plug 'octref/RootIgnore'
Plug 'joshdick/onedark.vim'
Plug 'airblade/vim-gitgutter'
Plug 'bling/vim-airline'
Plug 'rking/ag.vim', {'on': 'Ag'}
Plug 'ctrlpvim/ctrlp.vim'
Plug 'JazzCore/ctrlp-cmatcher', {'do': './install.sh'}
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'michaeljsmith/vim-indent-object'
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  let g:deoplete#enable_at_startup = 1
endif
call plug#end()

set nocompatible
filetype off
syntax on
colorscheme onedark
set termguicolors
set shell=/bin/bash             " Make stuff work nice with Fish
set backspace=indent,eol,start  " Makes backspace key act like a backspace key
set noerrorbells                " No bells when error messages are shown.
set showcmd                     " Show me what I'm typing
set showmode                    " Show current mode
set number                      " Show line numbers
set relativenumber              " Make line numbers relative
set encoding=utf-8              " Set default encoding to UTF-8
set autowrite                   " Automatically save before :next, :make etc.
set autoread                    " Automatically reread changed files without asking me anything
set shiftround                  " When at 3 spaces and I hit >>, go to 4, not 5.
set nohidden                    " Hide instead of close files when opening a new file while there are unsaved changes
set nowrap                      " Don't word wrap
set cursorline                  " Hightlight current line
set scrolloff=3                 " Keep more context when scrolling off the end of a buffer
set wildmenu                    " Better tab completion for Vim commands
set splitbelow                  " Split horizontal windows below to the current windows
set splitright                  " Split vertical windows right to the current windows
set nomore                      " Don't display --MORE--
set nojoinspaces                " Don't use two spaces after a period.

set expandtab " On tab, insert spaces.
set tabstop=2 " Existing tab displayed as spaces.
set shiftwidth=2 " When indenting with > use spaces.

" Show tabs and trailing whitespace
set list listchars=tab:»·,trail:·

" Set undo and backup dirs. Make them if they don't exist.
set undodir=~/.vim/tmp/undo/
set backupdir=~/.vim/tmp/backup/
if !isdirectory(expand(&undodir))
  call mkdir(expand(&undodir), "p")
endif
if !isdirectory(expand(&backupdir))
  call mkdir(expand(&backupdir), "p")
endif

" Turn on persistent undo and backup
set undofile
set backup

" Disable swap files. Live on the edge.
set noswapfile

" Incremental substituion previews in NeoVim
if has("nvim")
    set inccommand=nosplit
endif

" LEADER/PERSONAL COMMANDS ------------------------

let mapleader = "\<Space>"

nnoremap <Leader><Leader> :w<CR>
nnoremap <Leader>v :tabe ~/.vim/vimrc<CR>

" Use prettier to format.
nnoremap <Leader>f :w<CR>ma:%! prettier --stdin --single-quote --trailing-comma es5 --print-width 80 --tab-width 4<CR>'a:w<CR>:delmarks a<CR>

" Yank/Paste to system clipboard
nnoremap <Leader>p "+p<CR>
nnoremap <Leader>P "+P<CR>
vnoremap <Leader>y "+y<CR>

" Tab Commands
nnoremap tl :tabnext<CR>
nnoremap th :tabprev<CR>
nnoremap tn :tabnew<CR>:CtrlP<CR>
nnoremap tf :tabnew<CR>:Ag "
nnoremap tk :tabfirst<CR>
nnoremap tj :tablast<CR>
nnoremap td :tabclose<CR>
nnoremap to :tabonly<CR>

" Repeat dot command in visual mode
xnoremap . :normal .<CR>

" Just do ctrl-j/k/l/h to move between splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Move down/up by lines on screen
nmap j gj
nmap k gk

" Open and save sessions
command! SaveSession :mks! ~/.vim/sessions/default.vim
command! OpenSession :source ~/.vim/sessions/default.vim

" Save me from fat fingers
command! W w
command! Bd bd
cabbrev Qall qall
cabbrev Wall wal
cabbrev ag Ag
cabbrev tmove tabmove

" CtrlP
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:20'
let g:ctrlp_switch_buffer = 'et'
let g:ctrlp_max_files = 0
let g:ctrlp_use_caching = 0
let g:ctrlp_match_func = {'match' : 'matcher#cmatch' }
if executable('ag')
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

" Autoreload vimrc
autocmd! bufwritepost ~/.vim/vimrc source %

" Remove trailing whitespace
function! StripTrailingWhitespace()
  " Only strip if the b:noStripeWhitespace variable isn't set
  if exists('b:noStripWhitespace')
    return
  endif
  %s/\s\+$//e
endfunc
autocmd BufWritePre * call StripTrailingWhitespace()
autocmd FileType python let b:noStripWhitespace=1 " Don't strip whitespace for Python
autocmd FileType markdown let b:noStripWhitespace=1 " Don't strip whitespace for Markdown
