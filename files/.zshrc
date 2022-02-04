# ZSH Configuration
# Based on https://github.com/urbaniak/dotfiles/blob/master/.zshrc.symlink

autoload -U colors && colors

if [[ $UID -eq 0 ]]; then
    COLOR=red
else
    COLOR=green
fi

export TERM=xterm-256color

export PROMPT='%{$fg['$COLOR']%}%n@%B%m%b%f%{$reset_color%} %{$fg[cyan]%}%*%{$reset_color%} ${vcs_info_msg_0_}%b%f%~%{$fg['$COLOR']%}%#%{$reset_color%} '
export RPROMPT=''

export CLICOLOR=1

LS_COLORS="di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=01;05;37;41:mi=01;05;37;41:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=01;32";
LSCOLORS="ExGxFxDxCxDxDxhbhdacEc";

if ls --color -d . &>/dev/null 2>&1; then
  # Linux
  export LS_COLORS=$LS_COLORS
  alias ls='ls -GF --color=tty'
else
  # BSD
  export LSCOLORS=$LSCOLORS
  alias ls='ls -GF'
fi


export HISTFILE=$HOME/.history
export HISTSIZE=10000000
export SAVEHIST=10000000

export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LC_NUMERIC=en_US.UTF-8
export LC_TIME=en_US.UTF-8
export LC_COLLATE=en_US.UTF-8
export LC_MONETARY=en_US.UTF-8
export LC_MESSAGES=en_US.UTF-8
export PERL_BADLANG=0
unset LC_ALL

export PYTHONSTARTUP=$HOME/.pythonrc.py

path=(~/bin /usr/local/sbin /usr/local/bin /bin /sbin /usr/bin /usr/sbin $path)
typeset -U path

fpath=($fpath ~/.zsh/functions)
typeset -U fpath

if [[ $- == *i* ]]; then
    alias grep='grep --color'
    alias sc='tmux attach'
    alias mc='mc -d -c'

    alias rainbow='for color in {000..255}; do echo -n "\e[38;5;${color}m ${color} \e[0m";  done'

    autoload compinit
    compinit -c

    zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
    zstyle ':completion::complete:*' use-cache 1
    zstyle ':completion:*' menu select
    zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' \
        'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

    setopt autocd
    setopt nobeep
    setopt list_packed
    setopt transient_rprompt
    setopt hist_ignore_dups
    setopt hist_find_no_dups
    setopt hist_ignore_space
    setopt appendhistory
    setopt sharehistory
    setopt incappendhistory

    bindkey '^[[A' up-line-or-search
    bindkey '^[[B' down-line-or-search
    bindkey ' ' magic-space
    bindkey '^K' kill-region
    bindkey '^A' beginning-of-line
    bindkey '^E' end-of-line
    bindkey '^L' clear-screen
    bindkey '^H' backward-delete-char
    bindkey '^?' backward-delete-char
    bindkey '^[[3~' delete-char
    bindkey '^[[2~' overwrite-mode

    bindkey "\e[H" beginning-of-line
    bindkey "\e[F" end-of-line

    bindkey '\e[7~' beginning-of-line
    bindkey '\e[8~' end-of-line

    bindkey '^[[1~' beginning-of-line
    bindkey '^[[4~' end-of-line

    bindkey '^[[H' beginning-of-line
    bindkey '^[[F' end-of-line

    bindkey '^[OH' beginning-of-line
    bindkey '^[OF' end-of-line
    bindkey '^[O5H' beginning-of-line
    bindkey '^[O5F' end-of-line

    autoload -Uz vcs_info

    zstyle ':vcs_info:*' stagedstr '%F{28}●'
    zstyle ':vcs_info:*' unstagedstr '%F{11}●'
    zstyle ':vcs_info:*' check-for-changes true
    zstyle ':vcs_info:*' enable git

    precmd() {

        case $TERM in
            *xterm*|*rxvt*)
                print -Pn "\e]2;%n@%m:%~\a"
            ;;
        esac

        if [[ -z $(git ls-files --other --exclude-standard 2> /dev/null) ]] {
            zstyle ':vcs_info:*' formats '%F{green}%b%c%u%f '
        } else {
            zstyle ':vcs_info:*' formats '%F{green}%b%c%u%F{red}●%f '
        }

        vcs_info
    }

    setopt prompt_subst
    setopt promptsubst

    autoload -U promptinit
    promptinit
fi

export LINUXBREWHOME=$HOME/.linuxbrew

if [ -d "$LINUXBREWHOME" ]; then
    # Until LinuxBrew is fixed, the following is required.
    # See: https://github.com/Homebrew/linuxbrew/issues/47
    export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:/usr/local/lib64/pkgconfig:/usr/lib64/pkgconfig:/usr/lib/pkgconfig:/usr/lib/x86_64-linux-gnu/pkgconfig:/usr/lib64/pkgconfig:/usr/share/pkgconfig:$PKG_CONFIG_PATH
    ## Setup linux brew
    export PATH=$LINUXBREWHOME/bin:$PATH
    export MANPATH=$LINUXBREWHOME/man:$MANPATH
    export PKG_CONFIG_PATH=$LINUXBREWHOME/lib64/pkgconfig:$LINUXBREWHOME/lib/pkgconfig:$PKG_CONFIG_PATH
    export LD_LIBRARY_PATH=$LINUXBREWHOME/lib64:$LINUXBREWHOME/lib:$LD_LIBRARY_PATH
fi;

# https://github.com/Homebrew/brew/blob/master/share/doc/homebrew/Analytics.md#opting-out
export HOMEBREW_NO_ANALYTICS=1

# https://github.com/kennethreitz/pipenv/pull/395
export PIPENV_IGNORE_VIRTUALENVS=1

export PIPENV_SHELL_COMPAT=1

LOCAL=$HOME/local
LOCALBIN=$LOCAL/bin
LOCALLIB=$LOCAL/lib

if [ -d $LOCALBIN ]; then
    export PATH=$LOCALBIN:$PATH
fi;

if [ -d $LOCALLIB ]; then
    export DYLD_LIBRARY_PATH=$LOCALLIB:$DYLD_LIBRARY_PATH
    export LD_LIBRARY_PATH=$LOCALLIB:$LD_LIBRARY_PATH
fi;

which nvim > /dev/null && export EDITOR=nvim;
alias vim=nvim;

function git-delete-branches() {
    git branch |
        grep --invert-match '\*' |
        cut -c 3- |
        fzf --multi --preview="git log {} --" |
        xargs git branch --delete --force
}

[[ -e ~/.profile ]] && source ~/.profile
[[ -e ~/.zsh.local ]] && source ~/.zsh.local
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
