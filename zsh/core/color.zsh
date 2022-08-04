# Dependencies
#   - vivid
#   - coreutils (only MacOS)

if is-mac; then
  alias dircolors='gdircolors'
  alias ls='gls'
fi

export LS_COLORS="$(vivid generate tokyo-night)"

alias ls='ls --color=auto'
alias diff='diff --color=auto'
alias grep='grep --color=auto'
