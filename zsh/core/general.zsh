# ENVIRONMENT VARIABLES
# ---------------------

export LANG=en_US.UTF-8

if is-wsl; then
  # LOCAL_IP=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}')
  export DISPLAY=":0"
fi

# Configure
# ---------

HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

# Utils
# -----

json-beauty() {
  echo $1 | python -m json.tool
}

# findwd():
#   Find specific keyword on current directory recurively.
# arguments:
#   $1: (required) keyword
#   $2: (optional) extension of file
# example:
#   `findwd hoge js`
findwd(){
  if [ -z "$2" ]; then
    grep -Irn "$1" --color='auto' .
  else
    grep -Irn "$1" --include="*.$2" --color='auto' .
  fi
}

show-colors() {
  for i in {0..255}; do
    print -Pn "%K{$i}  %k%F{$i}${(l:3::0:)i}%f " ${${(M)$((i%6)):#3}:+$'\n'};
  done
}

check-truecolor() {
  curl -s https://gist.githubusercontent.com/lifepillar/09a44b8cf0f9397465614e622979107f/raw/24-bit-color.sh | bash
}

pip-uninstall-all() {
  pip freeze | xargs pip uninstall -y
}


# Aliases
# -------

alias ccat='highlight -O ansi --force'
alias vim='nvim'
alias editalacritty="vim ~/.config/alacritty/alacritty.yml"
alias edittmux="vim $HOME/.config/tmux/tmux.conf"
alias editrc="vim $ZSH_CONF_HOME/zshrc.zsh"
alias clear-nvim-cache="command rm -rf $HOME/.local/share/nvim/swap && command rm -rf $HOME/.local/state/nvim/swap"

if type trash-put &> /dev/null; then
  alias rm=trash-put
else
  echo "WARNING: trash-cli isn't installed."
fi

if is-wsl; then
  alias open='explorer.exe'
  alias pbcopy='clip.exe'
  alias pbpaste='powershell.exe -command "Get-Clipboard"'
fi

# Plugins
# -------

# z
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi
