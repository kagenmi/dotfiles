local M = {}

M.scandir = function(directory)
   local files = {}
   local path = vim.fn.stdpath('config')..'/lua/'..directory
   local filter = [[v:val =~ '\.lua$']]

   for _, file in ipairs(vim.fn.readdir(path, filter)) do
      local name = ''..file:gsub('%.lua$', '')
      table.insert(files, name)
   end

   return files
end

M.load_overrides = function()
   local overrides = {}

   for _, filename in ipairs(M.scandir('custom/plugin_overrides')) do
      local config = require('custom.plugin_overrides.' .. filename)
      overrides[config[1]] = config[2]
   end

   return overrides
end

M.path_join = function(...)
   return table.concat( vim.tbl_flatten {...}, "/")
end

M.get_python_path = function(workspace)
   local path_join = M.path_join

   -- Use activated virtualenv.
   if vim.env.VIRTUAL_ENV then
      return path_join(vim.env.VIRTUAL_ENV, "bin", "python")
   end

   -- Check for uv project
   if vim.fn.glob(path_join(workspace, "pyproject.toml")) ~= "" then
      local uv_python = vim.fn.trim(vim.fn.system("cd " .. workspace .. " && uv python find 2>/dev/null"))
      if vim.v.shell_error == 0 and uv_python ~= "" then
         return uv_python
      end
   end

   -- Check for a poetry.lock file
   if vim.fn.glob(path_join(workspace, "poetry.lock")) ~= "" then
      return path_join(vim.fn.trim(vim.fn.system "poetry env info -p"), "bin", "python")
   end

   -- Find and use virtualenv from pipenv in workspace directory.
   local match = vim.fn.glob(path_join(workspace, "Pipfile"))
   if match ~= "" then
      local venv = vim.fn.trim(vim.fn.system("PIPENV_PIPFILE=" .. match .. " pipenv --venv"))
      return path_join(venv, "bin", "python")
   end

   -- Fallback to system Python.
   return vim.fn.exepath "python3" or vim.fn.exepath "python" or "python"
end

return M
