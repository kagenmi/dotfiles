local M = {}

M.hello = {
   -- NOTE: In the official config, the 2nd parameter is missing.
   n = {
      ["j"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "", opts = { expr = true } },
      ["k"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "", opts = { expr = true } },
      ["<Up>"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', opts = { expr = true } },
      ["<Down>"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', opts = { expr = true } },
   },
   v = {
      ["j"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "", opts = { expr = true } },
      ["k"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "", opts = { expr = true } },
      ["<Up>"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "", opts = { expr = true } },
      ["<Down>"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "", opts = { expr = true } },

      ['<'] = { "<gv", "Indent backward" },
      ['>'] = { ">gv", "Indent forward" },

      -- Don't copy after pasting
      ["p"] = { 'p:let @+=@0<CR>:let @"=@0<CR>', "", opts = { silent = true } },
   },

}

M.truzen = {
   n = {
      ["<leader>ta"] = { "<cmd> TZAtaraxis <CR>", "   truzen ataraxis" },
      ["<leader>tm"] = { "<cmd> TZMinimalist <CR>", "   truzen minimal" },
      ["<leader>tf"] = { "<cmd> TZFocus <CR>", "   truzen focus" },
   },
}

M.treesitter = {
   n = {
      ["<leader>cu"] = { "<cmd> TSCaptureUnderCursor <CR>", "  find media" },
   },
}

M.shade = {
   n = {
      ["<leader>s"] = {
         function()
            require("shade").toggle()
         end,

         "   toggle shade.nvim",
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

         "蘒  toggle comment",
      },
   },
   v = {
      ["<leader>/"] = "",
      ["<C-_>"] = {
         "<ESC><cmd>lua require('Comment.api').toggle_linewise_op(vim.fn.visualmode())<CR>",
         "蘒  toggle comment",
      },
   },
}

M.tabufline = {
   n = {
      ["<TAB>"] = { "<cmd> tabprevious <CR>", "  goto next tab" },
      ["<S-TAB>"] = { "<cmd> tabnext <CR> ", "  goto prev tab" }
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
         "  Quick Run",
      },
   },
}

M.winshift = {
   n = {
      ["<C-w>m"] = {
         ":WinShift<CR>",
         "侀Enter Win-Move mode",
      },
      ["<C-w>x"] = {
         ":WinShift swap<CR>",
         "侀Swap windows",
      },
   },
}


return M
