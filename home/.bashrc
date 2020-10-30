#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias grep='grep --color=auto'
alias ls=exa
alias ip='ip -c'
alias vim='nvim'

#PS1='[\u@\h \W]\$ '
source ~/.git-prompt.sh
PS1='\[\033[1m\][\[\033[32m\]\u@\h \[\033[34m\]\W\[\033[35m\]$(__git_ps1 " (%s)")\[\033[39m\]]$\[\033[0m\] '

if [ -f /usr/share/bash-completion/bash_completion ]; then
    source /usr/share/bash-completion/bash_completion
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export PATH=$PATH:$HOME/.local/bin:$HOME/.cargo/bin:/opt/zotero
export EDITOR=/usr/bin/nvim

# Source command-not-found hook
if [ -f /usr/share/doc/pkgfile/command-not-found.bash ]; then
    source /usr/share/doc/pkgfile/command-not-found.bash
fi

# Init starship prompt
eval "$(starship init bash)"
