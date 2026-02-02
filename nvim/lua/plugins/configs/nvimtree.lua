local function change_root_to_project_root()
  local api = require('nvim-tree.api')

  -- Get current working directory from nvim-tree's perspective
  local cwd = vim.fn.getcwd()

  -- Find .git directory by traversing up the directory tree
  local function find_git_root(path)
    local git_dir = path .. '/.git'
    if vim.fn.isdirectory(git_dir) == 1 or vim.fn.filereadable(git_dir) == 1 then
      return path
    end

    local parent = vim.fn.fnamemodify(path, ':h')
    if parent == path then
      return nil -- Reached root directory
    end

    return find_git_root(parent)
  end

  local git_root = find_git_root(cwd)

  if git_root then
    api.tree.change_root(git_root)
  else
    vim.notify("Git repository not found", vim.log.levels.WARN)
  end
end

return {
  sync_root_with_cwd = true,
  git = {
    enable = true,
  },
  filters = {
    git_ignored = false,
    custom = {"^\\.git$", "^venv$", "^\\.venv$", "^__pycache__$"},
  },
  renderer = {
    highlight_git = true,
    highlight_opened_files = "all",
    root_folder_label = ":~",
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
    preserve_window_proportions = false,
  },
  tab = {
    sync = {
      open = true,
      close = true,
    },
  },
  trash = {
    cmd = "trash-put",
  },
  on_attach = function(bufnr)
    local api = require('nvim-tree.api')

    local function opts(desc)
      return { desc = "nvim-tree" .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true}
    end

    api.config.mappings.default_on_attach(bufnr)

    -- Explorer dir/file
    vim.keymap.set('n', 'O', api.tree.change_root_to_node, opts('cd'))
    vim.keymap.set('n', 'U', api.tree.change_root_to_parent, opts('Up'))
    vim.keymap.set('n', 'gp', change_root_to_project_root, opts('Project Root'))

    -- Modify file
    vim.keymap.set('n', 'y', api.fs.copy.node, opts('Copy'))

    -- Move tab
    vim.keymap.set("n", "<TAB>", "<CMD>tabnext<CR>", opts('Next tab'))
    vim.keymap.set("n", "<S-TAB>", "<CMD>tabprevious<CR>", opts('Previous tab'))
  end,
  diagnostics = {
    enable = true,
    show_on_dirs = true,
  },
}
