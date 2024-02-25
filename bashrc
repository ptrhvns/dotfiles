#!/usr/bin/env bash

# shellcheck disable=SC1090,SC2155,SC1091

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

UBUNTU=false
RED_HAT=false

if [[ -f "/etc/os-release" ]]; then
    if [[ "$(grep -c 'Ubuntu' /etc/os-release)" -gt 0 ]]; then
        UBUNTU=true
    elif [[ "$(grep -c 'Fedora Linux' /etc/os-release)" -gt 0 ]]; then
        RED_HAT=true
    elif [[ "$(grep -c 'Red Hat Enterprise Linux' /etc/os-release)" -gt 0 ]]; then
        RED_HAT=true
    elif [[ "$(grep -c 'Rocky Linux' /etc/os-release)" -gt 0 ]]; then
        RED_HAT=true
    fi
fi

unset MAILCHECK

export EDITOR="$(command -v nvim || command -v vim || command -v vi)"
export GOENV_ROOT="${HOME}/.goenv"
export GPG_TTY=$(tty)
export HISTCONTROL="erasedups:ignoreboth"
export HISTFILESIZE=5000
export HISTSIZE=5000
export HISTTIMEFORMAT="%D %T "
export HISTTIMEFORMAT="%d/%m/%y %T "
export INPUTRC=~/.inputrc
export LD_LIBRARY_PATH=/usr/local/lib:/lib:/usr/lib:/usr/share/lib
export LS_COLORS="di=1;37;40:ln=35;40:so=32;40:pi=33;40:ex=31;40:bd=34;46:cd=34;43:su=0;41:sg=0;46:tw=0;42:ow=0;43:"
export LSCOLORS="Hxfxcxdxbxegedabagacad"
export MANPAGER=$(command -v less || command -v more)
export MANPATH=~/sys/man:/usr/local/man:/opt/local/man:/usr/man:/usr/share/man:/usr/local/share/man
export PAGER="$(command -v less || command -v more)"
export PATH=~/bin:~/.local/bin:/usr/local/bin:/usr/local/sbin:/opt/local/bin:/opt/local/sbin:/usr/games:/bin:/sbin:/usr/bin:/usr/sbin:/usr/proc/bin:/usr/ucb:/snap/bin:/mnt/c/Windows/System32:~/.cargo/bin:${GOENV_ROOT}/bin
export SHELL="$(command -v bash)"
export UNAME="$(uname)"
export VIRTUAL_ENV_DISABLE_PROMPT=1

if [[ $(less -V 2>/dev/null | awk '/less [0-9]/{print $2}') -lt 346 ]]; then
    export LESS="-qiX"
else
    export LESS="-FqiRX"
fi

color16() {
    echo -ne "\[\033[${1}m\]";
}

color256() {
    echo -ne "\[\033[38;5;${1}m\]";
}

hexto256() {
  local hex=$1

  if [[ $hex == "#"* ]]; then
    hex=$(echo "$1" | awk '{print substr($0,2)}')
  fi

  local r=$(printf '0x%0.2s' "$hex")
  local g=$(printf '0x%0.2s' "${hex#??}")
  local b=$(printf '0x%0.2s' "${hex#????}")
  local color=$(printf "%03d" "$(((r<75?0:(r-35)/40)*6*6+(g<75?0:(g-35)/40)*6+(b<75?0:(b-35)/40)+16))")
  echo -ne "$color"
}

BLUE=$(color256 "$(hexto256 '#89b4fa')")
GREEN=$(color256 "$(hexto256 '#a6e3a1')")
GREY=$(color256 "$(hexto256 '#cdd6f4')")
NOCOLOR="$(color16 '0')"
ORANGE=$(color256 "$(hexto256 '#fab387')" )
VIOLET=$(color256 "$(hexto256 '#b4befe')")
YELLOW=$(color256 "$(hexto256 '#f9e2af')")

if command -v git &>/dev/null; then
    if [[ "$UBUNTU" = true ]]; then
        GIT_SH_PROMPT="/usr/lib/git-core/git-sh-prompt"
    elif [[ "$RED_HAT" = true ]]; then
        GIT_SH_PROMPT="/usr/share/git-core/contrib/completion/git-prompt.sh"
    fi

    if [[ -f "$GIT_SH_PROMPT" ]]; then
        source "$GIT_SH_PROMPT"
        export GIT_PROMPT=1
    fi
fi

export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1

build_prompt() {
    PS1="${GREY}\h ${GREEN}\u ${VIOLET}\w"

    local num_jobs=$(jobs 2>/dev/null | grep -cv zoxide)

    if [[ "${num_jobs}" -gt 0 ]]; then
        PS1+=" ${ORANGE}[${num_jobs}]"
    fi

    if [[ -n "${VIRTUAL_ENV}" ]]; then
        PS1+=" ${BLUE}venv"
    fi

    if [[ "${GIT_PROMPT}" -gt 0 ]]; then
        PS1+="${YELLOW}$(__git_ps1 ' %s')"
    fi

    PS1+=" ${GREY}\$${NOCOLOR} "
}

PROMPT_COMMAND=build_prompt

if [[ -r ~/.ssh-agent ]]; then
    source ~/.ssh-agent > /dev/null
fi

alias c="cat"
alias e="\$EDITOR"
alias ep="\$EDITOR -p"
alias f="find"
alias g="egrep -iE"
alias ga="git add"
alias gamend="git commit --amend"
alias gap="git add -p"
alias gcav="git commit -av"
alias gco="git checkout"
alias gcv="git commit -v"
alias gdf="git diff --word-diff"
alias gdn="git pull"
alias gl="git log --color --pretty=format:'%C(yellow)%h%Creset %s %C(bold green)%ar%Creset %C(bold blue)%an%Creset%C(bold red)%d%Creset '"
alias gll="git log --color --stat --decorate --pretty=medium"
alias glll="git log --color --stat --decorate --pretty=medium --patch --minimal"
alias gs="git status"
alias gsa="git stash --all"
alias gup="git push"
alias gv="egrep -iEv"
alias l="ls"
alias la="ls -la"
alias ll="ls -l"
alias m="\$PAGER"
alias pa="source venv/bin/activate"
alias pv="python -m venv venv && source venv/bin/activate && pip install --upgrade pip setuptools wheel pip-tools"
alias ta="tmux attach -t"
alias td="tmux-new-session-pwd"
alias tk="tmux-kill-session"
alias tl="tmux ls"
alias tn="tmux-new-session"

if command -v bat &>/dev/null; then
    alias c='bat --style=plain'
fi

if command -v eza &>/dev/null; then
    if [[ "$RED_HAT" = true ]]; then
        eza_completion="$(rpm -ql eza | grep completions)"
    fi

    if [[ -f "$eza_completion" ]]; then
        source "$eza_completion"
    fi

    alias l="eza"
    alias la="eza -la"
    alias ll="eza -l"
fi

if command -v fd &>/dev/null; then
    alias f="fd"
fi

if command -v fzf &>/dev/null; then
    if [[ "$UBUNTU" = true ]]; then
        fzf_key_bindings="$(dpkg -L fzf | grep key-bindings.bash)"
        fzf_completion="$(dpkg -L fzf | grep completion.bash)"
    elif [[ "$RED_HAT" = true ]]; then
        fzf_key_bindings="$(rpm -ql fzf | grep key-bindings.bash)"
        fzf_completion="$(rpm -ql fzf | grep bash_completion.d)"
    fi

    if [[ -f "$fzf_key_bindings" ]]; then
        source "$fzf_key_bindings"
    fi

    if [[ -f "$fzf_completion" ]]; then
        source "$fzf_completion"
    fi

    if command -v rg &>/dev/null; then
        export FZF_CTRL_T_COMMAND='rg --files --no-ignore-vcs --hidden'
        export FZF_DEFAULT_COMMAND='rg --files --no-ignore-vcs --hidden'
    fi

    if command -v bat &>/dev/null; then
        alias ef="fzf --multi --preview='bat --color=always --style=plain {}' | xargs \$EDITOR -p"
    else
        alias ef="fzf --multi --preview='cat {}' | xargs \$EDITOR -p"
    fi

    alias gaf="git ls-files --modified --others --exclude-standard | fzf --multi --print0 | xargs -0 git add"

    cs() {
        local SELECTED=$(curl -s cht.sh/:list | fzf)
        curl -s "cht.sh/${SELECTED}?style=paraiso-dark" | $PAGER
    }

    tf() {
        local SELECTED=$(compgen -c | fzf)
        tldr "$SELECTED" | $PAGER
    }

fi

if command -v zoxide &>/dev/null; then
    eval "$(zoxide init bash)"

    cd() {
        echo '### Use zoxide instead!'
    }
fi

if command -v goenv &>/dev/null; then
    eval "$(goenv init -)"
    export PATH="${GOROOT}/bin:${PATH}"
    export PATH="${PATH}:${GOPATH}/bin"
fi

export PYENV_ROOT="${HOME}/.pyenv"
export PATH=${PATH}:${PYENV_ROOT}/bin

if command -v pyenv &>/dev/null; then
    eval "$(pyenv init -)"

    if [[ -d "$(pyenv root)/plugins/pyenv-virtualenv" ]]; then
        eval "$(pyenv virtualenv-init -)"
    fi
fi

export NODENV_ROOT=${HOME}/.nodenv
export PATH=${PATH}:${NODENV_ROOT}/bin

if command -v nodenv &>/dev/null; then
    eval "$(nodenv init -)"
fi

if [[ -f "${HOME}/.cargo/env" ]]; then
    source "${HOME}/.cargo/env"
fi

if [[ -f "${HOME}/.bash_local" ]]; then
    source "${HOME}/.bash_local"
fi
