# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd nomatch
unsetopt beep extendedglob notify
bindkey -e
# End of lines configured by zsh-newuser-install

fpath=(~/.zsh/completions $fpath)
# The following lines were added by compinstall
zstyle :compinstall filename '/home/julian/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Ensure ZLE in application mode for terminfo compatibility
function start-application-mode { echoti smkx }
function stop-application-mode { echoti rmkx }
autoload -Uz add-zle-hook-widget
add-zle-hook-widget -Uz zle-line-init start-application-mode
add-zle-hook-widget -Uz zle-line-finish stop-application-mode

# Custom key bindings
bindkey "$terminfo[khome]" beginning-of-line
bindkey "$terminfo[kend]" end-of-line
bindkey "$terminfo[kdch1]" delete-char

# Set window title
function set_window_title() { echo -ne "\033]0;$(basename $PWD)\007" }
precmd_functions+=(set_window_title)

# Extensions
function source-if-exists { [[ -f $1 ]] && source $1 }
source-if-exists ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source-if-exists ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source-if-exists ~/.zsh/fzf/key-bindings.zsh
source-if-exists ~/.zsh/fzf/completion.zsh
source-if-exists ~/.zsh/zsh-command-not-found/zsh_command_not_found

# Custom aliases
alias bat=batcat
alias ip="ip -c"
alias ls=exa

alias backup="borg create \
  --progress \
  ssh://u430241-sub2@u430241-sub2.your-storagebox.de:23/./backup::$(date +%F) \
  .gnupg/ \
  .password-store/ \
  .ssh/ \
  Bilder/ \
  Dokumente/ \
  Downloads/ \
  Musik/ \
  Sync/ \
  code/ \
  projects/"

alias backup-sina="borg create \
  --progress \
  ssh://u430241-sub2@u430241-sub2.your-storagebox.de:23/./backup-sina::$(date +%F) \
  Bilder/ \
  Dokumente/ \
  Downloads/ \
  Musik/ \
  Videos/"

# Environment variables
export EDITOR=~/.local/bin/nvim
export PATH=~/.local/bin:~/go/bin:$PATH
export PIPENV_SHELL=/usr/bin/zsh
export WORKON_HOME=~/.local/share/virtualenvs

# Custom tool setup
eval "$(direnv hook zsh)"
eval "$(starship init zsh)"

# Work tools setup
# eval "$(docker completion zsh)"
# autoload -U +X bashcompinit && bashcompinit
# complete -o nospace -C /usr/bin/terraform terraform
# source /etc/bash_completion.d/azure-cli
