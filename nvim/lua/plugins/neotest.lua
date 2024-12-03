return {
  'nvim-neotest/neotest',
  lazy = true,
  dependencies = {
    'nvim-neotest/nvim-nio',
    'olimorris/neotest-phpunit',
    'nvim-neotest/neotest-jest',
  },
  config = function()
    require('neotest').setup {
      adapters = {
        require 'neotest-phpunit',
        require 'neotest-jest' {
          jestCommand = 'npm test --',
          cwd = function()
            return vim.fn.getcwd()
          end,
        },
      },
    }
  end,
}
