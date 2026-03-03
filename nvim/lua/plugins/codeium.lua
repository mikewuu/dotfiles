return {
  'Exafunction/codeium.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'hrsh7th/nvim-cmp',
  },
  config = function()
    require('codeium').setup {
      enable_cmp_source = false,
      virtual_text = {
        enabled = true,
        manual = false,
        key_bindings = {
          accept = '<tab>',
          accept_word = false,
          accept_line = false,
          clear = false,
          next = '<M-n>',
          prev = '<M-p>',
        },
      },
    }

    vim.keymap.set('i', '<C-a>', function()
      require('codeium.virtual_text').complete()
    end)
  end,
}
