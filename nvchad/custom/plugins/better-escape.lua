local M = {}

M.setup = function()
   local plugin = require("better_escape")

   plugin.setup {
      mapping = {"jk", "kj", "jj"},
      timeout = vim.o.timeoutlen,
      clear_empty_lines = false,
      keys = "<Esc>",
   }
end

return M
