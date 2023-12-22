local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local lsputil = require "lspconfig/util"

local utils = require "custom.utils"

-- if you just want default config for the servers then put them in a table
local servers = { "html", "cssls", "tsserver", "clangd" }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

lspconfig.pyright.setup {
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
}
