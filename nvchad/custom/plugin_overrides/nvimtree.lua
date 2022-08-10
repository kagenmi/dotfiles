local plugin = "kyazdani42/nvim-tree.lua"
local config = {
   sync_root_with_cwd = true,
   git = {
      enable = true,
   },
   renderer = {
      highlight_git = true,
      highlight_opened_files = "all",
      root_folder_modifier = ":~",
      icons = {
         show = {
            git = true,
         },
      },
   },
   update_focused_file = {
      enable = true,
      update_root = false,
   },
   view = {
      adaptive_size = false,
      hide_root_folder = false,
      preserve_window_proportions = false, -- If false, the size of windows will be equalized.
      -- :help nvim-tree-mappings[-default]
      mappings = {
         custom_only = true,
         list = {
            -- Explorer dir/file
            { key = { "<CR>", "o", "<2-LeftMouse>" }, action = "edit" },
            { key = { "O", "<2-RightMouse>" },        action = "cd" },
            { key = "U",                              action = "dir_up" },
            { key = "c",                              action = "close_node" },
            { key = "P",                              action = "parent_node" },
            { key = "<",                              action = "prev_sibling" },
            { key = ">",                              action = "next_sibling" },
            { key = "K",                              action = "first_sibling" },
            { key = "J",                              action = "last_sibling" },
            { key = "R",                              action = "refresh" },
            { key = "W",                              action = "collapse_all" },
            { key = "E",                              action = "expand_all" },

            -- Open file
            { key = "<C-v>",                          action = "vsplit" },
            { key = "<C-x>",                          action = "split" },
            { key = "<C-t>",                          action = "tabnew" },
            { key = "s",                              action = "system_open" },

            -- Modify file
            { key = "a",                              action = "create" },
            { key = "d",                              action = "remove" },
            { key = "D",                              action = "trash" },
            { key = "r",                              action = "rename" },
            { key = "<C-r>",                          action = "full_rename" },
            { key = "x",                              action = "cut" },
            { key = "y",                              action = "copy" },
            { key = "p",                              action = "paste" },

            -- misc.
            { key = "gy",                             action = "copy_absolute_path" },
            { key = "f",                              action = "live_filter" },
            { key = "F",                              action = "clear_live_filter" },
            { key = "S",                              action = "search_node" },

            -- Show information
            { key = "i",                              action = "toggle_file_info" },
            { key = "?",                              action = "toggle_help" },
            { key = "m",                              action = "toggle_mark" },
            --
            -- -- Disable
            -- { key = "<C-e>",                          action = "" },
            -- { key = "<Tab>",                          action = "" },
            -- { key = "I",                              action = "" },
            -- { key = "H",                              action = "" },
            -- { key = ".",                              action = "" },
            -- { key = "Y",                              action = "" },
            -- { key = "q",                              action = "" },
            -- { key = "[e",                             action = "" },
            -- { key = "[c",                             action = "" },
            -- { key = "]e",                             action = "" },
            -- { key = "]c",                             action = "" },
            -- { key = "g?",                             action = "" },
            -- { key = "<C-k>",                          action = "" },
            -- { key = "-",                              action = "" },

         },
      },
   },
   diagnostics = {
      enable = true,
      show_on_dirs = true,
   },
   filesystem_watchers = {
      enable = true,
   },
}

return {plugin, config}
