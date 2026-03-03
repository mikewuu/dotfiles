-- Clear search highlight
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostics
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Terminal
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Window navigation (also handled by tmux.nvim for pane awareness)
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Splits
vim.keymap.set('n', '<C-t>', '<cmd>vsplit<CR>', { desc = 'Split window vertically' })

-- File operations
vim.keymap.set('n', '<C-s>', '<cmd>w<CR>', { noremap = true, silent = true, desc = 'Save file' })
vim.keymap.set('n', '<C-q>', '<cmd>q<CR>', { noremap = true, silent = true, desc = 'Quit buffer' })

-- Clipboard
vim.keymap.set('v', '<leader>y', '"+y', { noremap = true, silent = true, desc = 'Copy to system clipboard' })

-- Move lines in visual mode
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { noremap = true, silent = true, desc = 'Move line down' })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { noremap = true, silent = true, desc = 'Move line up' })

-- Reload current lazy plugin (dev helper)
vim.keymap.set('n', '<leader>bb', function()
  local current_file = vim.fn.expand '%:p'
  local plugin_dir = vim.fn.fnamemodify(current_file, ':h')

  while plugin_dir ~= '/' do
    if vim.fn.isdirectory(plugin_dir .. '/lua') == 1 or vim.fn.isdirectory(plugin_dir .. '/plugin') == 1 then
      break
    end
    plugin_dir = vim.fn.fnamemodify(plugin_dir, ':h')
  end

  plugin_dir = vim.fn.fnamemodify(plugin_dir, ':t')
  require('lazy').reload { plugins = { plugin_dir } }
  vim.notify('Reloaded plugin: ' .. plugin_dir, vim.log.levels.INFO)
end)

-- Window resize mode (tmux-style sticky)
local function enter_resize_mode()
  local resize_mode_active = true

  local resize_maps = {
    { 'h', function() vim.cmd 'vertical resize +3' end, 'Increase width' },
    { 'j', function() vim.cmd 'resize -3' end, 'Decrease height' },
    { 'k', function() vim.cmd 'resize +3' end, 'Increase height' },
    { 'l', function() vim.cmd 'vertical resize -3' end, 'Decrease width' },
    { '>', function() vim.cmd 'wincmd L' end, 'Move window right' },
    { '<', function() vim.cmd 'wincmd H' end, 'Move window left' },
    { 'q', function() resize_mode_active = false end, 'Exit resize mode' },
    { '<Esc>', function() resize_mode_active = false end, 'Exit resize mode' },
    { '<CR>', function() resize_mode_active = false end, 'Exit resize mode' },
  }

  local buf_maps = {}
  for _, map in ipairs(resize_maps) do
    local key, func, desc = map[1], map[2], map[3]
    vim.keymap.set('n', key, function()
      func()
      if not resize_mode_active then
        for _, buf_map in ipairs(buf_maps) do
          vim.keymap.del('n', buf_map)
        end
        print 'Exited resize mode'
      end
    end, { noremap = true, silent = true, desc = desc })
    table.insert(buf_maps, key)
  end

  print 'Resize mode: hjkl to resize, q/Esc/Enter to exit'
end

vim.keymap.set('n', '<C-w><C-w>', enter_resize_mode, { noremap = true, silent = true, desc = 'Enter resize mode' })
