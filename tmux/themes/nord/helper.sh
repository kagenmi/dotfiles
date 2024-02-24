# tmux set-option
set() {
  local option=$1
  local value=$2

  tmux set-option -gq "$option" "$value" ";"
}

# tmux set-window-option
setw() {
  local option=$1
  local value=$2

  tmux set-window-option -gq "$option" "$value" ";"
}
