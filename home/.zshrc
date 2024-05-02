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

function start-application-mode { echoti smkx }
function stop-application-mode { echoti rmkx }
autoload -Uz add-zle-hook-widget
add-zle-hook-widget -Uz zle-line-init start-application-mode
add-zle-hook-widget -Uz zle-line-finish stop-application-mode

bindkey "$terminfo[kdch1]" delete-char
bindkey "$terminfo[khome]" beginning-of-line
bindkey "$terminfo[kend]" end-of-line

export PATH=~/.local/bin:$PATH

source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/fzf/completion.zsh
source ~/.zsh/fzf/key-bindings.zsh

eval "$(starship init zsh)"

alias bat=batcat
alias ls=exa
alias ip="ip -c"

alias backup='borg create --progress --compression lz4 /run/media/julian/57f1c76f-de35-4d2c-9d0e-0581d3245c20/backup::$(date +%F) Bilder/ Dokumente/ Musik/ code/ Sync/ .gnupg/ .ssh/ .password-store/ Downloads/musik Downloads/dokumente Downloads/bilder'
