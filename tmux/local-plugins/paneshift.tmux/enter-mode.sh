#!/usr/bin/env bash

key_table=$1
pane_style=${2:-""}

client_pid=$(tmux display -p '#{client_pid}')
pane_id=$(tmux display -p '#{pane_id}')

tmux set -gq "@paneshift_${client_pid}_active_pane_id" "$pane_id"
tmux select-pane -P $pane_style
tmux switch-client -T $key_table
