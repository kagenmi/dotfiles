---@type MappingsTable
local M = {}

M.general = {
  n = {
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
    -- cycle through tabs
    ["<tab>"] = { "<cmd>tabnext<cr>", "Next tab" },
    ["<S-tab>"] = { "<cmd>tabprevious<cr>", "Previous tab" },

    -- cycle through buffers
    ["<leader>k"] = {
      function()
        require("nvchad.tabufline").tabuflineNext()
      end,
      "Goto next buffer",
    },

    ["<leader>j"] = {
      function()
        require("nvchad.tabufline").tabuflinePrev()
      end,
      "Goto prev buffer",
    },
  },
}


-- more keybinds!

return M
