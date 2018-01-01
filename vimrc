set nocompatible " Be iMproved

" Install vim-plug if not installed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

" Plugins {{{
filetype off
call plug#begin('~/.vim/plugged')
Plug 'jeetsukumaran/vim-filebeagle'
Plug 'joshdick/onedark.vim'
Plug 'jreybert/vimagit'
Plug 'junegunn/fzf', { 
\ 'dir': '~/.fzf', 
\ 'do': './install --all' 
\ }
Plug 'junegunn/fzf.vim'
Plug 'mattn/emmet-vim'
Plug 'mhinz/vim-signify'
Plug 'sheerun/vim-polyglot'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'w0rp/ale'
call plug#end()
filetype plugin indent on  " load filetype-specific indent files
"}}}

" Plugin settings {{{
let g:onedark_terminal_italics=1
let g:onedark_termcolors = 16
let g:fzf_commands_expect = 'alt-enter,ctrl-x'
let g:jsx_ext_required = 0
let g:airline#extensions#tabline#enabled = 0
let g:airline#extensions#ale#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme='onedark'
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"
let g:user_emmet_install_global = 0
let g:user_emmet_settings = {
\  'javascript.jsx' : {
\    'extends' : 'jsx',
\  },
\}
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '⚠'
let g:ale_lint_on_enter = 1     
let g:ale_linters = {}
let g:ale_linters['javascript'] = ['eslint']
let g:ale_fixers = {}
let g:ale_fixers['javascript'] = ['eslint', 'prettier']
let g:ale_fix_on_save = 1
let g:ale_javascript_prettier_options = '--single-quote --trailing-comma es5'
let g:ale_sign_column_always = 1

"nmap <silent> <C-k> <Plug>(ale_previous_wrap)
"nmap <silent> <C-j> <Plug>(ale_next_wrap)

nnoremap <silent> <leader><enter> :FZF<CR>
"}}}

" Editing {{{
colorscheme onedark        " colorscheme
syntax on                  " enable syntax processing
if &diff
  syntax off               " No syntax on diffs
endif

" Use system clipboard
set clipboard=unnamed
if has('unnamedplus')
  set clipboard=unnamed,unnamedplus
endif

set autoindent             " indent based on the previous line
set smartindent            " indent based on language, mostly... - alt cindent
set tabstop=2              " number of visual spaces per TAB
set softtabstop=2          " number of spaces in tab when editing
set shiftwidth=2           " number of spaces when reindenting with << >>
set expandtab              " tabs are spaces
set smarttab               " use shiftwidth for newline beggning <Tab>
set number                 " show line numbers
set ruler                  " show line number and column position
set showcmd                " show command in bottom bar
set nocursorline           " don't highlight line. I switch dep on colorscheme
set lazyredraw             " redraw only when we need to.
set showmatch              " highlight matching [{()}]
set nowrap                 " don't wrap text
set wildmenu               " visual autocomplete for command menu
set wildignore+=*.o,*.obj,*.exe,*.so,*.dll,*.pyc,.svn,.hg,.bzr,.git,
  \*.sass-cache,*.class,*.scssc,*.cssc,sprockets%*,*.lessc
set nolist                 " don't show whitespace characters by default
set listchars=""
set listchars+=eol:¬
set listchars+=tab:»·
set listchars+=trail:.
set listchars+=extends:>
set listchars+=precedes:<
" wrap comments, insert comment leader on <Enter>'gq' comment formating, don't break lines on insert
set formatoptions=crql  
set noro                       " no read only annoyance
set encoding=utf-8             " default buffer encoding
set hidden                     " hide buffers instead of being annoying
set synmaxcol=120              " long lines make vim slow
set ttyfast                    " assume fast terminal
set backspace=indent,eol,start " backspace through everything in insert mode
set mousehide                  " hide mouse after chars typed
set mouse=a                    " enable mouse in all modes
set t_vb=                      " no visual bell
set modelines=0                " disable modelines for security
set nomodeline                 " doesn't hurt to double check right?
set nostartofline              " Prevent cursor changing the current column

set autowrite         " writes on make/shell commands
set timeoutlen=500    " time to wait for a command (after leader for example)
set iskeyword+=$,@    " add extra characters for valid parts of variables
set scrolloff=5       " keep 5 lines below the last line when scrolling

" Better complete options to speed it up
set complete=.,w,b,u,U

if exists('+colorcolumn')
  set colorcolumn=80  " color the 80th column differently as a wrapping guide
  if has("autocmd")
    " no wrapping guides on html/xml files... it's annoying
    au FileType html,xhtml,aspvbs setlocal colorcolumn=0
  endif
endif
"}}}

" Searching {{{
set incsearch        " search as characters are entered
set hlsearch         " highlight matches
set ignorecase       " case insensitive search, but...
set smartcase        " do case sensitive if the term includes uppercase chars
"}}}

" Folding {{{
set foldenable          " enable folding
set foldlevelstart=10   " open most folds by default
set foldnestmax=10      " 10 nested fold max
set foldmethod=syntax   " fold based on syntax 
"}}}

" Backups and Undo {{{
" TODO: Do we really need backups? 
set backup       
set backupdir=~/.tmp,~/tmp,/var/tmp,/tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=~/.tmp,~/tmp,/var/tmp,/tmp
set writebackup
set undofile     
set undodir=~/.tmp,~/tmp
set history=1000 
"}}}

" Status line, window title, and command area settings {{{
set laststatus=2   " always show the statusline
set cmdheight=1    " make the command area one line high
set noshowmode     " don't show the mode since Airline shows it
set title          " set the title of the window in the terminal to the file
set showcmd        " show leader waiting for next keypress
"}}}

" Key Bindings {{{
let mapleader="\<Space>" 
let maplocalleader="\\"         
" double tap kills 
map <space><space> :let @/=''<cr>
" jk is escape
inoremap jk <esc>
" save session
nnoremap <leader>s :mksession<CR>
" faster term commands
nmap ! :!
" fix Y so it behaves like D
nnoremap Y y$
" fix annoying bindings
imap <f1> <esc>
vmap <f1> <esc>
nmap <f1> <esc>
nnoremap K <nop>
" kill interactive ex mode with fire
nnoremap Q <nop>
" sane movement with wrap turned on
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk
nnoremap <Down> gj
nnoremap <Up> gk
vnoremap <Down> gj
vnoremap <Up> gk
inoremap <Down> <C-o>gj
inoremap <Up> <C-o>gk
" toggle whitespace characters
nmap <Leader>l :set list!<CR>
" toggle paste mode
nnoremap <Leader>pp :set invpaste paste? <CR>
" easy unhighlight searches
nnoremap <silent> <Leader>. :nohl<Bar>:echo<CR>
" sudo write a file
cmap w!! %!sudo tee > /dev/null %
" makes W send w when it's a command
command! W w
" easy window navigation
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l
" sane split window resize
nmap @sj <C-W>-<C-W>-
nmap @sk <C-W>+<C-W>+
nmap @sh <C-W>><C-W>>
nmap @sl <C-W><<C-W><
" C-t used for tmux!
map <C-t> <nop>
" }}}

" Auto Commands {{{
if has("autocmd")
  autocmd FileType vim setlocal foldmethod=marker
  autocmd FileType html,css,javascript EmmetInstall
  " Open help in vertical split
  autocmd BufWinEnter *.txt if &ft == 'help' | wincmd L | endif
endif
"}}}

" Functions {{{
"}}}
