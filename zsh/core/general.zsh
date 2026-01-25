# ENVIRONMENT VARIABLES
# ---------------------

export LANG=en_US.UTF-8

if is-wsl; then
  # LOCAL_IP=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}')
  export DISPLAY=":0"
fi

# Prevent garbled Japanese text in less
export LESSCHARSET=utf-8

# Configure
# ---------

HISTFILE=$HOME/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
setopt appendhistory

GREP_OPTIONS="--color=auto"

# Utils
# -----

json-beauty() {
  echo $1 | python -m json.tool
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

cd-top() {
  cd $(git rev-parse --show-toplevel)
}

fix-zsh-history() {
  cd ~
  mv .zsh_history .zsh_history_corrupt
  strings .zsh_history_corrupt > .zsh_history
  fc -R .zsh_history
  rm -f .zsh_history_corrupt
  cd - > /dev/null 2>&1
}

open-web() {
  local weburl="$1"

  if is-wsl; then
    if command -v wslview &>/dev/null; then
      wslview "$weburl"
    else
      echo "Command 'wslview' is required."
      echo "Run: sudo apt install wslu"
      return 1
    fi
  elif command -v xdg-open &>/dev/null; then
    xdg-open "$weburl"
  elif command -v open &>/dev/null; then  # for macOS
    open "$weburl"
  else
    echo "❌ No supported method to open URL found."
    return 1
  fi
}

git-open() {
  local url weburl

  url=$(git remote get-url origin 2>/dev/null)
  if [[ -z "$url" ]]; then
    echo "❌ No remote 'origin' found."
    return 1
  fi

  if [[ "$url" =~ '^git@([^:]+):(.+)\.git$' ]]; then
    weburl="https://${match[1]}/${match[2]}"
  elif [[ "$url" =~ '^https://([^/]+)/(.+)\.git$' ]]; then
    weburl="https://${match[1]}/${match[2]}"
  else
    echo "❌ Unsupported remote URL format: $url"
    return 1
  fi

  echo "Open ${weburl}"
  open-web "$weburl"
}

# Aliases
# -------

alias ccat='highlight -O ansi --force'
alias vim='nvim'
alias editalacritty="vim ~/.config/alacritty/alacritty.yml"
alias edittmux="vim $HOME/.config/tmux/tmux.conf"
alias editrc="vim $ZSH_CONF_HOME/zshrc.zsh"
alias nvim-clear="command rm -rf $HOME/.local/share/nvim/swap && command rm -rf $HOME/.local/state/nvim/swap"
alias nvim-reset="command rm -rf $HOME/.local/share/nvim && command rm -rf $HOME/.local/state/nvim"
alias tf="terraform"

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

