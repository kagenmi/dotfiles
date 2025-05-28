#!/usr/bin/env bash

session_name=$1


read -p "Kill this session (y/N)? " ans

if [[ $ans =~ ^[Yy]$ ]]; then
  if [[ $(tmux list-sessions | wc -l) > 2 ]]; then
    tmux switch-client -l
  fi
  tmux kill-session -t "$session_name"
  tmux refresh-client -S
fi
