local M = {}

M.treesitter = {
  ensure_installed = {
    "vim",
    "vimdoc",
    "lua",
    "html",
    "css",
    "javascript",
    "typescript",
    "tsx",
    "c",
    "markdown",
    "markdown_inline",
    "python",
    "terraform",
  },
  indent = {
    enable = true,
    -- disable = {
    --   "python"
    -- },
  },
}

M.cmp = {
  sources = {
    -- trigger_characters is for unocss lsp
    { name = "nvim_lsp", trigger_characters = { "-" } },
    { name = "path" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "codeium" },
    { name = "nvim_lua" },
  },
  experimental = {
    ghost_text = true,
  },
}

M.mason = {
  ensure_installed = {
    -- lua stuff
    "lua-language-server",
    "stylua",

    -- web dev stuff
    "css-lsp",
    "html-lsp",
    "typescript-language-server",
    "deno",
    "prettier",
    "tailwindcss-language-server",
    "gopls",
    "pyright",

    -- c/cpp stuff
    "terraform-ls",
  },
}

M.flash = {
  jump = {
    pos = "range",
  },
  modes = {
    char = {
      -- 'f', 'F', 't', 'T' with label
      jump_labels = true,
    },
  },
}

return M
