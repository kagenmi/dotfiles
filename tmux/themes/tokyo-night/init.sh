#!/usr/bin/env bash

# License:    MIT
# References:
#   https://github.com/arcticicestudio/nord-tmux

CONF_DIR="$HOME/.config"
SRC_DIR=tmux/themes/tokyo-night/src

COLOR_THEME_FILE="$SRC_DIR/theme.conf"
STATUS_LINE_FILE="$SRC_DIR/status-line.conf"

__cleanup() {
  unset -v COLOR_THEME_FILE
  unset -v STATUS_LINE_FILE
  unset -v CONF_DIR
  unset -f __load __cleanup
  tmux set-environment -gu TMUX_STATUS_TIME_FORMAT
  tmux set-environment -gu TMUX_STATUS_DATE_FORMAT
}

__load() {
  tmux set-environment -g TMUX_STATUS_TIME_FORMAT "%H:%M"
  tmux set-environment -g TMUX_STATUS_DATE_FORMAT "%Y/%m/%d %a"

  tmux source-file "$CONF_DIR/$COLOR_THEME_FILE"
  tmux source-file "$CONF_DIR/$STATUS_LINE_FILE"
}

__load
__cleanup
