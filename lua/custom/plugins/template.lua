return {
  'nvimdev/template.nvim',
  cmd = { 'Template', 'TemProject' },
  config = function()
    require('template').setup {
      temp_dir = '~/.config/nvim/templates',
      author = 'Patrick Ball',
      email = 'pball@hrdag.org',
    }
  end,
}
