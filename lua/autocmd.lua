--
-- .wrap is the key variable here.
vim.api.nvim_create_autocmd('BufWinEnter', {
  pattern = '*.md',
  callback = function()
    vim.opt_local.linebreak = true
    vim.opt_local.wrap = true
    vim.opt_local.textwidth = 0
    vim.opt_local.spell = true
    vim.opt_local.spelllang = 'en_us'
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'markdown',
  callback = function()
    vim.bo.makeprg = 'pandoc -f markdown -t pdf -o %:r.pdf % --pdf-engine=xelatex -V geometry:"margin=1in" -V fontsize=11pt'
  end,
})

function async_make()
  local makeprg = vim.bo.makeprg
  if not makeprg then
    return
  end

  local cmd = vim.fn.expandcmd(makeprg)
  local job_id = vim.fn.jobstart(cmd, {
    on_exit = function(_, exit_code)
      if exit_code == 0 then
        print 'Build successful'
      else
        print 'Build failed'
      end
    end,
    stdout_buffered = true,
    stderr_buffered = true,
  })
end

vim.api.nvim_create_user_command('AsyncMake', async_make, {})
-- vim: ts=2 sts=2 sw=2 et
