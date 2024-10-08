local present, hlchunk = pcall(require, "hlchunk")

if not present then
  return
end

local colors = require("base46").get_theme_tb "base_30"

local M = {}

M.setup = function()
  hlchunk.setup {
    chunk = {
      duration = 20,
      delay = 10,
      enable = true,
      notify = false,
      chars = {
        horizontal_line = "─",
        vertical_line = "│",
        left_top = "╭",
        left_bottom = "╰",
        right_arrow = "",
      },
      style = {
        colors.purple,
      },
    },

    indent = {
      enable = false,
      use_treesitter = false,
      chars = {
        "│",
      },
      style = {
        colors.line,
      },
      exclude_filetype = {
        dashboard = true,
        help = true,
        lspinfo = true,
        packer = true,
        checkhealth = true,
        man = true,
        mason = true,
        NvimTree = true,
        plugin = true,
      },
    },

    line_num = {
      enable = true,
      style = {
        colors.purple,
      },
    },

    blank = {
      enable = true,
      chars = {
        "․",
        "⁚",
        "⁖",
        "⁘",
        "⁙",
      },
      style = {
        colors.one_bg3,
      },
    },
  }
end

return M
