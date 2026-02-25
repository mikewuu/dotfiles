local treesitter = { -- Highlight, edit, and navigate code
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  branch = 'main',
  -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
  opts = {
    ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc', 'php', 'dockerfile', 'swift', 'typescript', 'javascript', 'go' },
    -- Autoinstall languages that are not installed
    auto_install = true,
  },
}

local treesitter_modules = {
  'MeanderingProgrammer/treesitter-modules.nvim',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  opts = {
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = { 'ruby' },
    },
    indent = { enable = true, disable = { 'ruby' } },
    incremental_selection = { enable = true },
  },
  config = function(_, opts)
    local ts = require 'treesitter-modules'
    ts.setup(opts)
    local keymap = vim.keymap.set ---@diagnostic disable-line: undefined-global
    keymap('x', 'v', ts.node_incremental, { desc = 'Expand selection' })
    keymap('x', 'V', ts.node_decremental, { desc = 'Shrink selection' })
  end,
}

return { treesitter, treesitter_modules }
