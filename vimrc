" System Requirements:
" System needs Ag (The Silver Searcher) installed.
" YouCompleteMe has a compile step.
" Ctrlp-cmatcher has a compile step.
" Tern needs npm install to be run in bundle directory.

" PLUGINS ------------------------

call plug#begin('~/.vim/plugged')
Plug 'chriskempson/base16-vim'
Plug 'sheerun/vim-polyglot'
Plug 'mxw/vim-jsx'
Plug 'vim-scripts/django.vim', {'for': 'htmldjango'}
Plug 'rking/ag.vim', {'on': 'Ag'}
Plug 'kien/ctrlp.vim'
Plug 'JazzCore/ctrlp-cmatcher', {'do': './install.sh'}
Plug 'bling/vim-airline'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-commentary'
Plug 'ervandew/supertab'
Plug 'Valloric/YouCompleteMe'
Plug 'SirVer/ultisnips'
Plug 'marijnh/tern_for_vim', {'do': 'npm install'}
Plug 'mattn/emmet-vim'
Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}
Plug 'scrooloose/syntastic'
Plug 'octref/RootIgnore'
Plug 'iandoe/vim-osx-colorpicker', {'on': 'ColorHEX'}
Plug 'AndrewRadev/splitjoin.vim'
Plug 'haya14busa/incsearch.vim'
Plug 'janko-m/vim-test'
call plug#end()

" SETTINGS ------------------------

" Basics
set nocompatible
filetype off
syntax on
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
set nofoldenable                " Say no to code folding...
set nohidden                    " Hide instead of close files when opening a new file while there are unsaved changes
set nowrap                      " Don't word wrap
set cursorline                  " Hightlight current line
set scrolloff=3                 " Keep more context when scrolling off the end of a buffer
set wildmenu                    " Better tab completion for Vim commands
set splitbelow                  " Split horizontal windows below to the current windows
set splitright                  " Split vertical windows right to the current windows

" Style baby
colorscheme base16-ocean
set background=dark

" Search
set incsearch    " Shows the match while typing
set hlsearch     " Highlight found searches
set ignorecase   " Search case insensitive...
set smartcase    " ... but not when search pattern contains upper case characters
set gdefault     " Always do global substitutions - screw /g

" Press comma to turn off highlighting and clear any message already displayed.
nnoremap <silent> , :nohlsearch<Bar>:echo<CR>

" Indentation
set tabstop=2
set shiftwidth=2
set expandtab

" Show tabs and trailing whitespace
set list listchars=tab:»·,trail:·
set list

" Removes the delay when hitting esc in insert mode
set noesckeys
set timeoutlen=1000
set ttimeoutlen=0

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

" LEADER/PERSONAL COMMANDS ------------------------

let mapleader = "\<Space>"

nnoremap <Leader><Leader> :w<CR>
nnoremap <Leader>v :tabe ~/.vim/vimrc<CR>
nnoremap <Leader>b :CtrlPBuffer<CR>
nnoremap <Leader>k :NERDTreeToggle<CR>
nnoremap <Leader>K :NERDTreeFind<CR>
nnoremap <Leader>c :ColorHEX<CR>

" Yank/Paste to system clipboard
nnoremap <Leader>p "+p<CR>
nnoremap <Leader>P "+P<CR>
nnoremap <Leader>o o<Esc>"+p<CR>
nnoremap <Leader>O O<Esc>"+p<CR>
vnoremap <Leader>y "+y<CR>

" Y yanks from current position to end of line.
map Y y$

" Sort
vnoremap <Leader>s :sort<CR>

" Tab Commands
nnoremap tl :tabnext<CR>
nnoremap th :tabprev<CR>
nnoremap tn :tabnew<CR>:CtrlP<CR>
nnoremap tf :tabnew<CR>:Ag "
nnoremap tk :tabfirst<CR>
nnoremap tj :tablast<CR>
nnoremap td :tabclose<CR>
nnoremap to :tabonly<CR>

nnoremap ]a :next<CR>
nnoremap [a :prev<CR>

" Just do ctrl-j/k/l/h to move between splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Repeat dot command in visual mode
xnoremap . :normal .<CR>

" Move down/up by lines on screen
nmap j gj
nmap k gk

" Open and save sessions
command! SaveSession :mks! ~/.vim/sessions/default.vim
command! OpenSession :source ~/.vim/sessions/default.vim

" Just save if I do :W because fingers.
command! W w

" Coding Notes
fun! CloseCodingNotes()
  :bd
endfun
" On save, close the coding notes file.
autocmd BufWritePost ~/Dropbox/Library/coding-notes.txt call CloseCodingNotes()
map <Leader>n :80vsp ~/Dropbox/Library/coding-notes.txt<CR>

" FORMAT SPECIFIC STUFF ------------------------

" Django Syntax for Html Templates
autocmd BufNewFile,BufRead *.html set filetype=htmldjango

" Handlebars Syntax
autocmd BufNewFile,BufRead *.hbs set filetype=html.handlebars syntax=mustache

" Jasmine for tests
autocmd BufReadPost,BufNewFile *_test.js set filetype=jasmine.javascript syntax=jasmine

" Show a line at 105 chars in Python/JS/HTML
autocmd FileType python,html,htmldjango,javascript set colorcolumn=105

" PLUGINS ----------------------------------------

" Test
let g:test#python#runner = 'django'
let g:test#runners = {'Python': ['Django']}

" Syntax
let g:jsx_ext_required = 0

" YouCompleteMe and UltiSnips compatibility, with the help of supertab
" http://stackoverflow.com/a/22253548/1626737
let g:SuperTabDefaultCompletionType = '<C-n>'
let g:SuperTabCrMapping = 0

" YouCompleteMe
let g:ycm_key_list_select_completion = ['<C-j>', '<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-k>', '<C-p>', '<Up>']
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_autoclose_preview_window_after_completion = 1

" Utilsnips
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
let g:UltiSnipsSnippetsDir = $HOME . '/.vim/ultisnips'
let g:UltiSnipsEditSplit = "vertical"

" Syntastic
let g:syntastic_javascript_checkers = ['jshint', 'jscs']
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_python_flake8_args = "--max-line-length=105"
let g:syntastic_aggregate_errors = 1

" Emmet
let g:user_emmet_expandabbr_key = '<c-e>'

" Airline
let g:airline_left_sep = ''
let g:airline_right_sep = ''
set laststatus=2

" Javascript
let g:javascript_enable_domhtmlcss = 1

" CTags
:set tags=./tags

" Colorpicker
let g:colorpicker_app = 'iTerm.app'

" CtrlP
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:15'
let g:ctrlp_switch_buffer = 'et'
let g:ctrlp_max_files = 0
let g:ctrlp_use_caching = 0
let g:ctrlp_cache_dir = $HOME . '/.vim/.ctrlp'
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_match_func = {'match' : 'matcher#cmatch' }
if executable('ag')
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

" Commentary
autocmd FileType htmldjango set commentstring={#\ %s\ #}

" NerdTree
let NERDTreeIgnore = ['\.pyc$']

" Incremental Search
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

" FUNCTIONS BABY ------------------------

" Autoreload vimrc
autocmd! bufwritepost ~/.vim/vimrc source %

" Insert mode cursor in Terminal Vim
if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
 let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

" Remove trailing whitespace
fun! StripTrailingWhitespace()
  " Only strip if the b:noStripeWhitespace variable isn't set
  if exists('b:noStripWhitespace')
    return
  endif
  %s/\s\+$//e
endfun
autocmd BufWritePre * call StripTrailingWhitespace()
autocmd FileType python let b:noStripWhitespace=1 " Don't strip whitespace for Python

" :Qargs - put quickfixlist into argslist.
command! -nargs=0 -bar Qargs execute 'args' QuickfixFilenames()
function! QuickfixFilenames()
  let buffer_numbers = {}
  for quickfix_item in getqflist()
    let buffer_numbers[quickfix_item['bufnr']] = bufname(quickfix_item['bufnr'])
  endfor
  return join(map(values(buffer_numbers), 'fnameescape(v:val)'))
endfunction
