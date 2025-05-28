#!/usr/bin/env bash

DEST=$1
SRC=$(tmux display-message -p '#I')

# Validate input
if [[ -z "$DEST" || ! "$DEST" =~ ^[0-9]+$ ]]; then
  tmux display-message "Invalid destination: $DEST"
  exit 1
fi

# Do nothing if source and destination are the same
if [ "$SRC" -eq "$DEST" ]; then
  exit 0
fi

# Get total number of windows
COUNT=$(tmux list-windows | wc -l)

# Clamp destination to the last valid index
if [ "$DEST" -ge "$COUNT" ]; then
  DEST=$((COUNT - 1))
fi

# If moving forward in the list, adjust destination index
ADJUSTED_DEST=$DEST
if [ "$DEST" -gt "$SRC" ]; then
  ADJUSTED_DEST=$((DEST - 1))
fi

# Debug: show current state
DEBUG_BEFORE=$(tmux list-windows -F "#{window_index}:#{window_name}")
tmux display-message "Before move: $DEBUG_BEFORE"
tmux display-message "Moving window $SRC → $ADJUSTED_DEST (original: $DEST)"

# Try to move and capture all output
ERROR_MSG=$(tmux move-window -s "$SRC" -t ":$ADJUSTED_DEST" 2>&1)

# Check whether move succeeded by re-listing windows
DEBUG_AFTER=$(tmux list-windows -F "#{window_index}:#{window_name}")
tmux display-message "After move: $DEBUG_AFTER"

# If move-window failed, display its output
if ! tmux list-windows | grep -q "^$ADJUSTED_DEST:"; then
  tmux display-message "move-window may have failed: $ERROR_MSG"
fi

# Re-number the windows
tmux move-window -r
