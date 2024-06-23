local M = {}

M.get_python_path = function(workspace)
   local path_join = M.path_join

   -- Use activated virtualenv.
   if vim.env.VIRTUAL_ENV then
      return path_join(vim.env.VIRTUAL_ENV, "bin", "python")
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
