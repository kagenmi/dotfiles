local M = {}

M.general = {
   n = {
      ['<leader>cc'] = { "<cmd> bufdo q <CR>", "close all buffers" },
   },
   v = {
      ['<'] = { "<gv", "Indent backward" },
      ['>'] = { ">gv", "Indent forward" },
   },
}

M.truzen = {
   n = {
      ["<leader>ta"] = { "<cmd> TZAtaraxis <CR>", "truzen ataraxis" },
      ["<leader>tm"] = { "<cmd> TZMinimalist <CR>", "truzen minimal" },
      ["<leader>tf"] = { "<cmd> TZFocus <CR>", "truzen focus" },
   },
}

M.treesitter = {
   n = {
      ["<leader>cu"] = { "<cmd> TSCaptureUnderCursor <CR>", "find media" },
   },
}

M.shade = {
   n = {
      ["<leader>s"] = {
         function()
            require("shade").toggle()
         end,

         "toggle shade.nvim",
      },
   },
}

M.tabufline = {
   n = {
      ["<S-b>"] = "",
   },
}

M.comment = {
   n = {
      ["<leader>/"] = "",
      ["<C-_>"] = {
         function()
            require("Comment.api").toggle_current_linewise()
         end,

         "toggle comment",
      },
   },
   v = {
      ["<leader>/"] = "",
      ["<C-_>"] = {
         "<ESC><cmd>lua require('Comment.api').toggle_linewise_op(vim.fn.visualmode())<CR>",
         "toggle comment",
      },
   },
}

M.tabufline = {
   n = {
      ["<TAB>"] = { "<cmd> tabprevious <CR>", "goto next tab" },
      ["<S-TAB>"] = { "<cmd> tabnext <CR> ", " goto prev tab" }
   }
}

M.nvimtree = {
   n = {
      ["<leader>e"] = {},
   }
}

M.quickrun = {
   n = {
      ["<leader>qr"] = {
         ":QuickRun<CR>",
         "Quick Run",
      },
   },
}

M.winshift = {
   n = {
      ["<C-w>m"] = {
         ":WinShift<CR>",
         "Enter Win-Move mode",
      },
      ["<C-w>x"] = {
         ":WinShift swap<CR>",
         "Swap windows",
      },
   },
}


return M
