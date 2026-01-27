export TMUX_CONFIG_HOME=$HOME/.config/tmux

tmux-reload() {
  tmux source-file $TMUX_CONFIG_HOME/tmux.conf # &> /dev/null
}

# For some reason,
# TERM is 'screen' in the first window of the first session.
if [[ $TERM = 'screen' ]]; then
  export TERM=screen-256color
fi

if [[ -n $TMUX ]]; then
  # tmux-reload
fi
