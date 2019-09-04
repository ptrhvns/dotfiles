# FIXME This is a work-in-progress. Port bash code to zsh where appropriate.

##############################################################################################
# Keybindings

bindkey -v
bindkey '^R' history-incremental-search-backward

##############################################################################################
# Shell options

ulimit -c unlimited
umask u=rwx,g=rwx,o=rx

setopt append_history
setopt extended_glob
setopt hist_ignore_dups
setopt hist_ignore_space
setopt inc_append_history
setopt no_hist_beep
setopt nobeep
setopt noclobber
setopt prompt_subst
setopt share_history

export PATH=~/bin:/usr/local/bin:/usr/local/sbin:/opt/local/bin:/opt/local/sbin:/bin:/sbin:/usr/bin:/usr/sbin:/usr/proc/bin:/usr/ucb:/usr/libexec/java_home:~/.nodenv/bin
export LD_LIBRARY_PATH=/usr/local/lib:/lib:/usr/lib:/usr/share/lib
export MANPATH=~/sys/man:/usr/local/man:/opt/local/man:/usr/man:/usr/share/man:/usr/local/share/man

if [[ "$LANG" == "en_US.UTF-8" ]]; then
    export NLS_LANG="AMERICAN_AMERICA.AL32UTF8"
fi

##############################################################################################
# General shell variables

export EDITOR=$(command -v vim || command -v vi)
export GPG_TTY=$(tty)
export GUIEDITOR=$(command -v mvim || command -v gvim)
export HISTFILE=~/.zsh_history
export HISTSIZE=1000
export HOMEBREW_NO_ANALYTICS=1
export INPUTRC=~/.inputrc
export LSCOLORS="Hxfxcxdxbxegedabagacad"
export LS_COLORS="di=1;37;40:ln=35;40:so=32;40:pi=33;40:ex=31;40:bd=34;46:cd=34;43:su=0;41:sg=0;46:tw=0;42:ow=0;43:"
export PAGER=$(command -v less || command -v more)
export MANPAGER=$PAGER
export SAVEHIST=1000
export SHELL=$(command -v zsh)
export VISUAL=$(command -v vim || command -v vi)

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

##############################################################################################
# Functions

# Make a directory and then cd into it.
function mkcd() {
    mkdir -p $1 && cd $1
}

CLRTEXT="This is a color test."

# Show all 256 colors with color number.
function print_foreground_colors() {
  for code in {000..255}; do
    print -P -- "$code: %{$CLRFG[$code]%}$CLRTEXT%{$reset_color%}"
  done
}

# Show all 256 colors where the background is set to specific color.
function print_background_colors() {
  for code in {000..255}; do
    print -P -- "$code: %{$CLRBG[$code]%}$CLRTEXT%{$reset_color%}"
  done
}

##############################################################################################
# Aliases

alias c='cat'
alias ctr='ctags -R .'
alias e=$EDITOR

if [[ "$EDITOR" = "$(command -v vim)" ]]; then
    if $(vim --version | awk '{ if ($5 >= 7.0) { exit(0) } else { exit(1) } }'); then
        alias ep="$EDITOR -p"
    fi
fi

function eg() {
    e $(git status -s -uall --ignore-submodules=dirty | egrep -v '[[:blank:]]D|^D' | awk '{print $2}')
}

alias f='fg'

alias g='egrep -i'
alias gv='egrep -iv'

ls -G &> /dev/null
test $? -eq 0 && CR="-G"
ls --color &> /dev/null
test $? -eq 0 && CR="--color=auto"
alias l="ls -Al $CR"
alias la="ls -al $CR"

alias m=$PAGER

alias be='bundle exec'
alias k='keychain --nogui ~/.ssh/id_*~*.pub && source ~/.keychain/$(hostname)-sh'
alias ta='tmux att -t'
alias td='tmux_new_session_pwd'
alias tg='tmux_new_project_for_all_dirty_git'
alias tk='tmux_kill_session'
alias tl='tmux ls'
alias tn='tmux_new_session'
alias tp='tmux_new_project'

##############################################################################################
# Shell prompt

typeset -AHg CLRFX CLRFG CLRBG

CLRFX=(
    reset     "%{[00m%}"
    bold      "%{[01m%}" no-bold      "%{[22m%}"
    italic    "%{[03m%}" no-italic    "%{[23m%}"
    underline "%{[04m%}" no-underline "%{[24m%}"
    blink     "%{[05m%}" no-blink     "%{[25m%}"
    reverse   "%{[07m%}" no-reverse   "%{[27m%}"
)

for color in {000..255}; do
    CLRFG[$color]="%{[38;5;${color}m%}"
    CLRBG[$color]="%{[48;5;${color}m%}"
done

# function prompt_git() {
    # ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
        # ref=$(command git rev-parse --short HEAD 2> /dev/null) || \
        # return 0
    # print -n " ${ref#refs/heads/}"
# }

# function prompt_git_dirty() {
    # (
        # (command git symbolic-ref HEAD > /dev/null 2>&1) || \
        # (command git rev-parse --short HEAD > /dev/null 2>&1)
    # ) && {
        # if test $(git status --porcelain --ignore-submodules=dirty 2> /dev/null | wc -l) -gt 0; then
            # print -n " *"
        # fi

        # if test $(git stash list 2> /dev/null | wc -l) -gt 0; then
            # print -n " #"
        # fi
    # }
# }

# function prompt_ruby() {
    # if command -v rbenv > /dev/null 2>&1; then
        # if [ -f "$(pwd)/.rbenv-version" -o -f "$(pwd)/.ruby-version" ] && rbenv version-name > /dev/null 2>&1; then
            # echo -n " $(rbenv version-name)"
            # if [ -f $(pwd)/.rbenv-gemsets ] && rbenv gemset active > /dev/null 2>&1; then
                # echo -n " $(rbenv gemset active | awk '{print $1}')"
            # fi
        # fi
    # fi
# }

# function prompt_node() {
    # if command -v nodenv > /dev/null 2>&1; then
        # if [ -f "$(pwd)/.node-version" ]; then
            # echo -n " $(nodenv version-name)"
        # fi
    # fi
# }

# Indexes for Solarized colors.
BLUE=033
CYAN=037
GREEN=064
GREY=241
MAGENTA=125
ORANGE=166
RED=124
VIOLET=061
WHITE=254
YELLOW=136

# FIXME prompt does not dynamically regenerate results from functions.
# FIXME move all sections of prompt into their own function.
# PROMPT="$CLRFG[$GREY]%m $CLRFG[$GREEN]%n $CLRFG[$VIOLET]%~%1(j. $CLRFG[$RED][%j].)$CLRFG[$MAGENTA]$(prompt_ruby)$CLRFG[$MAGENTA]$(prompt_node)$CLRFG[$YELLOW]$(prompt_git)$CLRFG[$RED]$(prompt_git_dirty) $CLRFG[$GREY]%# %{$CLRFX[reset]%}"
PROMPT="$CLRFG[$GREY]%m $CLRFG[$GREEN]%n $CLRFG[$VIOLET]%~%1(j. $CLRFG[$RED][%j].) $CLRFG[$GREY]%# %{$CLRFX[reset]%}"

##############################################################################################
# External tool setup

if [ -s ~/.keychain/$(hostname)-sh ]; then
    source ~/.keychain/$(hostname)-sh;
fi

if command -v nodenv 1>/dev/null 2>&1; then
    eval "$(nodenv init -)"
fi

if command -v rbenv 1>/dev/null 2>&1; then
    eval "$(rbenv init - zsh)"
fi

if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init -)"
fi

# # FIXME This doesn't seem to work (commands not visible in shell).
# # if command -v virtualenvwrapper.sh 1>/dev/null 2>&1; then
    # # export WORKON_HOME=${HOME}/.virtualenvs
    # # virtualenvwrapper.sh
# # fi

if command -v cargo 1>/dev/null 2>&1; then
    export PATH=${PATH}:${HOME}/.cargo/bin
fi
