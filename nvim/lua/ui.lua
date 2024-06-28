local M = {}

---@type HLTable
M.hl_add = {
  NvimTreeOpenedFolderName = { fg = "green", bold = true },
  -- ExtraWhitespace = { bg = "red" },

  -- bufferline
  TbLineBufOn = { fg = 'white', bg = 'one_bg3', bold = true },

  -- flash
  Flashbackdrop = { bold = true },
  FlashMatch = { fg = 'black', bg = 'white' },
  FlashCurrent = { fg = 'black', bg = 'purple' },
  FlashLabel = { fg = 'black', bg = '#FF75A0', bold = true },
}

---@type Base46HLGroupsList
M.hl_override = {
  LineNr = { fg = 'grey_fg2' },
  Comment = { fg = 'nord_blue', italic = true },
  ['@comment'] = { fg = 'nord_blue', italic = true }, -- for treesitter
  NvimTreeWinSeparator = { fg = 'light_grey' },
  WinSeparator = { fg = 'light_grey' },
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
