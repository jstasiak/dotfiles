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


call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

filetype plugin indent on


" gnome-terminal doesn't advertise it's support for 256 colors
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

au BufRead,BufNewFile Makefile* set noexpandtab

let g:detectindent_preferred_expandtab = 0
let g:detectindent_preferred_indent = 4

autocmd BufReadPost * :DetectIndent 
autocmd BufReadPost * :set tabstop=4

colorscheme wombat256mod

"highlight BadWhitespace ctermbg=red guibg=red
au BufNewFile * set fileformat=unix
set encoding=utf-8

let python_highlight_all=1
syntax on
		

autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS

set completeopt+=longest

set smartindent
set smarttab

" Set terminal title
set title

" show line numbers
set number

" scroll when x lines from top/bottom border
set scrolloff=3

" make scrolling the viewport faster
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" toggle visible whitespace by <leader>s
set listchars=tab:>\ ,eol:¬,trail:·
nmap <silent> <leader>s :set nolist!<CR>

" intuitive backspace
set backspace=indent,eol,start

set cursorline
set laststatus=2

if has('mouse')
    set mouse=a
endif


"http://vim.wikia.com/wiki/In_line_copy_and_paste_to_system_clipboard
vmap <C-c> y: call system("xclip -i -selection clipboard", getreg("\""))<CR>
nmap <C-v> :call setreg("\"",system("xclip -o -selection clipboard"))<CR>p

set visualbell


"
" Searching/moving
"


" Turn off Vim default regexp characters and use Perl/Python regular
" expressions instead
nnoremap / /\v
vnoremap / /\v


" Case sensitive search only when uppercase letter present in search string
set ignorecase
set smartcase

" Apply substitutions globally by default (without /g at the end)
set gdefault


" highlight found patterns
set hlsearch

" incremental search
set incsearch

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
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_max_height = 40

" Syntastic
let g:syntastic_python_checker='flake8'
let g:syntastic_python_flake8_args='--max-complexity=10 --max-line-length=110'
let g:syntastic_check_on_open=1
let g:syntastic_enable_signs=1
let g:syntastic_echo_current_error=1

" Syntastic makes scrolling line by line very slow when synstatic_enable_signs=1,
" syntastic_echo_current_error=1 and there's a lot of errors in a file
" lazyredraw helps to mitigate it
set lazyredraw
set nocursorline
set nocursorcolumn

" Ack
nnoremap <leader>a :Ack 

"remove gVim menu bar
:set guioptions-=m

"remove gVim toolbar
:set guioptions-=T
