local overrides = require("custom.configs.overrides")

---@type NvPluginSpec[]
local plugins = {

  -- Override plugin definition options
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end, -- Override to setup mason-lspconfig
  },

  {
    "stevearc/conform.nvim",
    config = function()
      require "custom.configs.conform"
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    opts = overrides.cmp,

    dependencies = {
      {
        "jcdickinson/codeium.nvim",
        config = function()
          require("codeium").setup {}
        end,
      }
    }
  },

  -- override plugin configs
  {
    "williamboman/mason.nvim",
    opts = overrides.mason
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },

  -- Install a plugin
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },

  {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },

  -- },
  --  "fedepujol/bracketpair.nvim",
  --  event = "InsertEnter",
  -- },

  {
    "sindrets/winshift.nvim",
    lazy = false,
  },

  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({})
    end
  },

  -- pretty diagnostics panel
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    config = function()
      require("trouble").setup()
    end,
  },

  {
    "Vonr/align.nvim",
    branch = "v2",
    lazy = true,
  },

  -- Enhance f,t,F,T motions
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
      highlight = {
        backdrop = false,
      },
    },
    keys = {
      -- { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      -- { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      -- { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      -- { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      -- { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
  },

  -- general-purpose motion plugin
  -- {
  --   "ggandor/leap.nvim",
  --   keys = "s",
  -- }


  -- To make a plugin not be loaded
  -- {
  --   "NvChad/nvim-colorizer.lua",
  --   enabled = false
  -- },

  -- All NvChad plugins are lazy-loaded by default
  -- For a plugin to be loaded, you will need to set either `ft`, `cmd`, `keys`, `event`, or set `lazy = false`
  -- If you want a plugin to load on startup, add `lazy = false` to a plugin spec, for example
  -- {
  --   "mg979/vim-visual-multi",
  --   lazy = false,
  -- }
}

return plugins
