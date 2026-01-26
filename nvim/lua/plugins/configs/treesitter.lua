return {
  opts = {
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
    "hcl",
  },
  indent = {
    enable = true,
    -- disable = {
    --   "python"
    -- },
  },

  },
  setup = function()
    local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
    parser_config.bicep = {
      install_info = {
        url = 'https://github.com/tree-sitter-grammars/tree-sitter-bicep',
        files = { 'src/parser.c', 'src/scanner.c' },
        branch = 'main',
      },
      filetype = 'bicep',
    }
  end,
}
