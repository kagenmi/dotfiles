#!/usr/bin/env bash

current_window_move_mode=$(tmux show-option -gqv @window_move_mode)

dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
core_script="$dir/core.sh"

if [[ $current_window_move_mode == "on" ]]; then
  $core_script exit
else
  tmux set -g @window_move_mode "on"

  status_backup="$(tmux show-option -gqv status-right)"
  tmux set -g @status_right_backup "$status_backup"
  tmux set -g status-right "your message"

  tmux bind-key -n '<' run-shell "$core_script left"
  tmux bind-key -n '>' run-shell "$core_script right"
  tmux bind-key -n 'q' run-shell "$core_script exit"
  tmux bind-key -n 'Escape' run-shell "$core_script exit"
fi
