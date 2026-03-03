-- Highlight yanked text briefly
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Keep splits equal on resize
vim.api.nvim_create_autocmd({ 'VimResized', 'WinEnter', 'WinLeave' }, {
  callback = function()
    vim.cmd 'wincmd ='
  end,
})
