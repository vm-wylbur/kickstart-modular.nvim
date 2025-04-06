--[[

 TODO:
- [ ] add template for comment block
- [ ] python help!!
- [ ] rainbow parens
- [x] add grep Neovim files to <leader>s
- [-] add snippets for comment block w `gc` to comment in ft appropriate way

--]]

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true
vim.loader.enable()

require 'lazy-bootstrap'
require 'lazy-plugins'
--
require 'options'
require 'keymaps'
require 'autocmd'
--
-- -- [[ weird plugins that need attention ]]
require('leap').create_default_mappings()
--
local lspconfig = require 'lspconfig'
lspconfig.pyright.setup {}

-- chatgpt from here

local telescope = require 'telescope'
local fb_actions = telescope.extensions.file_browser.actions

telescope.setup {
  extensions = {
    file_browser = {
      -- Your existing file_browser configuration here
    },
  },
}

-- Load the file_browser extension
local telescope = require 'telescope'
local actions = require 'telescope.actions'
local action_state = require 'telescope.actions.state'

-- Function to insert file contents
local function insert_file_contents(prompt_bufnr)
  local selection = action_state.get_selected_entry(prompt_bufnr)
  actions.close(prompt_bufnr)

  if selection then
    local file_path = selection.path
    local file_contents = vim.fn.readfile(file_path)
    vim.api.nvim_put(file_contents, 'l', true, true)
  end
end

-- Function to open file browser at specific path and insert contents
function _G.open_file_browser_and_insert(path)
  telescope.extensions.file_browser.file_browser {
    path = path,
    cwd = path,
    hidden = true,
    attach_mappings = function(_, map)
      map('i', '<CR>', insert_file_contents)
      map('n', '<CR>', insert_file_contents)
      return true
    end,
  }
end

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'python',
  callback = function()
    -- vim.opt_local.keywordprg = ':help' -- Use Neovim's built-in help
    -- OR use pydoc for external Python documentation
    vim.opt_local.keywordprg = 'pydoc'
  end,
})

-- Remove trailing whitespace on save
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*',
  callback = function()
    if vim.bo.filetype == 'markdown' then
      return
    end
    local cursor_pos = vim.api.nvim_win_get_cursor(0)
    vim.cmd [[%s/\s\+$//e]]
    vim.api.nvim_win_set_cursor(0, cursor_pos)
  end,
})

-- from DeepSeek
-- Read modeline when the file is opened
vim.api.nvim_create_autocmd('BufRead', {
  pattern = '*',
  callback = function()
    vim.b.insert_log = false
    local lines = vim.api.nvim_buf_get_lines(0, 0, 10, false)
    for _, line in ipairs(lines) do
      if line:match '%s+vimlogger:%s*insert_log=true' then
        vim.b.insert_log = true
        break
      end
    end
    print('assigned insert_log: ' .. v.b.insert_log)
  end,
})

-- Store the buffer size before entering insert mode
vim.api.nvim_create_autocmd('InsertEnter', {
  pattern = '*',
  callback = function()
    if vim.b.insert_log then
      vim.b.pre_insert_size = vim.fn.line2byte(vim.fn.line '$' + 1) - 1
    end
  end,
})

-- Calculate bytes inserted and write to log file after exiting insert mode
vim.api.nvim_create_autocmd('InsertLeave', {
  pattern = '*',
  callback = function()
    if vim.b.insert_log then
      local post_insert_size = vim.fn.line2byte(vim.fn.line '$' + 1) - 1
      local bytes_inserted = post_insert_size - (vim.b.pre_insert_size or 0)

      -- Write log line
      local log_file = vim.fn.expand '%:p' .. '.log'
      local log_message = os.date '%Y-%m-%dT%H:%M:%S' .. '\t' .. bytes_inserted .. '\n'
      local file = io.open(log_file, 'a')
      if file then
        file:write(log_message)
        file:close()
      else
        print('Error: Could not open log file: ' .. log_file)
      end
    end
  end,
})
-- --^ from DeepSeek

vim.keymap.set('n', 'k', function()
  return vim.v.count == 0 and 'gk' or 'k'
end, { expr = true })

vim.keymap.set('n', 'j', function()
  return vim.v.count == 0 and 'gj' or 'j'
end, { expr = true })
-- doesn't work
-- vim.api.nvim_set_keymap('n', '<leader>fi', ":lua open_file_browser_and_insert(vim.fn.expand('%:p:h'))<CR>", { noremap = true, silent = true })

--
-- vim: ts=2 sts=2 sw=2 et
