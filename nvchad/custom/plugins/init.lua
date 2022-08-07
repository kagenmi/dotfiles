return {
   -- autoclose tags in html, jsx etc
   ["windwp/nvim-ts-autotag"] = {
      ft = { "html", "javascriptreact" },
      after = "nvim-treesitter",
      config = function()
         require("custom.plugins.smolconfigs").autotag()
      end,
   },

   -- format & linting
   -- ["jose-elias-alvarez/null-ls.nvim"] = {
   --    after = "nvim-lspconfig",
   --    config = function()
   --       require "custom.plugins.null-ls"
   --    end,
   -- },

   -- minimal modes
   ["Pocco81/TrueZen.nvim"] = {
      cmd = {
         "TZAtaraxis",
         "TZMinimalist",
         "TZFocus",
      },
      config = function()
         require "custom.plugins.truezen"
      end,
   },

   -- notes stuff
   ["nvim-neorg/neorg"] = {
      ft = "norg",
      after = "nvim-treesitter",
      config = function()
         require "custom.plugins.neorg"
      end,
   },

   -- get highlight group under cursor
   ["nvim-treesitter/playground"] = {
      cmd = "TSCaptureUnderCursor",
      config = function()
         require("nvim-treesitter.configs").setup()
      end,
   },

   -- dim inactive windows
   ["andreadev-it/shade.nvim"] = {
      module = "shade",
      config = function()
         require("custom.plugins.smolconfigs").shade()
      end,
   },

   -- ["Pocco81/AutoSave.nvim"] = {
   --    module = "autosave",
   --    -- event = "InsertEnter",
   --    config = function()
   --       require("custom.plugins.smolconfigs").autosave()
   --    end,
   -- },

   ["tpope/vim-surround"] = {},

   ["max397574/better-escape.nvim"] = {
      event = 'InsertEnter',
      config = function()
         require("custom.plugins.better-escape").setup()
      end,
   },

   ["thinca/vim-quickrun"] = {
      opt = true,
   },

   ["andymass/vim-matchup"] = {
      opt = true,
   },

   ["sindrets/winshift.nvim"] = {
      module = "winshift",
      keys = { "<C-w>" },
      setup = function()
         require("custom.plugins.winshift").setup()
      end,
   },

   ["folke/todo-comments.nvim"] = {
      module = "todo-comments",
      event = 'InsertEnter',
      config = function()
         require("custom.plugins.todo-comments").setup()
      end,
   },

   ["kevinhwang91/nvim-fFHighlight"] = {
      module = "ff-highlight",
      keys = {{'n', 'f'}, {'x', 'f'}, {'n', 'F'}, {'x', 'F'}},
      config = function()
         require("custom.plugins.ff-highlight").setup()
      end,
   },
}
