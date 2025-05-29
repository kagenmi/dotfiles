cmp_window() {
  local number=$1
  local text=$2
  local active=$3 # true | false

  if [[ $active == true ]]; then
    local number_bg=$thm_green
  else
    local number_bg=$thm_light_gray
  fi
  local number_fg=$thm_fg
  local text_bg=$thm_cyan
  local text_fg=$thm_fg
  local win_left_separator="█"
  local win_middle_separator="█ "
  if [[ $active == true ]]; then
    local win_right_separator="██"
  else
    local win_right_separator="██"
  fi

  local fmt_left_separator="#[fg=$number_bg,bg=$thm_bg]$win_left_separator"
  local fmt_number="#[fg=$number_fg,bg=$number_bg,bold]$number"
  local fmt_middle_separator="#[fg=$number_bg,bg=$text_bg,nobold,nounderscore,noitalics]$win_middle_separator"
  local fmt_text="#[fg=$text_fg,bg=$text_bg]$text"
  local fmt_right_separator="#[fg=$text_bg,bg=$thm_bg,nobold,nounderscore,noitalics]$win_right_separator"

  echo "$fmt_left_separator$fmt_number$fmt_middle_separator$fmt_text$fmt_right_separator"
}

cmp_status_left() {
  local text=$1

  local color=$thm_cyan
  local icon=" "
  local left_separator="█"
  local middle_separator="█"
  local right_separator="█ "

  local fmt_icon="#[fg=$thm_black,bg=$color]$icon"
  local fmt_text="#[fg=$thm_black,bg=$color,bold]$text"
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
  left_color_bg=$5

  if [[ $left_color_bg == "" ]]; then
    local left_color_bg=$thm_bg
  else
    local left_color_bg=$left_color_bg
  fi

  local left_separator="█"
  local middle_separator="█"
  if [[ $is_last == true ]]; then
    local right_separator="█"
  else
    local right_separator="█"
  fi

  local fmt_icon="#[fg=$thm_fg,bg=$color]$icon"
  local fmt_text="#[fg=$thm_fg,bg=$color]$text"
  local fmt_left_separator="#[fg=$color,bg=$left_color_bg]$left_separator"
  local fmt_middle_separator="#[fg=$color,bg=$thm_bg]$middle_separator"
  if [[ $is_last == true ]]; then
    local fmt_right_separator="#[fg=$color,bg=$thm_bg]$right_separator"
  else
    local fmt_right_separator="#[fg=$color] $right_separator"
  fi

  echo "$fmt_left_separator$fmt_icon$fmt_middle_separator$fmt_text$fmt_right_separator"
}

cmp_module_clock() {
  local is_last=$1
  local color_bg=$2
  local left_color_bg=$3

  echo $(cmp_module "󰃰 " "%Y-%m-%d %H:%M" "$color_bg" $is_last "$left_color_bg")
}

cmp_module_host() {
  local is_last=$1
  local color_bg=$2
  local left_color_bg=$3

  echo $(cmp_module "󰒋 " "#H" "$color_bg" $is_last "$left_color_bg")
}
