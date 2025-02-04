if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

if [[ -f $ZSH_CONFIG_HOME/powerlevel10k/p10k.zsh ]]; then
  source $ZSH_CONFIG_HOME/powerlevel10k/p10k.zsh
fi
