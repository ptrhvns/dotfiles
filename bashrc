#!/usr/bin/env bash

# shellcheck disable=SC1090,SC2155

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

unset MAILCHECK

export DISPLAY=$(awk '/nameserver/{print $2}' /etc/resolv.conf):0.0
export EDITOR=$(command -v nvim || command -v vim || command -v vi)
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
export MANPATH=~/sys/man:/usr/local/man:/opt/local/man:/usr/man:/usr/share/man:/usr/local/share/man
export PAGER="$(command -v less || command -v more)"
export PATH=~/bin:~/.local/bin:/usr/local/bin:/usr/local/sbin:/opt/local/bin:/opt/local/sbin:/usr/games:/bin:/sbin:/usr/bin:/usr/sbin:/usr/proc/bin:/usr/ucb:/snap/bin:/mnt/c/Windows/System32
export PROMPT_COMMAND='history -a'
export REDWOOD_DISABLE_TELEMETRY=1
export SHELL=$(command -v bash)
export UNAME=$(uname)
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

truecolor() {
    echo -ne "\033[38;2;${1}m";
}

export NOCOLOR="$(color16 '0')"
export MYCOLORS=$(tput colors)

if [[ $MYCOLORS -gt 255 ]]; then

    BLUE="$(truecolor '126;156;216')" # 7e 9c d8
    CYAN="$(truecolor '106;149;137')" # 6a 95 89
    GREEN="$(truecolor '118;148;106')" # 76 94 6a
    GREY="$(truecolor '114;113;105')" # 72 71 69
    MAGENTA="$(truecolor '149;127;184')" # 95 7f b8
    ORANGE="$(truecolor '255;160;102')" # ff a0 66
    PINK="$(truecolor '210;115;153')" # d2 7e 99
    RED="$(truecolor '255;93;98')" # ff 5d 62
    VIOLET="$(truecolor '149;127;184')" # 95 7f b8
    WHITE="$(truecolor '220;215;186')" # dc d7 ba
    YELLOW="$(truecolor '255;158;59')" # ff 9e 3b

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

if [ -f /usr/lib/git-core/git-sh-prompt ]; then
    source /usr/lib/git-core/git-sh-prompt
    GIT_PROMPT=1
    GIT_PS1_SHOWDIRTYSTATE=1
    GIT_PS1_SHOWSTASHSTATE=1
    GIT_PS1_SHOWUNTRACKEDFILES=1
fi

build_prompt() {
    # TODO: figure out why colors cause Windows Terminal to lose the cursor
    # position on Ctrl-l and other commands.
    #
    # PS1="${PINK}\h"
    #
    # if [[ "root" == "$(whoami)" ]]; then
    #     PS1+=" ${RED}\u"
    # else
    #     PS1+=" ${GREEN}\u"
    # fi
    #
    # PS1+=" ${VIOLET}\w"
    #
    # local num_jobs=$(jobs 2>/dev/null | wc -l)
    #
    # if [ "$num_jobs" -gt 0 ]; then
    #     PS1+=" ${ORANGE}[${num_jobs}]"
    # fi
    #
    # if [ ! -z "${VIRTUAL_ENV}" ]; then
    #     PS1+=" ${BLUE}venv"
    # fi
    #
    # if [ $GIT_PROMPT -gt 0 ]; then
    #     PS1+="${YELLOW}$(__git_ps1 ' %s')"
    # fi
    #
    # PS1+=" ${GREY}\$"
    # PS1+=" ${NOCOLOR}"

    PS1="\h \u \w"

    local num_jobs=$(jobs 2>/dev/null | wc -l)

    if [ "$num_jobs" -gt 0 ]; then
        PS1+=" [${num_jobs}]"
    fi

    if [ ! -z "${VIRTUAL_ENV}" ]; then
        PS1+=" venv"
    fi

    if [ $GIT_PROMPT -gt 0 ]; then
        PS1+="$(__git_ps1 ' %s')"
    fi

    PS1+=" \$ "
}

PROMPT_COMMAND=build_prompt

alias act="source venv/bin/activate"
alias checkipaws="curl http://checkip.amazonaws.com/"
alias firefox='/mnt/c/Program\ Files/Mozilla\ Firefox/firefox.exe'
alias foxit="/mnt/c/Program\ Files\ \(x86\)/Foxit\ Software/Foxit\ Reader/FoxitPDFReader.exe"
alias g="grep -iE"
alias gv="grep -iEv"
alias l="ls"
alias la="ls -la"
alias lg="lazygit"
alias ll="ls -l"
alias m="\$PAGER"
alias notepad='/mnt/c/windows/system32/notepad.exe'
alias pm='python manage.py'
alias ta="tmux attach -t"
alias td="tmux-new-session-pwd"
alias tk="tmux-kill-session"
alias tl="tmux ls"
alias tn="tmux-new-session"
alias ven="python -m venv venv && source venv/bin/activate && pip install --upgrade pip setuptools wheel pip-tools"

if [ -r ~/.ssh-agent ]; then
    source ~/.ssh-agent > /dev/null
fi

if command -v fzf 1>/dev/null 2>&1; then
    fzf_key_bindings="$(dpkg -L fzf | grep key-bindings.bash)"

    if [ -f "$fzf_key_bindings" ]; then
        source "$fzf_key_bindings"
    fi

    fzf_completion="$(dpkg -L fzf | grep completion.bash)"

    if [ -f "$fzf_completion" ]; then
        source "$fzf_completion"
    fi
fi

export PYENV_ROOT="${HOME}/.pyenv"
export PATH=${PATH}:${PYENV_ROOT}/bin

if command -v pyenv 1>/dev/null 2>&1; then
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

if [ -f "$HOME/.bash_local" ]; then
    source "$HOME/.bash_local"
fi

if [ -f "$HOME/.cargo/env" ]; then
    source "$HOME/.cargo/env"
fi
