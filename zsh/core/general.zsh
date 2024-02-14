# ENVIRONMENT VARIABLES
# ---------------------

export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

if is-wsl; then
  # # cmd.exe /c $win/Documents/find-ip.bat
  # export DISPLAY=$WSL_IF_IP:0
  # unset LIBGL_ALWAYS_INDIRECT
  LOCAL_IP=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}')
  # LOCAL_IP=$(ipconfig.exe | awk 'BEGIN {RS="\r\n"} /^[A-Z]/ {isWslSection=/WSL/;}; {if (!isWslSelection && /IPv4 Address/) {printf $NF; exit;}}')
  export DISPLAY=$LOCAL_IP:0
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
    grep -rn "$1" --color='auto' .
  else
    grep -rn "$1" --include="*.$2" --color='auto' .
  fi
}

show-colors() {
  for i in {0..255}; do
    print -Pn "%K{$i}  %k%F{$i}${(l:3::0:)i}%f " ${${(M)$((i%6)):#3}:+$'\n'};
  done
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
