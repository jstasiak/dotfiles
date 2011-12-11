set softtabstop=4
set tabstop=4

set pastetoggle=<F2>


fu Select_expandtab()
    if search('^\t', 'n', 150)
        set shiftwidth=8
        set noexpandtab
    el 
        set shiftwidth=4
        set expandtab
    en
endf

au BufRead,BufNewFile * call Select_expandtab()
au BufRead,BufNewFile Makefile* set noexpandtab

colorscheme evening

highlight BadWhitespace ctermbg=red guibg=red
au BufNewFile * set fileformat=unix
set encoding=utf-8

let python_highlight_all=1
syntax on

filetype plugin on
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS


set ignorecase
set cursorline
set laststatus=2
set nu

if has('mouse')
    set mouse=a
endif


"http://vim.wikia.com/wiki/In_line_copy_and_paste_to_system_clipboard
vmap <C-c> y: call system("xclip -i -selection clipboard", getreg("\""))<CR>
nmap <C-v> :call setreg("\"",system("xclip -o -selection clipboard"))<CR>p

set visualbell

call pathogen#infect()

