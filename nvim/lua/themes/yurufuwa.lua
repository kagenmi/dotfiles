-- credit to original theme for existing https://github.com/ayu-theme/ayu-vim (light)
-- NOTE : This is a modified version of it

local M = {}

M.base_30 = {
  white = "#26292f",
  darker_black = "#dbf4ff",
  black = "#e6f7ff", --  nvim bg
  black2 = "#c3e0fe",
  one_bg = "#c3e0fe",
  one_bg2 = "#c4e0fe", -- Highlight of context
  one_bg3 = "#b0d6fe",
  grey = "#63c2ee",
  grey_fg = "#b7cee3",
  grey_fg2 = "#94a5b3", -- Highlight background
  light_grey = "#768c9d", -- Line numbers
  red = "#E65050",
  baby_pink = "#ff8282",
  pink = "#ffa5a5",
  line = "#d5e8ed", -- for lines like vertsplit
  green = "#96bf43",
  vibrant_green = "#94e76b",
  blue = "#2ca2d9",
  nord_blue = "#00abfa",
  yellow = "#E6BA7E",
  sun = "#f3c78b",
  purple = "#9F40FF",
  dark_purple = "#8627e6",
  teal = "#74c5aa",
  orange = "#FA8D3E",
  cyan = "#95E6CB",
  statusline_bg = "#b8e8ff",
  lightbg = "#85d8ff",
  pmenu_bg = "#95E6CB",
  folder_bg = "#5C6166",
}

M.base_16 = {
  base00 = "#e6f7ff",
  base01 = "#e1f5ff",
  base02 = "#ddf4ff",
  base03 = "#bfebff",
  base04 = "#a5e3ff",
  base05 = "#2f6192",
  base06 = "#2a5783",
  base07 = "#254d74",
  base08 = "#cb1564",
  base09 = "#A37ACC",
  base0A = "#399EE6",
  base0B = "#769221",
  base0C = "#4CBF99",
  base0D = "#55B4D4",
  base0E = "#FA8D3E",
  base0F = "#F2AE49",
}

M.polish_hl = {
  treesitter = {
    luaTSField = { fg = M.base_16.base0E },
    PmenuSel = { fg = M.base_30.white, bg = M.base_30.pmenu_bg },
    ["@tag.delimiter"] = { fg = M.base_30.base0D },
    ["@variable.parameter"] = { fg = M.base_16.base09 },
    ["@constructor"] = { fg = M.base_16.base0C },
    ["@tag.attribute"] = { fg = M.base_30.base0F },
  },
}

M = require("base46").override_theme(M, "yurufuwa")

M.type = "light"

return M
