local lspconfig = require "lspconfig"
local lsputil = require "lspconfig/util"

local on_attach = require("plugins.configs.lspconfig").on_attach;
local capabilities = require("plugins.configs.lspconfig").capabilities;

local utils = require("custom.utils")

local servers = { "html", "cssls", "bashls", "emmet_ls", "clangd", "pyright", "eslint" }

for _, lsp in ipairs(servers) do
   if lsp == "pyright" then
      lspconfig[lsp].setup {
         on_attach = on_attach,
         capabilities = capabilities,
         root_dir = lsputil.root_pattern { "pyproject.toml", ".git" },
         settings = {
            python = {
               analysis = {
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
   else
      lspconfig[lsp].setup {
         on_attach = on_attach,
         capabilities = capabilities,
      }
   end

end
