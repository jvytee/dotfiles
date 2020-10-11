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
export BEMENU_BACKEND=wayland
export MOZ_ENABLE_WAYLAND=1
export MOZ_USE_XINPUT2=1
export _JAVA_AWT_WM_NONREPARENTING=1
export QT_QPA_PLATFORM=wayland-egl
export QT_STYLE_OVERRIDE=breeze

# If running from tty1 start sway
#if [ "$(tty)" = "/dev/tty1" ]; then
#    exec sway
#fi

# Source command-not-found hook
if [ -f /usr/share/doc/pkgfile/command-not-found.bash ]; then
    source /usr/share/doc/pkgfile/command-not-found.bash
fi

# Init starship prompt
eval "$(starship init bash)"
