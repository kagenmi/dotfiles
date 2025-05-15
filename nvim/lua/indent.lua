local api = vim.api

-- Default settings
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2

local PROFILES = {
  four_spaces = { shiftwidth = 4, tabstop = 4, softtabstop = 4 }
}

local filetype_settings = {
  python = PROFILES.four_spaces,
  go = PROFILES.four_spaces,
}

-- オートコマンドを使ってファイルタイプごとの設定を適用
api.nvim_create_autocmd("FileType", {
  pattern = "*", -- すべてのファイルタイプを対象
  callback = function()
    local ft = vim.bo.filetype
    if filetype_settings[ft] then
      for opt, value in pairs(filetype_settings[ft]) do
        vim.bo[opt] = value
      end
    end
  end,
})
