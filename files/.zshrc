# Z shell configuration file

[[ -d ~/.zsh/ ]] && for file in ~/.zsh/*; do source $file; done


export PROMPT='%n@%B%m%b> '
export RPROMPT='%~ '

if [[ $UID -eq 0 ]]; then
	export PROMPT='%m%B%%%b '
	export HOME="/root"
fi

export HISTFILE=$HOME/.history
export HISTSIZE=100000
export SAVEHIST=100000

export PERL_BADLANG=0

unset LC_ALL
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LC_NUMERIC=en_US.UTF-8
export LC_TIME=en_US.UTF-8
export LC_COLLATE=en_US.UTF-8
export LC_MONETARY=en_US.UTF-8
export LC_MESSAGES=en_US.UTF-8


path=($path /bin /sbin/ /usr/bin/ /usr/sbin/ /usr/local/bin /usr/local/sbin/ $HOME/bin)
typeset -U path

if [[ $- == *i* ]]; then
	export LS_COLORS="di=36;40:ln=35;40:so=32;40:pi=33;40:ex=31;40:bd=34;46:cd=34;43:su=0;41:sg=0;46:tw=:ow=:"

	alias grep='grep --color'
	alias cls='clear'
	alias sc='screen -r'
	alias mc='mc -d -c'
	alias mcedit='mcedit -d -c'

	alias delpyc="find . -name '*.pyc' -delete"
	alias delds="find . -name '.DS_Store' -delete"

	alias sizes='du -h -d1'

	alias find-empty-folders='find . -depth -type d -empty'
	alias kill-empty-folders='find . -depth -type d -empty -exec rmdir "{}" \;'

	alias rainbow='for color in {000..255}; do echo -n "\e[38;5;${color}m ${color} \e[0m";	done'

	autoload compinit
	compinit -c

	zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
	zstyle ':completion::complete:*' use-cache 1
	zstyle ':completion:*:(all-|)files' ignored-patterns '(|*/)CVS'
	zstyle ':completion:*:cd:*' ignored-patterns '(*/)#CVS'

	setopt APPEND_HISTORY
	setopt INC_APPEND_HISTORY
	setopt NO_BEEP
	setopt hist_ignore_space
	setopt list_packed
	setopt transient_rprompt
	setopt HIST_IGNORE_DUPS
	setopt HIST_FIND_NO_DUPS

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

	case $TERM in
		*xterm*|*rxvt*)
			precmd () {print -Pn "\e]2;%n@%m:%~\a"}
			;;
	esac
fi
