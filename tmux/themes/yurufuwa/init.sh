#!/usr/bin/env bash

# License:    MIT
# References:
#   - https://github.com/arcticicestudio/nord-tmux
#   - https://github.com/catppuccin/tmux

WORKDIR="$(dirname $0)"

source "$WORKDIR/helper.sh"
source "$WORKDIR/component.sh"

main() {
  source "$WORKDIR/colorscheme.sh"

  # pane
  setw pane-border-status "off"
  setw pane-border-style "fg=${thm_gray}"
  setw pane-active-border-style "fg=${thm_cyan}"

  # status
  set status "on"
  set status-bg "$thm_bg"
  set status-justify "left"
  set status-left-length "100"
  set status-right-length "100"

  # messages
  set message-style "fg=${thm_cyan},bg=${thm_gray},align=centre"
  set message-command-style "fg=${thm_cyan},bg=${thm_gray},align=centre"

  # modes
  setw clock-mode-colour "${thm_blue}"
  setw mode-style "fg=${thm_pink} bg=${thm_black4} bold"

  # status-bar layout
  # L: [status-left][window-status-format | window-status-current-format]xn
  # R: [status-right]

  local window=$(cmp_window "#I" "#W" false)
  local window_active=$(cmp_window "#I" "#W"  true)
  setw window-status-format "$window"
  setw window-status-current-format "$window_active"

  local session=$(cmp_status_left "#S")
  set status-left "$session"

  local clock=$(cmp_module_clock false $thm_orange)
  local host=$(cmp_module_host true $thm_magenta $thm_orange)
  set status-right "$clock$host"
}

main
