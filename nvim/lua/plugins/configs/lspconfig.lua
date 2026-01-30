local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local utils = require "utils"

-- Server configurations using new vim.lsp.config API (Neovim 0.11+)
local server_configs = {
  html = {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  },
  cssls = {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
    settings = {
      css = {
        validate = true,
        lint = {
          unknownAtRules = "ignore",
        },
      },
      less = {
        validate = true,
        lint = {
          unknownAtRules = "ignore",
        },
      },
      scss = {
        validate = true,
        lint = {
          unknownAtRules = "ignore",
        },
      },
    },
  },
  clangd = {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  },
  gopls = {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  },
  tailwindcss = {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  },
  powershell_es = {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  },
  pyright = {
    on_attach = on_attach,
    on_init = function(client)
      on_init(client)
      client.config.settings.python.pythonPath = utils.get_python_path(client.config.root_dir)
    end,
    capabilities = capabilities,
    settings = {
      python = {
        analysis = {
          diagnosticSeverityOverrides = {
            reportUnboundVariable = 'none',
            reportOptionalIterable = 'none',
            reportOptionalSubscript = 'none',
            reportGeneralTypeIssues = 'none',
          },
          autoSearchPaths = true,
          diagnosticMode = "workspace",
          useLibraryCodeForTypes = true,
        },
      },
    },
  },
  ts_ls = {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
    init_options = {
      hostInfo = 'neovim',
      preferences = {
        quotePreference = 'single',
      },
      plugins = {
        {
          name = "@vue/typescript-plugin",
          location = "/usr/local/lib/node_modules/@vue/typescript-plugin",
          languages = {"javascript", "typescript", "vue"},
        },
      },
    },
  },
}

local function setup()
  for server_name, config in pairs(server_configs) do
    vim.lsp.config[server_name] = config
    vim.lsp.enable(server_name)
  end
end

local servers = vim.tbl_keys(server_configs)

return {
  servers = servers,
  setup = setup,
}
