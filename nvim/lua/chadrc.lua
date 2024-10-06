-- This file  needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/NvChad/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.base46 = {
	theme = "jabuti",
  theme_toggle = { "jabuti", "ayu_light"},
}

M.base46 = vim.tbl_deep_extend('keep', M.base46, require "ui")

return M
