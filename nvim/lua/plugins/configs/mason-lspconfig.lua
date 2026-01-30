local M = {}

local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local function setup_server(server_name, config)
  vim.lsp.config[server_name] = config
  vim.lsp.enable(server_name)
end

M.setup = function()
  local mason_lspconfig = require "mason-lspconfig"

  mason_lspconfig.setup({
    ensure_installed = {
      "lua_ls",
      "cssls",
      "html",
      "ts_ls",
      "tailwindcss",
      "gopls",
      "pyright",
      "powershell_es",
      "terraformls",
      "tflint",
      "bicep",
    },
    automatic_installation = true,
    handlers = {
      function (server_name)
        setup_server(server_name, {
          on_attach = on_attach,
          on_init = on_init,
          capabilities = capabilities,
        })
      end,

      lua_ls = function()
        setup_server("lua_ls", {
          on_attach = on_attach,
          on_init = on_init,
          capabilities = capabilities,
          settings = {
            Lua = {
              runtime = {
                version = "LuaJIT",
              },
              diagnostics = {
                globals = { "vim" },
              },
              workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
              },
              telemetry = {
                enable = false,
              },
            },
          },
        })
      end,

      terraformls = function()
        setup_server("terraformls", {
          on_attach = function(client, bufnr)
            on_attach(client, bufnr)
            vim.bo[bufnr].commentstring = "// %s"
          end,
          on_init = on_init,
          capabilities = capabilities,
          filetypes = { "terraform", "tf", "hcl", "terraform-vars" },
        })
      end,

      bicep = function()
        setup_server("bicep", {
          on_attach = function(client, bufnr)
            on_attach(client, bufnr)
            vim.bo[bufnr].commentstring = "// %s"
          end,
          on_init = on_init,
          capabilities = capabilities,
        })
      end,
    }
  })
end

return M
