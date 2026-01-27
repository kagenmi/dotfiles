# Environment Variables
# ---------------------
# Note: These are also defined in nix/home.nix, but we set them here
# to ensure they are available before plugin managers run
export ZSH_CONFIG_HOME="${ZSH_CONFIG_HOME:-$HOME/.config/zsh}"
export SHELDON_CONFIG_DIR="$ZSH_CONFIG_HOME/sheldon"
export SHELDON_DATA_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/sheldon"

# PATH Settings
# -------------

export PATH=/usr/local/bin:$PATH
export PATH=$HOME/.local/bin:$PATH

# zinit (disabled - migrated to sheldon)
# -----
# _start=$SECONDS
# source "$ZSH_CONFIG_HOME/plugins/init.zsh"
# printf "[PROFILE] zinit: %.3fms\n" $((($SECONDS - $_start) * 1000))

# sheldon -- Shell Plugin Manager
# -------
if command -v sheldon >/dev/null 2>&1; then
  eval "$(sheldon source)"
  # Load custom post-processing
  source "$ZSH_CONFIG_HOME/sheldon/post-load.zsh"
fi

# Starship -- Shell Prompt
# --------
if command -v starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
fi

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
