local plugin = "NvChad/ui"
local config = {
   statusline = {
      overriden_modules = function()
         return require('custom.modules.statusline')
      end,
   },
   tabufline = {
      overriden_modules = function()
         return require('custom.modules.tabufline')
      end,
   },
}

return {plugin, config}

