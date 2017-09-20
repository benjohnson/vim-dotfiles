" YouCompleteMe has a manual compile step.

" PLUGINS ------------------------

call plug#begin('~/.vim/plugged')
" System
Plug 'tpope/vim-repeat'
Plug 'octref/RootIgnore'
Plug 'airblade/vim-gitgutter'
Plug 'bling/vim-airline'

" Syntax Colors
Plug 'joshdick/onedark.vim'
Plug 'NLKNguyen/papercolor-theme'
Plug 'danilo-augusto/vim-afterglow'

" Search & File Management
Plug 'rking/ag.vim', {'on': 'Ag'}
Plug 'ctrlpvim/ctrlp.vim'
Plug 'JazzCore/ctrlp-cmatcher', {'do': './install.sh'}
Plug 'tpope/vim-vinegar'
Plug 'haya14busa/incsearch.vim'

" Languages & Syntax
Plug 'sheerun/vim-polyglot'
Plug 'posva/vim-vue'
Plug 'w0rp/ale'
Plug 'mattn/emmet-vim'
Plug 'iandoe/vim-osx-colorpicker'

" Autocomplete & Snippets
Plug 'Valloric/YouCompleteMe'

" Motions
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'AndrewRadev/sideways.vim'
Plug 'michaeljsmith/vim-indent-object'
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
" set nofoldenable                " Say no to code folding...
set nohidden                    " Hide instead of close files when opening a new file while there are unsaved changes
set nowrap                      " Don't word wrap
set cursorline                  " Hightlight current line
set scrolloff=3                 " Keep more context when scrolling off the end of a buffer
set wildmenu                    " Better tab completion for Vim commands
set splitbelow                  " Split horizontal windows below to the current windows
set splitright                  " Split vertical windows right to the current windows
set nomore                      " Don't display --MORE--
set nojoinspaces                " Don't use two spaces after a period.

" Search
set incsearch    " Shows the match while typing
set hlsearch     " Highlight found searches
set ignorecase   " Search case insensitive...
set smartcase    " ... but not when search pattern contains upper case characters
set gdefault     " Always do global substitutions - screw /g

" Indentation
set tabstop=2
set shiftwidth=4
set expandtab

" Show tabs and trailing whitespace
set list listchars=tab:»·,trail:·

" Removes the delay when hitting esc in insert mode
" set noesckeys
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

" Incremental substituion previews in NeoVim
if has("nvim")
    set inccommand=nosplit
endif

if has("nvim")
  " Make escape work in the Neovim terminal.
  tnoremap <Esc> <C-\><C-n>

  " Make navigation into and out of Neovim terminal splits nicer.
  tnoremap <C-h> <C-\><C-N><C-w>h
  tnoremap <C-j> <C-\><C-N><C-w>j
  tnoremap <C-k> <C-\><C-N><C-w>k
  tnoremap <C-l> <C-\><C-N><C-w>l

  " Relative numbering when in normal mode.
  autocmd TermOpen * setlocal conceallevel=0 colorcolumn=0 relativenumber

  " Prefer Neovim terminal insert mode to normal mode.
  " autocmd BufEnter term://* startinsert
endif

" LEADER/PERSONAL COMMANDS ------------------------

let mapleader = "\<Space>"

nnoremap <Leader><Leader> :w<CR>
nnoremap <Leader>v :tabe ~/.vim/vimrc<CR>
nnoremap <Leader>b :CtrlPBuffer<CR>
nnoremap <Leader>k :Explore<CR>
nnoremap <Leader>c :ColorHEX<CR>

" Snippets
nnoremap ,log iconsole.log()<ESC>i
nnoremap ,wlog Iconsole.log(<ESC>A)<ESC>

" Use prettier to format.
nnoremap <Leader>f :w<CR>ma:%! prettier --stdin --single-quote --trailing-comma es5 --print-width 80 --tab-width 4<CR>'a:w<CR>:delmarks a<CR>

" Run Tests
" let test#python#djangotest#options = '--keepdb --nocapture --nologcapture'
" let test#python#runner = 'djangonose'
" nmap <silent> <leader>z :w<CR>:TestNearest<CR>
nmap <Leader>z :w<CR>:!source ~/.bash_profile && nvm use && npm test<CR>
" nmap <silent> <Leader>x :w<CR>:TestLast<CR>

" Yank/Paste to system clipboard
nnoremap <Leader>p "+p<CR>
nnoremap <Leader>P "+P<CR>
vnoremap <Leader>y "+y<CR>

" Sideways
nnoremap <Leader><Left> :SidewaysLeft<CR>
nnoremap <Leader><Right> :SidewaysRight<CR>

" Tab Commands
nnoremap tl :tabnext<CR>
nnoremap th :tabprev<CR>
nnoremap tn :tabnew<CR>:CtrlP<CR>
nnoremap tf :tabnew<CR>:Ag "
nnoremap tk :tabfirst<CR>
nnoremap tj :tablast<CR>
nnoremap td :tabclose<CR>
nnoremap to :tabonly<CR>

" Normal mode with jk
inoremap jk <ESC>
inoremap kj <ESC>

" Simplified linewise autocomplete
inoremap <C-l> <C-x><C-l>

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
cabbrev Wall wall
cabbrev ag Ag
cabbrev tmove tabmove

" Wrap buffer in an AMD module
command! Module :normal ggiggidefine(function(require) {>GGo});gg

" FORMATTING ---------------------------------------------

let g:javascript_plugin_jsdoc = 1

" Django Syntax for Html Templates
" autocmd BufNewFile,BufRead *.html set filetype=htmldjango

" Handlebars Syntax
let g:polyglot_disabled = ['html5']
let g:mustache_operators = 0
autocmd BufNewFile,BufRead *.html set filetype=html.handlebars syntax=mustache
autocmd BufNewFile,BufRead *.hbs set filetype=html.handlebars syntax=mustache

" Jasmine for tests
autocmd BufReadPost,BufNewFile *_test.js set filetype=jasmine.javascript syntax=jasmine

" Show a line at 80 and then 105 chars in JS/HTML
autocmd FileType html,htmldjango,javascript,javascript.jsx set colorcolumn=80

" PLUGINS ----------------------------------------

" Syntax
let g:jsx_ext_required = 0
let python_highlight_all = 1

" YouCompleteMe
" let g:ycm_key_list_select_completion = ['<C-j>', '<C-n>', '<Down>']
" let g:ycm_key_list_previous_completion = ['<C-k>', '<C-p>', '<Up>']
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_complete_in_comments_and_strings = 0

" Syntastic
" let g:syntastic_html_checkers = []
" let g:syntastic_javascript_checkers = ['eslint']
" let g:syntastic_aggregate_errors = 1
" let g:syntastic_error_symbol = '❌'
" let g:syntastic_style_error_symbol = '⁉️'
" let g:syntastic_warning_symbol = '⚠️'
" let g:syntastic_style_warning_symbol = '💩'
" highlight link SyntasticErrorSign SignColumn
" highlight link SyntasticWarningSign SignColumn
" highlight link SyntasticStyleErrorSign SignColumn
" highlight link SyntasticStyleWarningSign SignColumn
let g:ale_set_loclist = 0
let g:ale_lint_on_text_changed = 'never'

" Emmet
let g:user_emmet_expandabbr_key = '<c-e>'

" Easymotion
let g:EasyMotion_do_mapping = 0
nmap s <Plug>(easymotion-s)
omap s <Plug>(easymotion-s)

" Airline
set laststatus=2
let g:airline_section_x = airline#section#create(['filetype'])
let g:airline#extensions#ctrlp#show_adjacent_modes = 0
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_section_b = ''
let g:airline_section_y = ''
let g:airline_section_z = ''

" CtrlP
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:20'
let g:ctrlp_switch_buffer = 'et'
let g:ctrlp_max_files = 0
let g:ctrlp_use_caching = 0
let g:ctrlp_match_func = {'match' : 'matcher#cmatch' }
if executable('ag')
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

" Commentary
autocmd FileType htmldjango set commentstring={#\ %s\ #}
autocmd FileType vue set commentstring=//\ %s

" Incremental Search
let g:incsearch#auto_nohlsearch = 1
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)

" GOYO ------------------------

nnoremap <Leader>g :Goyo<CR>

function! s:goyo_enter()
  set wrap
  set linebreak
  set spell
endfunction

function! s:goyo_leave()
  set nowrap
  set nolinebreak
  set nospell
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

" FUNCTIONS BABY ------------------------

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

" Toggle Color Scheme
let g:current_theme = 0
function! ToggleColor()
  if (g:current_theme)
    set background=dark
    colorscheme onedark
    let g:current_theme = 0
  else
    set background=light
    colorscheme PaperColor
    let g:current_theme = 1
  endif
endfunc
nnoremap <Leader>i :call ToggleColor()<CR>
