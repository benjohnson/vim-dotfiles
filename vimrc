call plug#begin('~/.vim/plugged')
" Color schemes
Plug 'easysid/mod8.vim'
Plug 'joshdick/onedark.vim'
Plug 'chriskempson/base16-vim'
Plug 'ayu-theme/ayu-vim'

" Plug 'ycm-core/YouCompleteMe'

" Everything else
Plug 'octref/RootIgnore'
Plug 'airblade/vim-gitgutter'
Plug 'bling/vim-airline'
Plug 'rking/ag.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'nixprime/cpsm'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'michaeljsmith/vim-indent-object'
Plug 'dense-analysis/ale'
Plug 'AndrewRadev/sideways.vim'
Plug 'tpope/vim-fugitive'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'markonm/traces.vim'

Plug 'lepture/vim-jinja'

" PlantUML support
Plug 'aklt/plantuml-syntax'
Plug 'tyru/open-browser.vim'
Plug 'weirongxu/plantuml-previewer.vim'
call plug#end()

set nocompatible
filetype off
syntax on

set termguicolors
" let ayucolor="dark"
" colorscheme ayu
" colorscheme base16-eighties
" colorscheme onedark
colorscheme mod8

" Fix a temporary problem with netrw clobbering yank
" https://github.com/vim/vim/commit/91359014b359cf816bf943fe2c7d492996263def
let g:netrw_banner = 1

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
set ignorecase
set smartcase                   " If it's a capital, search case sensitive.

" Maybe?
set lazyredraw

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

" Change iTerm cursor
if $TERM_PROGRAM =~ "iTerm"
    let &t_SI = "\<Esc>]50;CursorShape=1\x7" " Vertical bar in insert mode
    let &t_EI = "\<Esc>]50;CursorShape=0\x7" " Block in normal mode
endif

" LEADER/PERSONAL COMMANDS ------------------------

let mapleader = "\<Space>"

nnoremap <Leader><Leader> :w<CR>
nnoremap <Leader>v :tabe ~/.vim/vimrc<CR>

" Use prettier to format.
" nnoremap <Leader>f :w<CR>ma:%! prettier --stdin --single-quote --trailing-comma es5 --print-width 80 --tab-width 2<CR>'a:w<CR>:delmarks a<CR>
nnoremap <Leader>f :ALEFix prettier<CR>:w<CR>

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

" CtrlP
nnoremap <Leader>b :CtrlPBuffer<CR>

nnoremap <Leader><Left> :SidewaysLeft<CR>
nnoremap <Leader><Right> :SidewaysRight<CR>

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

" <Ctrl-l> redraws the screen and removes any search highlighting.
" nnoremap <silent><C-l> :nohl<CR><C-l>

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

" Open file in finder
command! Finder :!open `dirname %`

" CtrlP
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:20'
let g:ctrlp_switch_buffer = 'et'
let g:ctrlp_max_files = 0
let g:ctrlp_use_caching = 0
let g:ctrlp_match_func = {'match': 'cpsm#CtrlPMatch'}
if executable('ag')
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

" deoplete tab-complete
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

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

let g:polyglot_disabled = ['yaml']

let g:deoplete#file#enable_buffer_path = 0

let b:ale_fixers = ['prettier', 'eslint']
let g:ale_typescript_tsserver_use_global = 1
let g:ale_completion_enabled = 1
let g:ale_linters_ignore = {}

" Exit terminal mode with Esc
tnoremap <Esc> <C-\><C-n>

au BufNewFile,BufRead *.njk set ft=jinja

augroup netrw_mapping
    autocmd!
    autocmd filetype netrw call NetrwMapping()
augroup END

function! NetrwMapping()
    noremap <buffer> tl :tabnext<CR>
    noremap <buffer> th :tabprev<CR>
    noremap <buffer> td :tabclose <CR>
endfunction
