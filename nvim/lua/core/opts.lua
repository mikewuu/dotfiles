-- Tabs
vim.o.tabstop = 2 -- num spaces
vim.o.expandtab = true -- insert spaces instead of TAB
vim.o.softtabstop = 2 -- num spaces
vim.o.shiftwidth = 2 -- Number of spaces inserted when indenting

--equal split
vim.o.equalalways = false
vim.api.nvim_create_autocmd({ 'VimResized', 'WinEnter', 'WinLeave' }, {
  callback = function()
    vim.cmd 'wincmd ='
  end,
})

vim.filetype.add { pattern = {
  ['.env.*'] = 'sh',
} }

--- Add Laravel blade.php file type
vim.filetype.add {
  pattern = {
    ['.*%.blade%.php'] = 'blade',
  },
}
