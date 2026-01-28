# Custom post-load processing for sheldon plugins
# This file contains hooks that were previously in zinit's atload

# Unalias grv from omz-git plugin
unalias grv 2>/dev/null || true

# Load Powerlevel10k configuration
if [[ -f $ZSH_CONFIG_HOME/powerlevel10k/p10k.zsh ]]; then
  source $ZSH_CONFIG_HOME/powerlevel10k/p10k.zsh
fi
