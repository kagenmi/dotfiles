local M = {

   -- Neorg

   NeorgCodeBlock = { bg = "black2" },

   -- unordered lists
   NeorgUnorderedList1 = { fg = "grey" },
   NeorgUnorderedList2 = { fg = "grey" },
   NeorgUnorderedList3 = { fg = "grey" },
   NeorgUnorderedList4 = { fg = "grey" },
   NeorgUnorderedList5 = { fg = "grey" },
   NeorgUnorderedList6 = { fg = "grey" },

   -- headings
   NeorgHeading1Title = { fg = "white", bold = true },
   NeorgHeading1Prefix = { fg = "white", bold = true },

   NeorgHeading4Title = { fg = "blue", bold = true },
   NeorgHeading4Prefix = { fg = "blue", bold = true },

   NeorgHeading5Title = { fg = "red", bold = true },
   NeorgHeading5Prefix = { fg = "red", bold = true },

   NeorgHeading6Title = { fg = "purple", bold = true },
   NeorgHeading6Prefix = { fg = "purple", bold = true },

   NeorgMarkUpBold = {
      fg = "red",
      bold = true,
   },

   -- Default
   -- Normal = {
   --    bg = 'none',
   -- },
   Comment = {
      fg = '#646973',
   },
   FloatBorder = { fg = 'blue' },
   NormalFloat = { bg = 'lightbg' },

   -- nvim-tree
   NvimTreeWinSeparator = { fg = 'line', bg = 'darker_black', },

   -- which-key
   WhichKey = { fg = 'orange' },

   -- winshift
   WinShiftFocused = { bg = 'lightbg' }
}

return M
