---@type MappingsTable
local M = {}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },

    -- split window
    ['<leader>x'] = { ":split<CR>", "split window horizontally" },
    ['<leader>v'] = { ":vsplit<CR>", "split window vertically" },

    -- for surround.vim
    ["<S-b>"] = { "<S-b>", "" },
  },
  v = {
    [">"] = { ">gv", "indent"},
  },
}

M.winshift = {
  n = {
    ["<C-w>m"] = {
      ":WinShift<CR>",
      "Enter Win-Move move",
    },
    ["<C-w>x"] = {
      ":WinShift swap<CR>",
      "Swap windows",
    },
  },
}

M.comment = {
  n = {
    ["<leader>/"] = { "", "" },
    ["<C-_>"] = {
      function()
        require("Comment.api").toggle.linewise.current()
      end,
      "toggle comment",
    }
  },
  v = {
    ["<leader>/"] = { "", "" },
    ["<C-_>"] = {
      function()
        require("Comment.api").toggle.linewise(vim.fn.visualmode())
      end,
      "toggle comment",
    }
  }
}

M.tabufline = {
  n = {
    ["<leader>k"] = { "<cmd>tabnext<cr>", "Next tab" },
    ["<leader>j"] = { "<cmd>tabprevious<cr>", "Previous tab" },
  },
}


-- more keybinds!

return M
