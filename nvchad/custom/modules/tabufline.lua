local api = vim.api
local devicons_present, devicons = pcall(require, "nvim-web-devicons")
local fn = vim.fn
local new_cmd = api.nvim_create_user_command

require("base46").load_highlight "tbline"

---------------------------------------------------------- btn onclick functions ----------------------------------------------

vim.cmd "function! TbGoToBuf(bufnr,b,c,d) \n execute 'b'..a:bufnr \n endfunction"

vim.cmd [[
   function! TbKillBuf(bufnr,b,c,d) 
        call luaeval('require("core.utils").close_buffer(_A)', a:bufnr)
  endfunction]]

vim.cmd "function! TbNewTab(a,b,c,d) \n tabnew \n endfunction"
vim.cmd "function! TbGotoTab(tabnr,b,c,d) \n execute a:tabnr ..'tabnext' \n endfunction"
vim.cmd "function! TbTabClose(a,b,c,d) \n lua require('core.utils').closeAllBufs('closeTab') \n endfunction"
vim.cmd "function! TbCloseAllBufs(a,b,c,d) \n lua require('core.utils').closeAllBufs() \n endfunction"
vim.cmd "function! TbToggle_theme(a,b,c,d) \n lua require('base46').toggle_theme() \n endfunction"
vim.cmd "function! TbToggleTabs(a,b,c,d) \n let g:TbTabsToggled = !g:TbTabsToggled | redrawtabline \n endfunction"

---------------------------------------------------------- commands ------------------------------------------------------------
new_cmd("Tbufnext", function()
   require("core.utils").tabuflineNext()
end, {})

new_cmd("Tbufprev", function()
   require("core.utils").tabuflinePrev()
end, {})

new_cmd("Tbufclose", function()
   require("core.utils").close_buffer()
end, {})

-------------------------------------------------------- functions ------------------------------------------------------------
local function new_hl(group1, group2)
   local fg = fn.synIDattr(fn.synIDtrans(fn.hlID(group1)), "fg#")
   local bg = fn.synIDattr(fn.synIDtrans(fn.hlID(group2)), "bg#")
   api.nvim_set_hl(0, "Tbline" .. group1 .. group2, { fg = fg, bg = bg })
   return "%#" .. "Tbline" .. group1 .. group2 .. "#"
end

local function getNvimTreeWidth()
   for _, win in pairs(api.nvim_tabpage_list_wins(0)) do
      if vim.bo[api.nvim_win_get_buf(win)].ft == "NvimTree" then
         return api.nvim_win_get_width(win) + 1
      end
   end
   return 0
end

local function getBtnsWidth()
   local width = 6
   if fn.tabpagenr "$" ~= 1 then
      width = width + (3 * fn.tabpagenr "$") + 6
      width = not vim.g.TbTabsToggled and 8 or width
   end
   return width
end

local function add_fileInfo(name, bufnr)
   if devicons_present then
      local icon, icon_hl = devicons.get_icon(name, string.match(name, "%a+$"))

      if not icon then
         icon, icon_hl = devicons.get_icon "default_icon"
      end

      local fileInfo = " " .. icon .. " " .. name .. " " -- initial value
      local pad = (24 - #fileInfo) / 2

      icon = (
         api.nvim_get_current_buf() == bufnr and new_hl(icon_hl, "TbLineBufOn") .. " " .. icon
         or new_hl(icon_hl, "TbLineBufOff") .. " " .. icon
      )

      name = (#name > 15 and string.sub(name, 1, 13) .. "..") or name
      name = (api.nvim_get_current_buf() == bufnr and "%#TbLineBufOn# " .. name .. " ")
         or ("%#TbLineBufOff# " .. name .. " ")

      return string.rep(" ", pad) .. icon .. name .. string.rep(" ", pad - 1)
   end
end

local function styleBufferTab(nr)
   local close_btn = "%" .. nr .. "@TbKillBuf@ %X"
   local name = (#api.nvim_buf_get_name(nr) ~= 0) and fn.fnamemodify(api.nvim_buf_get_name(nr), ":t") or " No Name "
   name = "%" .. nr .. "@TbGoToBuf@" .. add_fileInfo(name, nr) .. "%X"

   -- color close btn for focused / hidden  buffers
   if nr == api.nvim_get_current_buf() then
      close_btn = (vim.bo[0].modified and "%" .. nr .. "@TbKillBuf@%#TbLineBufOnModified# ")
         or ("%#TbLineBufOnClose#" .. close_btn)
      name = "%#TbLineBufOn#" .. name .. close_btn
   else
      close_btn = (vim.bo[nr].modified and "%" .. nr .. "@TbKillBuf@%#TbBufLineBufOffModified# ")
         or ("%#TbLineBufOffClose#" .. close_btn)
      name = "%#TbLineBufOff#" .. name .. close_btn
   end

   return name
end

---------------------------------------------------------- components ------------------------------------------------------------
local M = {}

M.CoverNvimTree = function()
   return "%#NvimTreeNormal#" .. string.rep(" ", getNvimTreeWidth())
end

M.bufferlist = function()
   local buffers = {} -- buffersults
   local available_space = vim.o.columns - getNvimTreeWidth() - getBtnsWidth()
   local current_buf = api.nvim_get_current_buf()
   local has_current = false -- have we seen current buffer yet?

   local is_hidden_buffer = function(bufid)
     return (next(fn.win_findbuf(bufid)) == nil)
   end

   for _, bufnr in ipairs(vim.t.bufs) do
      if api.nvim_buf_is_valid(bufnr) then
         -- if is_hidden_buffer(bufnr) then
         --    goto continue
         -- end

         -- If space is lack and the current buffer is not found,
         -- removes from the earliest buffer.
         if ((#buffers + 1) * 21) > available_space then
            if has_current then
               break
            end

            table.remove(buffers, 1)
         end

         has_current = (bufnr == current_buf and true) or has_current
         table.insert(buffers, styleBufferTab(bufnr))
      end
      ::continue::
   end

   return table.concat(buffers) .. "%#TblineFill#" .. "%=" -- buffers + empty space
end

vim.g.TbTabsToggled = 0

M.tablist = function()
   local result, number_of_tabs = "", fn.tabpagenr "$"

   if number_of_tabs > 1 then
      for i = 1, number_of_tabs, 1 do
         local tab_hl = ((i == fn.tabpagenr()) and "%#TbLineTabOn# ") or "%#TbLineTabOff# "
         result = result .. ("%" .. i .. "@TbGotoTab@" .. tab_hl .. i .. " %X")
         -- result = (i == fn.tabpagenr() and result .. "%#TbLineTabCloseBtn#" .. "%@TbTabClose@ %X") or result
      end

      local new_tabtn = "%#TblineTabNewBtn#" .. "%@TbNewTab@  %X"
      local tabstoggleBtn = "%@TbToggleTabs@ %#TBTabTitle# TABS %X"

      return vim.g.TbTabsToggled == 1 and tabstoggleBtn:gsub("()", { [36] = " " })
         or new_tabtn .. tabstoggleBtn .. result
   end
end

M.buttons = function()
   return ""
end

return M
