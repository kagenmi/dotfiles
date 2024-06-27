-- This file  needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/NvChad/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.ui = {
	theme = "jabuti",
  theme_toggle = { "jabuti", "ayu_light"},
}

M.ui = vim.tbl_deep_extend('keep', M.ui, require "ui")

return M
