-- Tabs
vim.o.tabstop = 2 -- num spaces
vim.o.expandtab = true -- insert spaces instead of TAB
vim.o.softtabstop = 2 -- num spaces
vim.o.shiftwidth = 2 -- Number of spaces inserted when indenting

vim.filetype.add { pattern = {
  ['.env.*'] = 'sh',
} }

--- Add Laravel blade.php file type
vim.filetype.add {
  pattern = {
    ['.*%.blade%.php'] = 'blade',
  },
}
