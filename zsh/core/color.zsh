# Dependencies
#   - vivid
#   - coreutils (only MacOS)

if is-mac; then
  alias dircolors='gdircolors'
fi

local theme='yurufuwa'
if [[ -f "$ZSH_CONFIG_HOME/core/dircolors/$theme" ]]; then
  eval $(dircolors "$ZSH_CONFIG_HOME/core/dircolors/$theme")
fi

if is-mac; then
  alias ls='gls --color=auto'
else
  alias ls='ls --color=auto'
fi

alias diff='diff --color=auto'
alias grep='grep --color=auto'
