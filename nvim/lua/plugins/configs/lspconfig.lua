local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local lsputil = require "lspconfig/util"

local utils = require "utils"

-- if you just want default config for the servers then put them in a table
local server_opts = {
  html = {},
  cssls = {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      css = {
        validate = true,
        lint = {
          unknownAtRules = "ignore", -- Suppress warning: cssls cannot recognize tailwindcss
        },
      },
      less = {
        validate = true,
        lint = {
          unknownAtRules = "ignore", -- Suppress warning: cssls cannot recognize tailwindcss
        },
      },
      scss = {
        validate = true,
        lint = {
          unknownAtRules = "ignore", -- Suppress warning: cssls cannot recognize tailwindcss
        },
      },
    },
  },
  clangd = {},
  gopls = {},
  terraformls = {},
  tailwindcss = {},
  tflint = {},
  hclfmt = {},
  powershell_es = {},
  pyright = {
    on_attach = on_attach,
    capabilities = capabilities,
    root_dir = lsputil.root_pattern { "pyproject.toml", ".git" },
    settings = {
      python = {
        analysis = {
          diagnosticSeverityOverrides = {
            reportUnboundVariable = 'none',
            reportOptionalIterable = 'none',
            reportOptionalSubscript = 'none',
            reportGeneralTypeIssues = 'none',
          },
          authSearchPath = true,
          diagnosticMode = "workspace",
          useLibraryCodeForTypes = true,
        },
      },
    },
    on_init = function(client)
      client.config.settings.python.pythonPath = utils.get_python_path(client.config.root_dir)
    end,
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
  for lsp, opt in pairs(server_opts) do
    if next(opt) == nil then
      lspconfig[lsp].setup {
        on_attach = on_attach,
        on_init = on_init,
        capabilities = capabilities,
      }
    else
      lspconfig[lsp].setup(opt)
    end
  end
end

local servers = vim.tbl_keys(server_opts)

return {
  servers = servers,
  setup = setup,
}
