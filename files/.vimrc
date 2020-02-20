" This stuff has to be above pathgen bundle loading because it
" affects loaded bundles
" ============================================================
"
set nocompatible

" this is easier to use than default leader "\"
let mapleader=","


" GUI-related options
if has("gui_running")
    set guifont=Inconsolata\ 10
endif


" some plugins don't work with filetype is on during loading time
filetype off


" Needs to be before pathogen
" Really? Commented out
" set rtp+=/usr/local/opt/fzf

call plug#begin('~/.vim/plugged')

Plug 'autozimu/LanguageClient-neovim', {'branch': 'next','do': 'bash install.sh' }
Plug 'Glench/Vim-Jinja2-Syntax'
Plug 'sjl/badwolf'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'benekastah/neomake'
" Plug 'roxma/nvim-yarp'
Plug 'rust-lang/rust.vim'
" Plug 'tomtom/tcomment_vim'
" Plug 'tomtom/tlib_vim'
" Plug 'MarcWeber/vim-addon-mw-utils'
" Plug 'roxma/vim-hug-neovim-rpc'
Plug 'hynek/vim-python-pep8-indent'
Plug 'tpope/vim-sensible'

call plug#end()


" gnome-terminal doesn't advertise its support for 256 colors
" so we have to help Vim a bit
if $COLORTERM == 'gnome-terminal'
    set t_Co=256
endif


" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" Keep selection after shifting
vnoremap > >gv
vnoremap < <gv

"allow to put buffer in the background without writing content to disk
set hidden
set pastetoggle=<F2>
set history=1000

set list

set wildmode=list:longest

set softtabstop=4
set tabstop=4
set shiftwidth=4


set undolevels=1000      " use many muchos levels of undo
set wildignore=*.swp,*.bak,*.pyc,*.class
set title                " change the terminal's title
set visualbell           " don't beep
set noerrorbells         " don't beep

set nobackup
set noswapfile

" saves some keystrokes!
nnoremap ; :
set expandtab
au BufRead,BufNewFile Makefile* set noexpandtab

colorscheme badwolf

"highlight BadWhitespace ctermbg=red guibg=red
au BufNewFile * set fileformat=unix

let python_highlight_all=1

autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS

set completeopt+=longest

set smartindent

" Set terminal title
set title

" show line numbers
set number

" scroll when x lines from top/bottom border
set scrolloff=5

" make scrolling the viewport faster
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" toggle visible whitespace by <leader>s
nmap <silent> <leader>s :set nolist!<CR>

set cursorline

if has('mouse')
    set mouse=a
endif


set visualbell


"
" Searching/moving
"


" Turn off Vim default regexp characters and use Perl/Python regular
" expressions instead
" nnoremap / /\v
" vnoremap / /\v
" Commented because see nomagic below

" Testing nomagic right now; if doesn't work - reinstante the section above
set nomagic


" Case sensitive search only when uppercase letter present in search string
set ignorecase
set smartcase

" Apply substitutions globally by default (without /g at the end)
set gdefault


" highlight found patterns
set hlsearch

" get rid of highlighting left after last search
nnoremap <leader><space> :noh<cr>

" move between matching parenthesis using tab
nnoremap <tab> %
vnoremap <tab> %

" movement by screen line instead of by file line
nnoremap j gj
nnoremap k gk

" 
" Plugins configuration
" 


" CtrlP
" let g:ctrlp_map = '<c-p>'
" let g:ctrlp_cmd = 'CtrlP'
" let g:ctrlp_max_height = 40
" let g:ctrlp_max_files = 0
" let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
"
"
nnoremap <C-p> :Files<cr>
nnoremap <C-g> :Rg<cr>

let g:neomake_python_enabled_makers = ['flake8', 'mypy']
autocmd! BufWritePost * Neomake
" Opens list of errors automatically if there are any
" let g:neomake_open_list = 2

" Some plugins that display signs on the margins can make scrolling line by
" line very slow. lazyredraw helps to mitigate it
set lazyredraw
set nocursorline
set nocursorcolumn

"remove gVim menu bar
:set guioptions-=m

"remove gVim toolbar
:set guioptions-=T


" This needs to be here so that we can override ttimeout below
" More: https://github.com/tpope/vim-sensible/issues/88#issuecomment-67413355
runtime! plugin/sensible.vim
" Improves Neovim's behaviour when presented with fast input
" More information: https://github.com/neovim/neovim/issues/2454
if has('nvim')
    set nottimeout
endif

"
" NeoVim only at the moment
if exists('&inccommand')
  set inccommand=split
endif


let g:LanguageClient_serverCommands = {
    \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
    \ }

nnoremap <F5> :call LanguageClient_contextMenu()<CR>
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>


let g:rustfmt_autosave = 1

if filereadable(glob("~/.vimrc.local")) 
    source ~/.vimrc.local
endif
