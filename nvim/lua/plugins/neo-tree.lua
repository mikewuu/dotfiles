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
        visible = false,
        hide_dotfiles = false,
        hide_gitignored = true,
        hide_by_name = {
          'node_modules',
          'vendor',
          '.git',
        },
        never_show = {
          '.DS_Store',
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
  },
}