#!/usr/bin/env bash

# shellcheck disable=SC1090,SC1091,SC2312

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

EDITOR=$(command -v nvim || command -v vim || command -v vi)
GPG_TTY=$(tty)
MANPAGER=$(command -v less || command -v more)
PAGER=$(command -v less || command -v more)

export EDITOR
export GPG_TTY
export HISTCONTROL="erasedups:ignoreboth"
export HISTFILESIZE=10000
export HISTSIZE=10000
export HISTTIMEFORMAT="%d/%m/%y %T "
export INPUTRC=~/.inputrc
export LD_LIBRARY_PATH=/usr/local/lib:/lib:/usr/lib:/usr/share/lib
export MANPAGER
export MANPATH
export PAGER
export PATH=~/bin:~/.local/bin:/usr/local/bin:/usr/local/sbin:/opt/local/bin:/opt/local/sbin:/usr/games:/bin:/sbin:/usr/bin:/usr/sbin:/usr/proc/bin:/usr/ucb:/snap/bin

if [[ $(less -V 2>/dev/null | awk '/less [0-9]/{print $2}') -lt 346 ]]; then
    export LESS="-qiX"
else
    export LESS="-FqiRX"
fi

if command -v git &>/dev/null; then
    if [[ -f "/usr/lib/git-core/git-sh-prompt" ]]; then
        source "/usr/lib/git-core/git-sh-prompt"
        export GIT_PROMPT=1
    elif [[ -f "/usr/share/git-core/contrib/completion/git-prompt.sh" ]]; then
        source "/usr/share/git-core/contrib/completion/git-prompt.sh"
        export GIT_PROMPT=1
    fi
fi

export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1

select_ansi_graphic_rendition() {
    echo -ne "\[\033[${1}m\]"
}

select_font_effect_reset() {
    echo -ne "$(select_ansi_graphic_rendition 0)"
}

select_4bit_color() { # 16 colors
  echo -ne "$(select_ansi_graphic_rendition "${1}")"
}

select_8bit_foreground_color() { # 256 colors
  echo -ne "$(select_ansi_graphic_rendition "38;5;${1}")"
}

select_rgb_foreground_color() { # true colors
  echo -ne "$(select_ansi_graphic_rendition "38;2;${1};${2};${3}")" # 1=R, 2=B, 3=G
}

BLUE=$(select_8bit_foreground_color 111) # 89b4fa
GREEN=$(select_8bit_foreground_color 151) # a6e3a1
GREY=$(select_8bit_foreground_color 103) # 7f849c
RED=$(select_8bit_foreground_color 211) # f38ba8
RESET=$(select_font_effect_reset 0)
VIOLET=$(select_8bit_foreground_color 147) # b4befe
YELLOW=$(select_8bit_foreground_color 223) # f9e2af

build_prompt() {
    PS1="${GREY}\h ${GREEN}\u ${VIOLET}\w"

    local num_jobs
    num_jobs=$(jobs 2>/dev/null | wc -l)

    if [[ "${num_jobs}" -gt 0 ]]; then
        PS1+=" ${RED}[${num_jobs}]"
    fi

    if [[ -n "${VIRTUAL_ENV}" ]]; then
        PS1+=" ${BLUE}venv"
    fi

    if [[ "${GIT_PROMPT}" -gt 0 ]]; then
        PS1+="${YELLOW}$(__git_ps1 ' %s')"
    fi

    PS1+="\n${GREY}\$${RESET} "
}

PROMPT_COMMAND=build_prompt

if [[ -r ~/.ssh-agent ]]; then
    source ~/.ssh-agent > /dev/null
fi

alias grep="grep -E"
alias ta="tmux attach"
alias td="tmux-new-session-pwd"
alias tk="tmux-kill-session"
alias tl="tmux ls"
alias tn="tmux-new-session"

if command -v fzf &>/dev/null; then
    if command -v rpm &> /dev/null; then
        fzf_key_bindings="$(rpm -ql fzf | grep key-bindings.bash)"
        fzf_completion="$(rpm -ql fzf | grep bash_completion.d)"
    elif command -v dpkg &> /dev/null; then
        fzf_key_bindings="$(dpkg -L fzf | grep key-bindings.bash)"
        fzf_completion="$(dpkg -L fzf | grep completion.bash)"
    fi

    if [[ -f "${fzf_key_bindings}" ]]; then
        source "${fzf_key_bindings}"
    fi

    if [[ -f "${fzf_completion}" ]]; then
        source "${fzf_completion}"
    fi

    if command -v rg &>/dev/null; then
        export FZF_CTRL_T_COMMAND='rg --files --no-ignore-vcs --hidden'
        export FZF_DEFAULT_COMMAND='rg --files --no-ignore-vcs --hidden'
    fi
fi

export NODENV_ROOT=${HOME}/.nodenv
export PATH=${PATH}:${NODENV_ROOT}/bin

if command -v nodenv &>/dev/null; then
    eval "$(nodenv init -)"
fi

if command -v uv &>/dev/null; then
    eval "$(uv generate-shell-completion bash)"
fi

export PYENV_ROOT="${HOME}/.pyenv"
[[ -d "${PYENV_ROOT}/bin" ]] && export PATH="${PATH}:${PYENV_ROOT}/bin"

if command -v pyenv &>/dev/null; then
    eval "$(pyenv init - bash)"

    if [[ -d "$(pyenv root)/plugins/pyenv-virtualenv" ]]; then
        eval "$(pyenv virtualenv-init -)"
    fi
fi

export GOENV_ROOT="${HOME}/.goenv"
export PATH="${GOENV_ROOT}/bin:${PATH}"

if command -v goenv &>/dev/null; then
    eval "$(goenv init -)"
    export PATH="${GOROOT}/bin:${PATH}"
    export PATH="${PATH}:${GOPATH}/bin"
fi

if [[ -f "${HOME}/.bash_local" ]]; then
    source "${HOME}/.bash_local"
fi
