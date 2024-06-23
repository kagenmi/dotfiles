local M = {}

---@type Base46HLGroupsList
M.hl_override = {
  Comment = {
    italic = true,
  },
}

---@type HLTable
M.hl_add = {
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
