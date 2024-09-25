local actions = require('telescope.actions')
local builtin = require('telescope.builtin')
local entry_display = require('telescope.pickers.entry_display')
local path = require('plenary.path')
local themes = require('telescope.themes')
local theme = themes.get_dropdown

local function send_to_quickfix(promtbufnr)
  actions.smart_send_to_qflist(promtbufnr)
  vim.cmd([[botright copen]])
end

require('telescope').setup({
  defaults = {
    path_display = { 'truncate' },
    mappings = {
      i = {
        ['<esc>'] = actions.close,
        ['<C-j>'] = actions.move_selection_next,
        ['<C-k>'] = actions.move_selection_previous,
        ['<C-q>'] = send_to_quickfix,
      },
    },
  },
})

local function telescope_builtin(fn, opts)
  return function()
    builtin[fn](theme(opts))
  end
end

-- Custom function for ignoring android and ios folders, and including hidden files
local function find_files_ignore_android_ios()
  builtin.find_files(theme({
    find_command = {
      'rg',
      '--files',
      '--hidden',
      '--iglob',
      '!apps/mobile/android/**',
      '--iglob',
      '!apps/mobile/ios/**',
      '--iglob',
      '!.git/**',
    },
  }))
end

-- Helper function to find the nearest parent directory containing a package.json file
local function find_nearest_project_json_dir(start_dir)
  local current_dir = path:new(start_dir)

  while current_dir ~= nil do
    local project_json_path = current_dir:joinpath('project.json')
    if project_json_path:exists() then
      return current_dir
    end
    local parent_dir = current_dir:parent()

    if parent_dir:absolute() == current_dir:absolute() then
      current_dir = nil
    else
      current_dir = parent_dir
    end
  end

  return nil
end

-- Custom function for searching files within the current package
local function find_files_in_current_package()
  local current_file_dir = vim.fn.expand('%:p:h')
  local package_root = find_nearest_project_json_dir(current_file_dir)

  if package_root == nil then
    print('No package found up the tree.')
    return
  end

  local split_path = vim.split(package_root.filename, '/')
  local package_name = split_path[#split_path]

  print(package_name)

  builtin.find_files(theme({
    cwd = package_root.filename,
    prompt_title = 'Files in ' .. package_name,
  }))
end

local function find_git_repo_root(starting_path)
  local current_path = path:new(starting_path)
  local git_path = current_path:joinpath('.git')

  while not git_path:exists() do
    local parent_path = current_path:parent()
    if not parent_path or parent_path.filename == current_path.filename then
      return nil
    end
    current_path = parent_path
    git_path = current_path:joinpath('.git')
  end

  return current_path
end

local function find_packages()
  local current_file_dir = vim.fn.expand('%:p:h')
  local repo_root = find_git_repo_root(current_file_dir)

  if repo_root == nil then
    print('Git repository root not found.')
    return
  end

  local displayer = entry_display.create({
    separator = ' ',
    items = { { width = 50 } },
  })

  local function make_display(entry)
    local package_name = vim.fn.fnamemodify(entry.value, ':h:t')
    return displayer({ package_name })
  end

  builtin.find_files(theme({
    prompt_title = 'Find Packages',
    cwd = repo_root.filename,
    find_command = {
      'rg',
      '--files',
      '--hidden',
      '--iglob',
      'libs/**/project.json',
      '--iglob',
      'apps/**/project.json',
    },
    entry_maker = function(entry, opts)
      local original_maker = require('telescope.make_entry').gen_from_file(opts)
      local original_entry = original_maker(entry)
      original_entry.display = make_display
      return original_entry
    end,
  }))
end

vim.keymap.set('n', '<leader>fa', telescope_builtin('find_files', { hidden = true }), {})
vim.keymap.set('n', '<leader>ff', find_files_ignore_android_ios, {})
vim.keymap.set('n', '<leader>ss', telescope_builtin('lsp_document_symbols'), {})
vim.keymap.set('n', '<leader>sa', telescope_builtin('lsp_workspace_symbols'), {})
vim.keymap.set('n', '<leader>gb', telescope_builtin('git_branches'), {})
vim.keymap.set('n', '<leader>gs', telescope_builtin('git_status'), {})
vim.keymap.set('n', '<leader>gh', telescope_builtin('git_bcommits'), {})

vim.keymap.set(
  'n',
  '<Esc>',
  telescope_builtin(
    'buffers',
    { sort_lastused = true, sort_mru = true, ignore_current_buffer = true, show_all_buffers = false }
  ),
  {}
)

vim.keymap.set('n', '<leader>pd', telescope_builtin('diagnostics', { severity = 'error' }), {})

vim.keymap.set('n', '<leader>ps', function()
  local input = vim.fn.input('Search in repo > ')

  if input == '' then
    return
  end

  builtin.grep_string({ search = input })
end, {})

vim.keymap.set('n', '<leader>ls', function()
  local current_file_dir = vim.fn.expand('%:p:h')
  local package_root = find_nearest_project_json_dir(current_file_dir)

  if package_root == nil then
    return
  end

  local input = vim.fn.input('Search in package > ')

  if input == '' then
    return
  end

  builtin.grep_string({ search = input, cwd = package_root.filename })
end, {})

vim.keymap.set('n', '<leader>ll', find_packages)
vim.keymap.set('n', '<leader>fl', find_files_in_current_package)
