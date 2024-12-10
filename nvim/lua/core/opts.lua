vim.filetype.add { pattern = {
  ['.env.*'] = 'sh',
} }

--- Add Laravel blade.php file type
vim.filetype.add {
  pattern = {
    ['.*%.blade%.php'] = 'blade',
  },
}
