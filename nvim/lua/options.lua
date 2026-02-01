require "nvchad.options"

local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!

-- Auto change directory to the file's directory
o.autochdir = true

-- WSL environment: Force xclip for clipboard (avoid wl-copy)
if vim.fn.has('wsl') == 1 then
  vim.g.clipboard = {
    name = 'xclip',
    copy = {
      ['+'] = 'xclip -selection clipboard',
      ['*'] = 'xclip -selection clipboard',
    },
    paste = {
      ['+'] = 'xclip -selection clipboard -o',
      ['*'] = 'xclip -selection clipboard -o',
    },
    cache_enabled = true,
  }
end
