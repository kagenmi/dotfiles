local M = {}

M.setup = function()
   local present, winshift = pcall(require, "winshift")

   if not present then
      return
   end

   winshift.setup {
      highlight_moving_win = true,  -- Highlight the window being moved
      focused_hl_group = "WinShiftFocused",  -- The highlight group used for the moving window
      moving_win_options = {
         -- These are local options applied to the moving window while it's
         -- being moved. They are unset when you leave Win-Move mode.
         wrap = false,
         cursorline = false,
         cursorcolumn = false,
         colorcolumn = "",
      },
      keymaps = {
         disable_defaults = true, -- Disable the default keymaps
         win_move_mode = {
            ["h"] = "left",
            ["j"] = "down",
            ["k"] = "up",
            ["l"] = "right",
            ["H"] = "far_left",
            ["J"] = "far_down",
            ["K"] = "far_up",
            ["L"] = "far_right",
         },
      },
      ---A function that should prompt the user to select a window.
      ---
      ---The window picker is used to select a window while swapping windows with
      ---`:WinShift swap`.
      ---@return integer? winid # Either the selected window ID, or `nil` to
      ---   indicate that the user cancelled / gave an invalid selection.
      window_picker = function()
         return require("winshift.lib").pick_window {
            -- A string of chars used as identifiers by the window picker.
            picker_chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
            filter_rules = {
               -- This table allows you to indicate to the window picker that a window
               -- should be ignored if its buffer matches any of the following criteria.
               cur_win = true, -- Filter out the current window
               floats = true,  -- Filter out floating windows
               filetype = {'NvimTree'},  -- List of ignored file types
               buftype = {},   -- List of ignored buftypes
               bufname = {},   -- List of vim regex patterns matching ignored buffer names
            },
            ---A function used to filter the list of selectable windows.
            ---@param winids integer[] # The list of selectable window IDs.
            ---@return integer[] filtered # The filtered list of window IDs.
            filter_func = nil,
         }
      end,
   }
end

return M
