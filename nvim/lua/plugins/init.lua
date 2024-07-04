local misc = require("configs.misc")

return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    event = "VeryLazy",
    config = function()
      local opts = require("configs.conform")
      require("conform").setup(opts)
    end,
  },

  -- Override plugin definition options
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require("configs.lspconfig").setup()
    end, -- Override to setup mason-lspconfig
  },

  {
    "stevearc/conform.nvim",
    config = function()
      require "configs.conform"
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    opts = misc.cmp,

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
    opts = misc.mason
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = misc.treesitter,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = require("configs.nvimtree"),
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
    opts = misc.flash,
    keys = {
      -- { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      -- { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      -- { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      -- { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      -- { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
  },

  -- Switch between ineline and multiline
  {
    "AndrewRadev/splitjoin.vim",
    event = "VeryLazy",
  },

  {
    "zapling/mason-conform.nvim",
    event = "VeryLazy",
    config = function()
      require("mason-conform").setup()
    end,
  },
}
