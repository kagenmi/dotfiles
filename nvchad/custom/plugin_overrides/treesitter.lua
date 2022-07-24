local plugin = "nvim-treesitter/nvim-treesitter"
local config = {
   ensure_installed = {
      "vim",
      "html",
      "css",
      "javascript",
      "json",
      "toml",
      "markdown",
      "c",
      "bash",
      "lua",
      "norg",
      "python",
   },
}

return {plugin, config}
