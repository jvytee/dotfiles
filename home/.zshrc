# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd
unsetopt beep
bindkey -e
# End of lines configured by zsh-newuser-install

# The following lines were added by compinstall
zstyle :compinstall filename '/home/julian/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

source $(fzf-share)/completion.zsh
source $(fzf-share)/key-bindings.zsh

alias backup='borg create --progress --compression lz4 /run/media/julian/57f1c76f-de35-4d2c-9d0e-0581d3245c20/backup::$(date +%F) Bilder/ Dokumente/ Musik/ code/ Sync/ .gnupg/ .ssh/ .password-store/ Downloads/musik Downloads/dokumente Downloads/bilder'
