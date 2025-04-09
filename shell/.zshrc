TERM=xterm-256color

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

DOTFILES=$HOME/.dotfiles

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(git zsh-autosuggestions zsh-syntax-highlighting web-search)

source $ZSH/oh-my-zsh.sh

## User configuration ##

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f $DOTFILES/shell/.p10k.zsh ]] || source $DOTFILES/shell/.p10k.zsh

# Add custom functions to shell
source $DOTFILES/shell/functions.zsh

# Add individual extentions to shell
for extention in $DOTFILES/shell/extentions/*.zsh(N.); do
  source "$extention"
done

# Include hidden files
_comp_options+=(globdots)
zstyle ':completion:*' special-dirs false

# To customize prompt, run `p10k configure` or edit ~/.dotfiles/shell/.p10k.zsh.
[[ ! -f ~/.dotfiles/shell/.p10k.zsh ]] || source ~/.dotfiles/shell/.p10k.zsh

# Source NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Source Rust env
[ -s "$HOME/.cargo/env" ] && \. "$HOME/.cargo/env"
