#!/usr/bin/env bash

ulimit -c unlimited
umask 022

if tty -s; then
    bind "set completion-map-case on"
    bind "set show-all-if-ambiguous on"
    bind -m vi-insert "\C-l":clear-screen
    bind Space:magic-space
fi

set -o noclobber
set -o vi

shopt -s cdable_vars
shopt -s cdspell
shopt -s checkhash
shopt -s checkwinsize
shopt -s cmdhist
shopt -s dotglob
shopt -s extglob
shopt -s histappend
shopt -u mailwarn

export EDITOR=$(command -v vim || type -p vi)
export GPG_TTY=$(tty)
export GUIEDITOR=$(command -v mvim || command -v gvim)
export HISTCONTROL="erasedups:ignoreboth"
export HISTFILESIZE=5000
export HISTSIZE=5000
export HISTTIMEFORMAT="%D %T "
export HISTTIMEFORMAT="%d/%m/%y %T "
export INPUTRC=~/.inputrc
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
export LD_LIBRARY_PATH=/usr/local/lib:/lib:/usr/lib:/usr/share/lib
export LS_COLORS="di=1;37;40:ln=35;40:so=32;40:pi=33;40:ex=31;40:bd=34;46:cd=34;43:su=0;41:sg=0;46:tw=0;42:ow=0;43:"
export LSCOLORS="Hxfxcxdxbxegedabagacad"
export MANPAGER=$(command -v less || command -v more)
export MANPATH=~/sys/man:/usr/local/man:/opt/local/man:/usr/man:/usr/share/man:/usr/local/share/man
export PAGER=$(command -v less || command -v more)

export PATH=~/bin:~/.local/bin:/usr/local/bin:/usr/local/sbin:/opt/local/bin:/opt/local/sbin:/bin:/sbin:/usr/bin:/usr/sbin:/usr/proc/bin:/usr/ucb:/snap/bin:/usr/libexec/java_home:~/.nodenv/bin:~/.pyenv/bin:~/.rbenv/bin:/mnt/c/Windows/System32:~/.cargo/bin:~/.rustup:/usr/local/go/bin

export PROMPT_COMMAND='history -a'
export SHELL=$(command -v bash)
export UNAME=$(uname)
export VISUAL=$(command -v vim || command -v vi)
unset MAILCHECK

if [[ $(less -V 2>/dev/null | awk '/less [0-9]/{print $2}') -lt 346 ]]; then
    export LESS="-qiX"
else
    export LESS="-FqiRWX"
fi

if [[ "$(tty)" = "/dev/console" ]]; then
    export TERM=vt100
elif [[ "$TERM" = screen* && -z "$TMUX" ]]; then
    infocmp screen > /dev/null 2>&1 && export TERM=screen
    infocmp screen-256color > /dev/null 2>&1 && export TERM=screen-256color
elif [[ -n "$TMUX" ]]; then
    infocmp screen > /dev/null 2>&1 && export TERM=screen
    infocmp screen-256color > /dev/null 2>&1 && export TERM=screen-256color
else
    infocmp vt100 > /dev/null 2>&1 && export TERM=vt100
    infocmp xterm > /dev/null 2>&1 && export TERM=xterm
    infocmp xterm-color > /dev/null 2>&1 && export TERM=xterm-color
    infocmp xterm-256color > /dev/null 2>&1 && export TERM=xterm-256color
fi

color16() {
    echo -ne "\[\033[${1}m\]";
}

color256() {
    echo -ne "\[\033[38;5;${1}m\]";
}

export NOCOLOR="$(color16 '0')"
export MYCOLORS=$(tput colors)

if [[ $MYCOLORS -gt 255 ]]; then
    BLUE="$(color256 '33')"
    CYAN="$(color256 '37')"
    GREEN="$(color256 '64')"
    GREY="$(color256 '241')"
    MAGENTA="$(color256 '125')"
    ORANGE="$(color256 '166')"
    RED="$(color256 '124')"
    VIOLET="$(color256 '61')"
    WHITE="$(color256 '254')"
    YELLOW="$(color256 '136')"
elif [[ $MYCOLORS -gt 7 ]]; then
    BLUE="$(color16 '1;34')"
    CYAN="$(color16 '1;36')"
    GREEN="$(color16 '1;32')"
    GREY="$(color16 '1;30')"
    MAGENTA="$(color16 '1;34')"
    ORANGE="$(color16 '1;33')"
    RED="$(color16 '1;31')"
    VIOLET="$(color16 '1;35')"
    WHITE="$(color16 '1;37')"
    YELLOW="$(color16 '1;33')"
fi

CLRDIR=$VIOLET
CLRGIT=$YELLOW
CLRGITCHG=$RED
CLRGITSTASH=$RED
CLRHOST=$GREY
CLRNODE=$MAGENTA
CLRRB=$MAGENTA

if [[ "root" == "$(whoami)" ]]; then
    CLRID=$RED
else
    CLRID=$GREEN
fi

CLRJBS=$RED
CLRNONE=$NOCOLOR
CLRPRMT=$GREY

ps_jobs() {
    local jbs=$(jobs 2>/dev/null | wc -l | awk '{print $1}')
    if test $jbs -gt 0; then
        echo -ne " [$jbs]"
    fi
}

if [ -f "$HOME/.git-prompt.sh" ]; then
    source $HOME/.git-prompt.sh

    GIT_PS1_SHOWDIRTYSTATE=1
    GIT_PS1_SHOWSTASHSTATE=1
    GIT_PS1_SHOWUNTRACKEDFILES=1

    export PS1="${CLRHOST}\h ${CLRID}\u ${CLRDIR}\w${CLRJBS}"'$(ps_jobs)'"${CLRGIT}"'$(__git_ps1 " %s")'" ${CLRPRMT}\n\$${CLRNONE} "
else
    export PS1="${CLRHOST}\h ${CLRID}\u ${CLRDIR}\w${CLRJBS}"'$(ps_jobs)'" ${CLRPRMT}\n\$${CLRNONE} "
fi

alias c='cat'

colors() {
    for i in {0..255} ; do
        printf "\x1b[38;5;${i}mcolor ${i}\n"
    done
}

alias e=$EDITOR

if [[ "$EDITOR" = "$(command -v vim)" ]]; then
    if $(vim --version | awk '{ if ($5 >= 7.0) { exit(0) } else { exit(1) } }'); then
        alias ep="$EDITOR -p"
    fi
fi

eg() {
    e $(git status -s -uall --ignore-submodules=dirty | egrep -v '[[:blank:]]D|^D' | awk '{print $2}')
}

randgen() {
    echo $(openssl rand 60 | openssl base64 -A)
}

alias f='fg'
alias g='egrep -i'
alias gv='egrep -iv'
alias j='jobs'

ls -G &> /dev/null
test $? -eq 0 && CR="-G"

ls --color &> /dev/null
test $? -eq 0 && CR="--color=auto"

alias l="ls -Al $CR"
alias la="ls -al $CR"
alias m=$PAGER
alias ta='tmux att -t'
alias td='tmux_new_session_pwd'
alias tg='tmux_new_project_for_all_dirty_git'
alias tk='tmux_kill_session'
alias tl='tmux ls'
alias tn='tmux_new_session'
alias tp='tmux_new_project'

if command -v nodenv 1>/dev/null 2>&1; then
    eval "$(nodenv init -)"
fi

if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init -)"

    if [ -d "$(pyenv root)/plugins/pyenv-virtualenv" ]; then
        eval "$(pyenv virtualenv-init -)"
    fi
fi

if command -v rbenv 1>/dev/null 2>&1; then
    eval "$(rbenv init -)"
fi

if [ -f ~/.bash_local ]; then
    source ~/.bash_local
fi

