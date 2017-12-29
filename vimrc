set nocompatible " Be iMproved

" Plugins {{{

" Install vim-plug if not installed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

filetype off
call plug#begin('~/.vim/plugged')

" Automatically install missing plugins on startup
if !empty(filter(copy(g:plugs), '!isdirectory(v:val.dir)'))
  autocmd VimEnter * PlugInstall | q
endif

Plug 'jeetsukumaran/vim-filebeagle'
Plug 'joshdick/onedark.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'mattn/emmet-vim'
Plug 'mhinz/vim-signify'
Plug 'sheerun/vim-polyglot'
Plug 'Shougo/neocomplete.vim'
Plug 'sjl/gundo.vim'
Plug 'skywind3000/asyncrun.vim'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-git'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'w0rp/ale'
call plug#end()
filetype plugin indent on 
"}}}

" Variables and Settings {{{
let mapleader="\<Space>" 
let maplocalleader="\\"         
let g:onedark_terminal_italics=1
let g:onedark_termcolors = 16
let g:onedark_terminal_italics = 1
let g:fzf_commands_expect = 'alt-enter,ctrl-x'
let g:jsx_ext_required = 0
let g:airline#extensions#tabline#enabled = 0
let g:airline_powerline_fonts = 1
let g:airline_theme='onedark'
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"
let g:ale_sign_error = '●'      
let g:ale_sign_warning = '.'
let g:ale_lint_on_enter = 1     
let g:ale_fixers = {
  \ 'javascript': ['eslint']
  \ }

nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)
nnoremap <silent> <leader><enter> :Files<CR>
nnoremap <leader>u :GundoToggle<CR>
"}}}

" Editing {{{
syntax on                  " enable syntax processing
colorscheme onedark        " colorscheme

" No syntax on diffs 
if &diff
  syntax off
endif

filetype plugin indent on  " load filetype-specific indent files
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
set cursorline             " highlight current line
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
set encoding=utf8             " default buffer encoding
set hidden                     " hide buffers instead of being annoying
set synmaxcol=256              " long lines make vim slow
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
set cmdheight=1    " make the command area two lines high
set noshowmode     " don't show the mode since Airline shows it
set title          " set the title of the window in the terminal to the file
set showcmd        " show leader waiting for next keypress
"}}}

" Key Bindings {{{

" double tap kills 
map <space><space> :let @/=''<cr> " clear search
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
  " set vim files foldmethod automatically
  autocmd FileType vim setlocal foldmethod=marker
  " for HTML, generally format text, but if a long line has been created 
  " leave it alone when editing
  au FileType html,xhtml setlocal fo+=tl                      
  " eslint + Prettier on save 
  autocmd BufWritePost *.js AsyncRun -post=checktime ./node_modules/.bin/eslint --fix %
  " Fix trailing whitespace in my most used programming langauges
  autocmd BufWritePre *.py,*.js silent! :StripTrailingWhiteSpace
  " When editing a file, always jump to the last cursor position.
  " This must be after the uncompress commands.
  autocmd BufReadPost *
        \ if line("'\"") > 1 && line ("'\"") <= line("$") |
        \   exe "normal! g`\"" |
        \ endif
  " Open help files in a vertical split
  au BufWinEnter *.txt if &ft == 'help' | wincmd L | endif
endif
"}}}

" Functions {{{
" strips trailing whitespace at the end of files. this
" is called on buffer write in the autogroup above.
function! <SID>StripTrailingWhitespaces()
    " save last search & cursor position
    let _s=@/
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    let @/=_s
    call cursor(l, c)
endfunction

" Platform detection functions
silent function! OSX()
    return has('macunix')
endfunction
silent function! LINUX()
    return has('unix') && !has('macunix') && !has('win32unix')
endfunction
silent function! WINDOWS()
    return  (has('win16') || has('win32') || has('win64'))
endfunction
silent function! UNIXLIKE()
    return !WINDOWS()
endfunction
silent function! FREEBSD()
  let s:uname = system("uname -s")
  return (match(s:uname, 'FreeBSD') >= 0)
endfunction
"}}}
