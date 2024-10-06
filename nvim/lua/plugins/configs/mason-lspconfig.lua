local M = {}

M.setup = function()
  local mason_lspconfig = require "mason-lspconfig"
  local lspconfig = require "lspconfig"

  mason_lspconfig.setup({
    ensure_installed = {
      -- lua stuff
      "lua_ls",

      -- web dev stuff
      "cssls",
      "html",
      "ts_ls",
      "tailwindcss",
      "denols",
      "gopls",
      "pyright",

      -- others
      "terraformls",
    },
    automatic_installation = true,
  })

  mason_lspconfig.setup_handlers({
    function(server_name)
      lspconfig[server_name].setup {}
    end,
  })
end

return M
