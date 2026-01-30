return {
  sources = {
    { name = "minuet" },
    -- trigger_characters is for unocss lsp
    { name = "nvim_lsp", trigger_characters = { "-" } },
    { name = "path" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "nvim_lua" },
  },
  experimental = {
    ghost_text = true,
  },
}
