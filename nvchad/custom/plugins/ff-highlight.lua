local M = {}

M.setup = function()
   local present, fFHighlight = pcall(require, "ff-highlight")

   if not present then
      return
   end

   fFHighlight.setup {
      disable_keymap = false,

      disable_words_hl = false,

      -- If the count of repeating latest `f` or `F` to the char is equal or greater
      -- than this value, use number to overlap char. minimal value is 2
      number_hint_threshold = 3,

      -- The optional dict argument for sign_define(), `:h sign_define()` for
      -- more details. If this value is `{}`, will disable sign for prompt
      prompt_sign_define = {text = '✹', text_hl = 'fFPromptSign', culhl = 'fFPromptSign'}

      -- Highlight groups
      -- - fFHintChar
      -- - fFHintNumber
      -- - fFHintWords
      -- - fFPromptSign
   }
end

return M

