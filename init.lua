--[[

 TODO: codecompanion

--]]

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = false
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

-- vim: ts=2 sts=2 sw=2 et
