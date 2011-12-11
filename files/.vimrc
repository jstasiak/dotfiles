:set shiftwidth=4
:set softtabstop=4
:set tabstop=4
:set expandtab

:set pastetoggle=<F2>


:colorscheme evening

if has("autocmd")
    " Enable file type detection.
    " Use the default filetype settings, so that mail gets 'tw' set to 72,
    " 'cindent' is on in C files, etc.
    " Also load indent files, to automatically do language-dependent indenting.
    filetype plugin indent on
    " ...
endif

