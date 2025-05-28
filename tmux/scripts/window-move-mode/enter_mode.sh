#!/usr/bin/env bash

tmux set -g @window_move_mode "on"

dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
core_script="$dir/core.sh"

tmux bind-key -n '<' run-shell "$core_script left"
tmux bind-key -n '>' run-shell "$core_script right"
tmux bind-key -n 'q' run-shell "$core_script exit"
tmux bind-key -n 'Escape' run-shell "$core_script exit"
