local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    css = { "prettier" },
    html = { "prettier" },
    javascript = { "prettier" },
    python = { "autopep8", "isort" },
    sh = { "shfmt" },
    json = { "prettier" },
    terraform = { "terraform_fmt" },
    ["terraform-vars"] = { "terraform_fmt" },
    ["_"] = { "trim_whitespace" },
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    formatters = { "trim_whitespace", }
  },

  formatters = {
    shfmt = {
      -- TODO: Dynamic setting indent size
      prepend_args = { "-i", "2", "-ci" }
    },
  },
}

return options
