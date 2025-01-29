-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.keymap.set('n', 'gx', '<esc>:URLOpenUnderCursor<cr>')

-- NOTE: this is how which-key is set
local wk = require 'which-key'
wk.add {
  { '<leader>f', '<cmd>lua MiniFiles.open()<CR>', desc = 'File navigator' },
  { '<leader>1', '<cmd>BufferGoto 1<CR>', desc = 'Buffer nav' },
  { '<leader>2', '<cmd>BufferGoto 2<CR>', desc = 'Buffer nav' },
  { '<leader>3', '<cmd>BufferGoto 3<CR>', desc = 'Buffer nav' },
  { '<leader>4', '<cmd>BufferGoto 4<CR>', desc = 'Buffer nav' },
  { '<leader>5', '<cmd>BufferGoto 5<CR>', desc = 'Buffer nav' },
  { '<leader>b', group = 'Buffer' },
  { '<leader>bc', '<cmd>BufferClose<CR>', desc = 'Buffer close' },
}
-- bi-directional: anywhere on the screen
vim.keymap.set({ 'n', 'x' }, 's', '<Plug>(leap)')

-- vim: ts=2 sts=2 sw=2 et
