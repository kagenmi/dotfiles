# Dependencies
#   - vivid
#   - coreutils (only MacOS)

if is-mac; then
  alias dircolors='gdircolors'
fi

export LS_COLORS="$(vivid generate tokyo-night)"

if is-mac; then
  alias ls='gls --color=auto'
else
  alias ls='ls --color=auto'
fi

alias diff='diff --color=auto'
alias grep='grep --color=auto'
