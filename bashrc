#!/usr/bin/env bash

ulimit -c unlimited
umask u=rwx,g=rwx,o=rx

set -o noclobber
set -o vi

bind "set completion-map-case on" # Treat hyphens and underscores as equivalent
bind "set show-all-if-ambiguous on" # Display matches for ambiguous patterns at first tab press
bind -m vi-insert "\C-l":clear-screen
bind Space:magic-space

shopt -s cdable_vars
shopt -s cdspell
shopt -s checkhash
shopt -s checkwinsize
shopt -s cmdhist # Save multi-line commands as one command
shopt -s dotglob
shopt -s extglob
shopt -s histappend
shopt -u mailwarn

export PATH=~/bin:/usr/local/bin:/usr/local/sbin:/opt/local/bin:/opt/local/sbin:/bin:/sbin:/usr/bin:/usr/sbin:/usr/proc/bin:/usr/ucb:/usr/libexec/java_home
export LD_LIBRARY_PATH=/usr/local/lib:/lib:/usr/lib:/usr/share/lib
export MANPATH=~/sys/man:/usr/local/man:/opt/local/man:/usr/man:/usr/share/man:/usr/local/share/man

if [[ "$LANG" == "en_US.UTF-8" ]]; then
    export NLS_LANG="AMERICAN_AMERICA.AL32UTF8"
fi

export SHELL=$(command -v bash)
UNAME=$(uname)
export LSCOLORS="Hxfxcxdxbxegedabagacad"
export LS_COLORS="di=1;37;40:ln=35;40:so=32;40:pi=33;40:ex=31;40:bd=34;46:cd=34;43:su=0;41:sg=0;46:tw=0;42:ow=0;43:"
export HISTTIMEFORMAT="%D %T "
export GPG_TTY=$(tty)
export INPUTRC=~/.inputrc
export HISTFILESIZE=5000
export HISTSIZE=5000
export HISTCONTROL="erasedups:ignoreboth"
export HISTTIMEFORMAT="%d/%m/%y %T "
unset MAILCHECK
export VISUAL=$(type -p vim || type -p vi)
export EDITOR=$(type -p vim || type -p vi)
export GUIEDITOR=$(type -p mvim || type -p gvim)
PROMPT_COMMAND='history -a'
export PAGER=$(type -p less || type -p more)
export MANPAGER=$PAGER
export HOMEBREW_NO_ANALYTICS=1

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
    if [[ "$UNAME" = "SunOS" ]]; then
        infocmp dtterm > /dev/null 2>&1 && export TERM=dtterm
    fi
elif [[ -n "$TMUX" ]]; then
    infocmp screen > /dev/null 2>&1 && export TERM=screen
    infocmp screen-256color > /dev/null 2>&1 && export TERM=screen-256color
    if [[ "$UNAME" = "SunOS" ]]; then
        infocmp dtterm > /dev/null 2>&1 && export TERM=dtterm
    fi
else
    infocmp vt100 > /dev/null 2>&1 && export TERM=vt100
    infocmp xterm > /dev/null 2>&1 && export TERM=xterm
    infocmp xterm-color > /dev/null 2>&1 && export TERM=xterm-color
    infocmp xterm-256color > /dev/null 2>&1 && export TERM=xterm-256color
    if [[ "$UNAME" = "SunOS" ]]; then
        infocmp dtterm > /dev/null 2>&1 && export TERM=dtterm
    fi
fi

if [[ "$TERM" == "dtterm" ]]; then
    export MYCOLORS=256
else
    export MYCOLORS=$(tput colors)
fi

color16() { echo -ne "\[\033[${1}m\]"; }
color256() { echo -ne "\[\033[38;5;${1}m\]"; }

NOCOLOR="$(color16 '0')"

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
# CLRPRMT=$WHITE

if [[ -x "$(type -p locale)" && $(locale | grep UTF | wc -l) -gt 0 ]]; then
    UTF=1
else
    UTF=0
fi

ps_id() {
    echo -n "$(whoami) "
}

ps_host() {
    echo -ne "\h "
}

ps_dir() {
    echo -ne "\w"
}

ps_jobs() {
    local jbs=$(jobs 2>/dev/null | wc -l | awk '{print $1}')
    if test $jbs -gt 0; then
        # echo -ne "[$jbs] "
        echo -ne " [$jbs]"
    fi
}

ps_git() {
    ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
        ref=$(command git rev-parse --short HEAD 2> /dev/null) || \
        return 0
    echo -n " ${ref#refs/heads/}"
}

ps_git_chg() {
    (
        (command git symbolic-ref HEAD > /dev/null 2>&1) || \
        (command git rev-parse --short HEAD > /dev/null 2>&1)
    ) && {
        if test $(git status --porcelain --ignore-submodules=dirty 2> /dev/null | wc -l) -gt 0; then
            echo -n " *"
        fi

        if test $(git stash list 2> /dev/null | wc -l) -gt 0; then
            echo -n ' #'
        fi
    }
}

ps_rb() {
    if type -p rbenv > /dev/null 2>&1; then
        if [ -f "$(pwd)/.rbenv-version" -o -f "$(pwd)/.ruby-version" ] && rbenv version-name > /dev/null 2>&1; then
            echo -n " $(rbenv version-name)"
            if [ -f $(pwd)/.rbenv-gemsets ] && rbenv gemset active > /dev/null 2>&1; then
                echo -n " $(rbenv gemset active | awk '{print $1}')"
            fi
        fi
    fi
}

ps_node() {
    if type -p nodenv > /dev/null 2>&1; then
        if [ -f "$(pwd)/.node-version" ]; then
            echo -n " $(nodenv version-name)"
        fi
    fi
}

ps_prompt() {
    echo -n " > "
}

export PS1="${CLRHOST}$(ps_host)${CLRID}"'$(ps_id)'"${CLRDIR}$(ps_dir)${CLRJBS}"'$(ps_jobs)'"${CLRRB}"'$(ps_rb)'"${CLRNODE}"'$(ps_node)'"${CLRGIT}"'$(ps_git)'"${CLRGITCHG}"'$(ps_git_chg)'"${CLRPRMT}$(ps_prompt)${CLRNONE}"

alias c='cat'
alias ctr='ctags -R .'
alias e=$EDITOR
alias f='fg'

if [[ "$EDITOR" = "$(type -p vim)" ]]; then
    if $(vim --version | awk '{ if ($5 >= 7.0) { exit(0) } else { exit(1) } }'); then
        alias e="$EDITOR -p"
    fi

    alias eh="$EDITOR -c ':help | only'"
fi

function eg {
    e $(git status -s -uall --ignore-submodules=dirty | egrep -v '[[:blank:]]D|^D' | awk '{print $2}')
}

alias g='egrep -i'
alias gv='egrep -iv'

if [[ $UNAME == "SunOS" ]]; then
    alias gq='/usr/xpg4/bin/egrep -iq'
elif [[ $UNAME == "Darwin" ]]; then
    alias gq='/usr/bin/egrep -iq'
fi

alias j='jobs'

if command -v exa 1>/dev/null 2>&1; then
    alias l="exa --long --color=auto --git"
    alias la="exa --long --color=auto --all --git"
    alias lr="exa --long --recurse --color=always --git"
    alias lra="exa --long --recurse --color=always --all --git"
else
    ls -G &> /dev/null
    test $? -eq 0 && CR="-G"
    ls --color &> /dev/null
    test $? -eq 0 && CR="--color=auto"
    alias l="ls -Al $CR"
    alias la="ls -al $CR"
fi

alias m=$PAGER
alias mt="$PAGER +F"

PSARGS="user,pid,args"
test "$(uname -sr)" = "SunOS 5.10" && PSARGS="zone,$PSARGS"
alias pg="ps -eo $PSARGS | egrep -i"
alias pgv="ps -eo $PSARGS | egrep -iv"
alias pm="ps -eo $PSARGS | more"
test "$UNAME" = "Linux" && alias pm="ps -Heo $PSARGS | more"

alias be='bundle exec'
alias k='keychain --nogui ~/.ssh/id_!(*.pub) && source ~/.keychain/$(hostname)-sh'
alias ta='tmux att -t'
alias td='tmux_new_session_pwd'
alias tg='tmux_new_project_for_all_dirty_git'
alias tk='tmux_kill_session'
alias tl='tmux ls'
alias tn='tmux_new_session'
alias tp='tmux_new_project'

colors() {
    for i in {0..255} ; do
        printf "\x1b[38;5;${i}mcolor ${i}\n"
    done
}

if command -v cargo 1>/dev/null 2>&1; then
    export PATH=${PATH}:${HOME}/.cargo/bin
fi

if [ -s ~/.keychain/$(hostname)-sh ]; then
    source ~/.keychain/$(hostname)-sh;
fi

export GREP_OPTIONS='--color=auto'

if command -v rbenv 1>/dev/null 2>&1; then
    eval "$(rbenv init -)"
fi

if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init -)"
fi

# FIXME This doesn't seem to work (commands not visible in shell).
# if command -v virtualenvwrapper.sh 1>/dev/null 2>&1; then
    # export WORKON_HOME=${HOME}/.virtualenvs
    # virtualenvwrapper.sh
# fi

if command -v nodenv 1>/dev/null 2>&1; then
    eval "$(nodenv init -)"
fi

if [ -f ~/.bash_local ]; then
    source ~/.bash_local
fi

if [ -d $HOME/.bash.d ]; then
    for f in $HOME/.bash.d/*; do
        source $f
    done
fi

if [ -d /usr/local/etc/bash_completion.d ]; then
    for f in /usr/local/etc/bash_completion.d/*; do
        if ! ( echo $f | grep -q "ag.bashcomp.sh"); then
            source $f
        fi
    done
fi
