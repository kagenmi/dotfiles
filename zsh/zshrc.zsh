# Home Manager Integration
# ------------------------
# Load session variables from Home Manager (if managed by Nix)
# This provides environment variables like STARSHIP_CONFIG, EDITOR, etc.
if [ -f "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh" ]; then
  source "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
fi

# Environment Variables
# ---------------------
# Note: These are also defined in nix/home.nix, but we set them here
# to ensure they are available before plugin managers run
export ZSH_CONFIG_HOME="${ZSH_CONFIG_HOME:-$HOME/.config/zsh}"
export SHELDON_CONFIG_DIR="$ZSH_CONFIG_HOME/sheldon"
export SHELDON_DATA_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/sheldon"

# PATH Settings
# -------------
# Ensure PATH entries are unique (prevent duplicates on shell reload)
typeset -U PATH path

export PATH=/usr/local/bin:$PATH
export PATH=$HOME/.local/bin:$PATH

# Powerlevel10k -- Shell Prompt (Instant Prompt)
# -------
# Enable Powerlevel10k instant prompt. Should stay close to the top of the file.
# CRITICAL: This MUST be loaded BEFORE sheldon/plugins to enable instant prompt.
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

# zinit (disabled - migrated to sheldon)
# -----
# _start=$SECONDS
# source "$ZSH_CONFIG_HOME/plugins/init.zsh"
# printf "[PROFILE] zinit: %.3fms\n" $((($SECONDS - $_start) * 1000))

# sheldon -- Shell Plugin Manager
# -------
if command -v sheldon >/dev/null 2>&1; then
  # Initialize zsh completion system before loading plugins
  # Only run compinit once per day for performance
  autoload -Uz compinit
  if [[ -n ${HOME}/.zcompdump(#qN.mh+24) ]]; then
    compinit
  else
    compinit -C
  fi

  eval "$(sheldon source)"
  # Load custom post-processing
  source "$ZSH_CONFIG_HOME/sheldon/post-load.zsh"
fi

# Starship -- Shell Prompt
# --------
if command -v starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
fi

# mise -- Development Environment Manager
# ----
if command -v mise >/dev/null 2>&1; then
  eval "$(mise activate zsh)"
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
