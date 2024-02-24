cmp_window() {
  local number=$1
  local text=$2
  local active=$3 # true | false
  
  if [[ $active == true ]]; then
    local color=$thm_red
  else
    local color=$thm_blue
  fi
  local bg_color=$thm_gray
  local win_left_separator="█"
  local win_middle_separator="█ "
  local win_right_separator="█ "

  local fmt_number="#[fg=$bg_color,bg=$color]$number"
  local fmt_middle_separator="#[fg=$color,bg=$bg_color,nobold,nounderscore,noitalics]$win_middle_separator"
  local fmt_text="#[fg=$thm_fg,bg=$bg_color]$text"
  local fmt_right_separator="#[fg=$bg_color,bg=$thm_bg,nobold,nounderscore,noitalics]$win_right_separator"
  local fmt_left_separator="#[fg=$color,bg=$thm_bg]$win_left_separator"
  
  echo "$fmt_left_separator$fmt_number$fmt_middle_separator$fmt_text$fmt_right_separator"
}

cmp_status_left() {
  local text=$1
  
  local color=$thm_cyan
  local icon=""
  local left_separator="█"
  local middle_separator="█"
  local right_separator="█ "

  local fmt_icon="#[fg=$thm_black,bg=$color]$icon"
  local fmt_text="#[fg=$thm_black,bg=$color]$text"
  local fmt_left_separator="#[fg=$color,bg=$thm_bg]$left_separator"
  local fmt_middle_separator="#[fg=$color,bg=$thm_bg]$middle_separator"
  local fmt_right_separator="#[fg=$color,bg=$thm_bg]$right_separator"

  echo "$fmt_left_separator$fmt_icon$fmt_middle_separator$fmt_text$fmt_right_separator"
}

cmp_module() {
  icon=$1
  text=$2
  color=$3
  is_last=$4 # true | false

  local left_separator=""
  local middle_separator="█"
  if [[ $is_last == true ]]; then
    local right_separator="█"
  else
    local right_separator=" "
  fi

  local fmt_icon="#[fg=$thm_black,bg=$color]$icon"
  local fmt_text="#[fg=$thm_black,bg=$color]$text"
  local fmt_left_separator="#[fg=$color,bg=$thm_bg]$left_separator"
  local fmt_middle_separator="#[fg=$color,bg=$thm_bg]$middle_separator"
  if [[ $is_last == true ]]; then
    local fmt_right_separator="#[fg=$color,bg=$thm_bg]$right_separator"
  else
    local fmt_right_separator="#[fg=$thm_bg,bg=$color]$right_separator"
  fi  

  echo "$fmt_left_separator$fmt_icon$fmt_middle_separator$fmt_text$fmt_right_separator"
}

cmp_module_clock() {
  local is_last=$1

  echo $(cmp_module "󰃰" "%Y-%m-%d %H:%M" "$thm_blue" $is_local)
}

cmp_module_host() {
  local is_last=$1

  echo $(cmp_module "󰒋" "#H" "$thm_magenta" $is_last)
}
