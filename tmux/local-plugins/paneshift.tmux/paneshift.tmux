#!/usr/bin/env bash

# paneshift.tmux - tmux pane movement plugin
# Inspired by winshift.nvim (https://github.com/sindrets/winshift.nvim)
#
# This plugin provides intuitive pane movement functionality for tmux,
# allowing users to move panes in different directions within the layout.

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
ENTRYPOINT="$CURRENT_DIR/core/main.py"

KEY_TABLE="paneshift-pane-move-mode"

get_tmux_option() {
    local option="$1"
    local default_value="$2"
    local option_value="$(tmux show-option -gqv "$option")"
    if [ -n "$option_value" ]; then
        echo "$option_value"
    else
        echo "$default_value"
    fi
}

active_pane_style=$(get_tmux_option "@paneshift_active_pane_style" "bg=#d6aaff")

active_pane=$(tmux display -p '#{pane_id}')
active_pane="${active_pane#%}" # remove '%'

tmux bind-key "M-i" run-shell "$CURRENT_DIR/core/show_layout.py"

tmux bind-key m run-shell "\
  $CURRENT_DIR/enter-mode.sh $KEY_TABLE $active_pane_style"

tmux bind-key -T $KEY_TABLE h run-shell "\
  $ENTRYPOINT left --target-pane $active_pane --key-table $KEY_TABLE"
tmux bind-key -T $KEY_TABLE j run-shell "\
  $ENTRYPOINT down --target-pane $active_pane --key-table $KEY_TABLE"
tmux bind-key -T $KEY_TABLE k run-shell "\
  $ENTRYPOINT up --target-pane $active_pane --key-table $KEY_TABLE"
tmux bind-key -T $KEY_TABLE l run-shell "\
  $ENTRYPOINT right --target-pane $active_pane --key-table $KEY_TABLE"

for exit_key in "q" "Escape" "C-c"; do
  tmux bind-key -T $KEY_TABLE "$exit_key" run-shell "$CURRENT_DIR/leave-mode.sh"
done
