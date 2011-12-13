set nocompatible
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

"allow to put buffer in the background without writing content to disk
set hidden

set softtabstop=4
set tabstop=4

set pastetoggle=<F2>
set history=1000


" automatic selection of tabs or spaces for indentation
fu Select_expandtab()
    if search('^\t', 'n', 150)
        set shiftwidth=8
        set noexpandtab
    el 
        set shiftwidth=4
        set expandtab
    en
endf

set wildmode=list:longest

au BufRead,BufNewFile * call Select_expandtab()
au BufRead,BufNewFile Makefile* set noexpandtab

colorscheme evening

"highlight BadWhitespace ctermbg=red guibg=red
au BufNewFile * set fileformat=unix
set encoding=utf-8

let python_highlight_all=1
syntax on

filetype plugin indent on

autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS

set completeopt+=longest


" Case sensitive search only when uppercase letter present in search string
set ignorecase
set smartcase


" highlighted and incremental search
set hlsearch
set incsearch

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
set listchars=tab:>-,trail:·,eol:$
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


map <F10> :NERDTreeToggle<CR>

