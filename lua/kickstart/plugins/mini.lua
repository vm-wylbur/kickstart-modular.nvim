return {
  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }
      require('mini.files').setup()
      -- require('mini.statusline').setup {
      --   content = {
      --     active = function()
      --       local mode, mode_hl = MiniStatusline.section_mode { trunc_width = 120 }
      --       local diagnostics = MiniStatusline.section_diagnostics { trunc_width = 75 }
      --       local filename = MiniStatusline.section_filename { trunc_width = 1000 }
      --       local fileinfo = MiniStatusline.section_fileinfo { trunc_width = 1000 }
      --       local location = MiniStatusline.section_location { trunc_width = 10 }
      --       local lsp = MiniStatusline.section_lsp { trunc_width = 75 }
      --       return MiniStatusline.combine_groups {
      --         { hl = mode_hl, strings = { mode } },
      --         { hl = 'MiniStatuslineDevinfo', strings = { diagnostics, lsp } },
      --         '%<',
      --         { hl = 'MiniStatuslineFilename', strings = { filename } },
      --         '%=',
      --         { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
      --         { hl = mode_hl, strings = { location } },
      --       }
      --     end,
      --   },
      --   set_vim_settings = false,
      -- }
      -- -- ... and there is more!
      --  Check out: https://github.com/echasnovski/mini.nvim
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
