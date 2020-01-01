#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias grep='grep --color=auto'
alias ls='ls --color=auto'
alias ip='ip -c'

#PS1='[\u@\h \W]\$ '
source ~/.git-prompt.sh
PS1='\[\033[0;32m\]\u \[\033[0;36m\] \h \[\033[0;34m\] \w \[\033[0;35m\]$(__git_ps1 " %s ")\[\033[00m\] '
PS2=' '

if [ -f /usr/share/bash-completion/bash_completion ]; then
    source /usr/share/bash-completion/bash_completion
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export PYENV_ROOT=$HOME/.pyenv
export PATH=$PYENV_ROOT/bin:$PATH:$HOME/.local/bin:$HOME/.cargo/bin
export EDITOR=/usr/bin/nvim

# If running from tty1 start sway
if [ "$(tty)" = "/dev/tty1" ]; then
	exec sway
fi

# Set up PyEnv
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
