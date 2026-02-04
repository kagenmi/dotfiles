-- This file  needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/NvChad/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.base46 = {
	theme = "yurufuwa",
  theme_toggle = { "jabuti", "yurufuwa"},
}

M.base46 = vim.tbl_deep_extend('keep', M.base46, require "ui")

return M
