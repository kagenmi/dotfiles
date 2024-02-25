local M = {}

M.treesitter = {
  ensure_installed = {
    "vim",
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

-- git support in nvimtree
M.nvimtree = {
  sync_root_with_cwd = true,
  git = {
    enable = true,
  },
  renderer = {
    highlight_git = true,
    highlight_opened_files = "all",
    root_folder_label = ":~",
    icons = {
      show = {
        git = true,
      },
    },
  },
  update_focused_file = {
    enable = false,
  },
  view = {
    preserve_window_proportions = false,
  },
  on_attach = function(bufnr)
    local api = require('nvim-tree.api')

    local function opts(desc)
      return { desc = "nvim-tree" .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true}
    end

    api.config.mappings.default_on_attach(bufnr)

    -- Explorer dir/file
    vim.keymap.set('n', 'O', api.tree.change_root_to_node, opts('cd'))
    vim.keymap.set('n', 'U', api.tree.change_root_to_parent, opts('Up'))

    -- Modify file
    vim.keymap.set('n', 'y', api.fs.copy.node, opts('Copy'))
  end,
  diagnostics = {
    enable = true,
    show_on_dirs = true,
  },
}

return M
