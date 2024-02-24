-- To find any highlight groups: "<cmd> Telescope highlights"
-- Each highlight group can take a table with variables fg, bg, bold, italic, etc
-- base30 variable names can also be used as colors

local M = {}

---@type Base46HLGroupsList
M.override = {
  Comment = {
    italic = true,
  },
}

---@type HLTable
M.add = {
  NvimTreeOpenedFolderName = { fg = "green", bold = true },
  -- ExtraWhitespace = { bg = "red" },

  -- bufferline
  TbLineBufOn = { fg = 'white', bg = 'one_bg3', bold = true },
}

M.changed_themes = {
  tokyonight = {
    base_30 = {
      -- default is too dark
      grey_fg = '#8b93b6',
    }
  },
  onenord = {
    base_30 = {
      -- default is too dark
      grey_fg = '#737c8c',
    }
  },
}

return M
