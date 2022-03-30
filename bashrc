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

export EDITOR=$(command -v vim || command -v vi)
export GPG_TTY=$(tty)
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

if command -v batcat 1>/dev/null 2>&1; then
    export MANPAGER="sh -c 'col -bx | batcat -l man -p'"
elif command -v bat 1>/dev/null 2>&1; then
    export MANPAGER="sh -c 'col -bx | bat -l man -p'"
fi

export MANPATH=~/sys/man:/usr/local/man:/opt/local/man:/usr/man:/usr/share/man:/usr/local/share/man
export PAGER=$(command -v less || command -v more)

export PATH=~/bin:~/.local/bin:/usr/local/bin:/usr/local/sbin:/opt/local/bin:/opt/local/sbin:/usr/games:/bin:/sbin:/usr/bin:/usr/sbin:/usr/proc/bin:/usr/ucb:/snap/bin:/mnt/c/Windows/System32

export PROMPT_COMMAND='history -a'
export SHELL=$(command -v bash)
export UNAME=$(uname)
export VISUAL=$(command -v || command -v vim || command -v vi)
unset MAILCHECK

export VIRTUAL_ENV_DISABLE_PROMPT=1

if [[ $(less -V 2>/dev/null | awk '/less [0-9]/{print $2}') -lt 346 ]]; then
    export LESS="-qiX"
else
    export LESS="-FqiRX"
fi

if command -v rg 1>/dev/null 2>&1; then
    export FZF_CTRL_T_COMMAND='rg --files --no-ignore-vcs --hidden'
    export FZF_DEFAULT_COMMAND='rg --files --no-ignore-vcs --hidden'
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
else
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

if [ -f "$HOME/.git-prompt.sh" ]; then
    source $HOME/.git-prompt.sh

    GIT_PS1=1
    GIT_PS1_SHOWDIRTYSTATE=1
    GIT_PS1_SHOWSTASHSTATE=1
    GIT_PS1_SHOWUNTRACKEDFILES=1
fi

build_prompt() {
    local exit_code=$?

    PS1="${GREY}\h"

    if [[ "root" == "$(whoami)" ]]; then
        PS1+=" ${RED}\u"
    else
        PS1+=" ${GREEN}\u"
    fi

    PS1+=" ${VIOLET}\w"

    local num_jobs=$(jobs 2>/dev/null | wc -l)

    if [ $num_jobs -gt 0 ]; then
        PS1+=" ${ORANGE}[${num_jobs}]"
    fi

    if [ $GIT_PS1 -gt 0 ]; then
        PS1+="${YELLOW}$(__git_ps1 ' %s')"
    fi

    if [ $exit_code -gt 0 ]; then
        PS1+=" ${RED}(${exit_code})"
    fi

    PS1+=" ${GREY}\$"
    PS1+=" ${NOCOLOR}"
}

PROMPT_COMMAND=build_prompt

alias g="grep -E"
alias gv="grep -Ev"

if command -v exa 1>/dev/null 2>&1; then
    alias l="exa"
    alias la="exa -la"
    alias ll="exa -l"
    alias lt="exa -T"
else
    alias l="ls"
    alias ll="ls -l"
    alias la="ls -la"

    if command -v tree 1>/dev/null 2>&1; then
        alias lt="tree"
    fi
fi

if command -v batcat 1>/dev/null 2>&1; then
    alias m="batcat -p"
elif command -v bat 1>/dev/null 2>&1; then
    alias m="bat -p"
else
    alias m="${PAGER}"
fi

alias ta="tmux attach -t"
alias td="tmux-new-session-pwd"
alias tk="tmux-kill-session"
alias tl="tmux ls"
alias tn="tmux-new-session"

if [ -r ~/.ssh-agent ]; then
    source ~/.ssh-agent > /dev/null
fi

fzf_key_bindings="$(dpkg -L fzf | grep key-bindings.bash)"
if [ -f $fzf_key_bindings ]; then
    source $fzf_key_bindings
fi

fzf_completion="$(dpkg -L fzf | grep completion.bash)"
if [ -f $fzf_completion ]; then
    source $fzf_completion
fi

export PYENV_ROOT="${HOME}/.pyenv"
export PATH=${PATH}:${PYENV_ROOT}/bin

if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init --path)"
    eval "$(pyenv init -)"

    if [ -d "$(pyenv root)/plugins/pyenv-virtualenv" ]; then
        eval "$(pyenv virtualenv-init -)"
    fi
fi

export NODENV_ROOT=${HOME}/.nodenv
export PATH=${PATH}:${NODENV_ROOT}/bin

if command -v nodenv 1>/dev/null 2>&1; then
    eval "$(nodenv init -)"
fi

export GOENV_ROOT="${HOME}/.goenv"
export PATH=${PATH}:${GOENV_ROOT}/bin

if command -v goenv 1>/dev/null 2>&1; then
    eval "$(goenv init -)"
fi

if [ -f ~/.bash_local ]; then
    source ~/.bash_local
fi
