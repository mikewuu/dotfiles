-- Automatically reload current plugin
vim.keymap.set('n', '<leader>bb', function()
  local current_file = vim.fn.expand '%:p'
  local plugin_dir = vim.fn.fnamemodify(current_file, ':h')
  print(plugin_dir)

  -- Find the root of the plugin (looking for lua directory or plugin directory)
  while plugin_dir ~= '/' do
    if vim.fn.isdirectory(plugin_dir .. '/lua') == 1 or vim.fn.isdirectory(plugin_dir .. '/plugin') == 1 then
      break
    end
    plugin_dir = vim.fn.fnamemodify(plugin_dir, ':h')
  end

  plugin_dir = vim.fn.fnamemodify(plugin_dir, ':t')

  -- Reload the plugin
  require('lazy').reload { plugins = { plugin_dir } }
  vim.notify('Reloaded plugin: ' .. plugin_dir, vim.log.levels.INFO)
end)
