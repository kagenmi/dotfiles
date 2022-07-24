local M = {}

local utils = require "custom.utils"

M.plugins = {
   override = utils.load_overrides(),

   user = require "custom.plugins",
}

M.ui = {
   hl_override = require "custom.highlights.hl_override",
   hl_add = require "custom.highlights.hl_add",
   theme = "tokyonight",
   theme_toggle = { "gruvchad", "gruvbox_light" },
}

M.mappings = require "custom.mappings"

return M
