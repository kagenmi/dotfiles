#!/usr/bin/env bash

# Get the current window index
get_current_index() {
  tmux display-message -p '#I'
}

# Get the number of windows in the current session
get_window_count() {
  tmux display-message -p '#{session_windows}'
}

# Move the current window to the left (if not at index 0)
move_left() {
  local current=$(get_current_index)
  if [ "$current" -le 0 ]; then
    return
  fi
  local target=$((current - 1))
  tmux swap-window -t "$target"
  tmux select-window -t "$target"
}

# Move the current window to the right (if not at the last index)
move_right() {
  local current=$(get_current_index)
  local max=$(( $(get_window_count) - 1 ))
  if [ "$current" -ge "$max" ]; then
    return
  fi
  local target=$((current + 1))
  tmux swap-window -t "$target"
  tmux select-window -t "$target"
}

# Exit the mode: unbind keys and renumber windows
exit_mode() {
  tmux unbind-key -n '<'
  tmux unbind-key -n '>'
  tmux unbind-key -n 'q'
  tmux unbind-key -n 'Escape'
  tmux move-window -r

  tmux set -g @window_move_mode "off"
}

# Entry point
main() {
  case "$1" in
    left)
      move_left
      ;;
    right)
      move_right
      ;;
    exit)
      exit_mode
      ;;
    *)
      echo "Usage: $0 {left|right|exit}" >&2
      exit 1
      ;;
  esac
}

main "$@"
