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
  grey = "#2b7ba6",
  grey_fg = "#b7cee3",
  grey_fg2 = "#5a7088", -- Highlight background
  light_grey = "#537186", -- Line numbers
  red = "#c71f1f",
  baby_pink = "#d43636",
  pink = "#e04545",
  line = "#d5e8ed", -- for lines like vertsplit
  green = "#5d7718",
  vibrant_green = "#5d7718",
  blue = "#1b6b9e",
  nord_blue = "#0073b8",
  yellow = "#936717",
  sun = "#a87520",
  purple = "#6c2ab3",
  dark_purple = "#5d1fa8",
  teal = "#197d5f",
  orange = "#ad4f17",
  cyan = "#1a7d6a",
  statusline_bg = "#b8e8ff",
  lightbg = "#85d8ff",
  pmenu_bg = "#1a7d6a",
  folder_bg = "#5C6166",
}

M.base_16 = {
  base00 = "#e6f7ff",
  base01 = "#e1f5ff",
  base02 = "#ddf4ff",
  base03 = "#5a7088",
  base04 = "#a5e3ff",
  base05 = "#2f6192",
  base06 = "#2a5783",
  base07 = "#254d74",
  base08 = "#cb1564",
  base09 = "#7a3d99",
  base0A = "#1a6b9e",
  base0B = "#5d7718",
  base0C = "#1a7d6a",
  base0D = "#1b6b9e",
  base0E = "#ad4f17",
  base0F = "#936717",
}

M.polish_hl = {
  treesitter = {
    luaTSField = { fg = M.base_16.base0E },
    PmenuSel = { fg = M.base_30.white, bg = M.base_30.pmenu_bg },
    ["@tag.delimiter"] = { fg = M.base_16.base0D },
    ["@variable.parameter"] = { fg = M.base_16.base09 },
    ["@constructor"] = { fg = M.base_16.base0C },
    ["@tag.attribute"] = { fg = M.base_16.base0F },
    ["@comment"] = { fg = M.base_16.base03, italic = true },
    ["@keyword"] = { fg = M.base_16.base0E },
    ["@keyword.function"] = { fg = M.base_16.base0E },
    ["@function"] = { fg = M.base_16.base0D },
    ["@function.builtin"] = { fg = M.base_16.base0C },
    ["@string"] = { fg = M.base_16.base0B },
    ["@number"] = { fg = M.base_16.base09 },
    ["@boolean"] = { fg = M.base_16.base09 },
    ["@constant"] = { fg = M.base_16.base09 },
    ["@type"] = { fg = M.base_16.base0A },
    ["@operator"] = { fg = M.base_16.base05 },
  },
}

M = require("base46").override_theme(M, "yurufuwa")

M.type = "light"

return M
