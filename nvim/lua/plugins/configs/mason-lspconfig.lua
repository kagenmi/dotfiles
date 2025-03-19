local M = {}

local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

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
      "gopls",
      "pyright",

      -- others
      "powershell_es",
      "terraformls",
    },
    automatic_installation = true,
    handlers = {
      function (server_name)
        lspconfig[server_name].setup {
          on_attach = on_attach,
          on_init = on_init,
          capabilities = capabilities,
        }
      end,

      terraformls = function()
        lspconfig.terraformls.setup {
          on_attach = function(client, bufnr)
            print("on_attach()")
            on_attach(client, bufnr)
            vim.api.nvim_buf_set_option(bufnr, "commentstring", "// %s")
          end,
          on_init = on_init,
          capabilities = capabilities,
        }
      end,
    }
  })
end

return M
