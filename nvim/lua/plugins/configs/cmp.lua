return {
  sources = {
    -- trigger_characters is for unocss lsp
    { name = "codeium" },
    { name = "nvim_lsp", trigger_characters = { "-" } },
    { name = "path" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "nvim_lua" },
    { name = "copilot" },
  },
  experimental = {
    ghost_text = true,
  },
}
