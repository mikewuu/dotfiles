-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  cmd = 'Neotree',
  keys = {
    { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
  },
  opts = {
    filesystem = {
      filtered_items = {
        visible = true,
        never_show = {
          '.DS_Store',
          '.git',
          '.changeset',
          '.vscode',
        },
        always_show = {
          '.gitignore',
        },
        always_show_by_pattern = {
          '.env',
          '.env.*',
        },
      },
      window = {
        mappings = {
          ['\\'] = 'close_window',
          ['/'] = 'noop',
        },
      },
    },
    event_handlers = {
      {
        event = "neo_tree_window_after_open",
        handler = function(_) vim.cmd("wincmd =") end
      },
      {
        event = "neo_tree_window_after_close",
        handler = function(_) vim.cmd("wincmd =") end
      },
    },
  },
}
