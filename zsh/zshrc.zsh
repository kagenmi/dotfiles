# zmodload zsh/zprof &&  zprof

# PATH Settings
# -------------

export PATH=/usr/local/bin:$PATH
export PATH=$HOME/bin:$PATH
export PATH=$HOME/.linuxbrew/bin:$PATH
export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/.yarn/bin:$PATH

# zinit
# -----

source "$ZSH_CONFIG_HOME/plugins/init.zsh"

# PowerLevel10K
# -------------

source "$ZSH_CONFIG_HOME/powerlevel10k/init.zsh"

# Custom Configuration
# --------------------

source "$ZSH_CONFIG_HOME/utils.zsh"

source "$ZSH_CONFIG_HOME/core/general.zsh"
source "$ZSH_CONFIG_HOME/core/color.zsh"
source "$ZSH_CONFIG_HOME/core/tmux.zsh"

if [[ -f $ZSH_CONFIG_HOME/custom/init.zsh ]]; then
  source $ZSH_CONFIG_HOME/custom/init.zsh
fi

if [[ -f $ZSH_CONFIG_HOME/shortcuts.zsh ]]; then
  source $ZSH_CONFIG_HOME/shortcuts.zsh
fi

# if (which zprof > /dev/null 2>&1) ;then
#   zprof
# fi
