return {
  -- Override plugin definition options

  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    event = "VeryLazy",
    config = function()
      local opts = require("plugins.configs.conform")
      require("conform").setup(opts)
    end,
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require("plugins.configs.lspconfig").setup()
    end, -- Override to setup mason-lspconfig
  },

  {
    "hrsh7th/nvim-cmp",
    opts = require("plugins.configs.cmp"),

    dependencies = {
      {
        "jcdickinson/codeium.nvim",
        config = function()
          require("codeium").setup {}
        end,
      }
    }
  },

  {
    "nvchad/minty",
    event = "BufReadPost",
    dependencies = {
      "nvchad/volt",
      "nvchad/menu",
    },
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
      scope = { enabled = false },
    },
  },

  {
    "williamboman/mason.nvim",
    opts = require("plugins.configs.mason")
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = require("plugins.configs.treesitter"),
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = require("plugins.configs.nvimtree"),
  },

  -- Install custom plugins
  -- ----------------------

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
    opts = require("plugins.configs.flash"),
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
    dependencies = { "williamboman/mason.nvim", "stevearc/conform.nvim" },
    config = function()
      require("mason-conform").setup()
    end,
  },

  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "neovim/nvim-lspconfig" },
    event = { "User FilePost" },
    -- lazy = false,
    config = function()
      require("plugins.configs.mason-lspconfig").setup()
    end,
  },

  {
    "shellRaining/hlchunk.nvim",
    event = "BufReadPost",
    config = function()
      require("plugins.configs.hlchunk").setup()
    end,
  }
}
