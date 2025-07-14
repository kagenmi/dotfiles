#!/usr/bin/env bash

client_pid=$(tmux display -p '#{client_pid}')
pane_id=$(tmux display -p '#{pane_id}')

tmux set -guq "@paneshift_${client_pid}_active_pane_id"
tmux select-pane -P ""
tmux switch-client -T root
