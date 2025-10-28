return {
  'wojciech-kulik/xcodebuild.nvim',
  dependencies = {
    'nvim-telescope/telescope.nvim',
    'MunifTanjim/nui.nvim',
  },
  config = function()
    local xcodebuild_dap = require 'xcodebuild.integrations.dap'
    xcodebuild_dap.setup()

    require('xcodebuild').setup {
      code_coverage = {
        enabled = true,
      },
      integrations = {
        pymobiledevice = {
          enabled = true,
        },
        neo_tree = {
          enabled = true, -- enable updating Xcode project files when using neo-tree.nvim
        },
      },
    }

    vim.keymap.set('n', '<leader>xl', '<cmd>XcodebuildToggleLogs<cr>', { desc = 'Toggle Xcodebuild Logs' })
    vim.keymap.set('n', '<leader>xb', '<cmd>XcodebuildBuild<cr>', { desc = 'Build Project' })
    vim.keymap.set('n', '<leader>xr', '<cmd>XcodebuildBuildRun<cr>', { desc = 'Build & Run Project' })
    vim.keymap.set('n', '<leader>xu', xcodebuild_dap.build_and_debug, { desc = 'Build & Debug' })
    vim.keymap.set('n', '<leader>xt', '<cmd>XcodebuildTest<cr>', { desc = 'Run Tests' })
    vim.keymap.set('n', '<leader>xT', '<cmd>XcodebuildTestClass<cr>', { desc = 'Run This Test Class' })
    vim.keymap.set('n', '<leader>X', '<cmd>XcodebuildPicker<cr>', { desc = 'Show All Xcodebuild Actions' })
    vim.keymap.set('n', '<leader>xd', '<cmd>XcodebuildSelectDevice<cr>', { desc = 'Select Device' })
    vim.keymap.set('n', '<leader>xp', '<cmd>XcodebuildSelectTestPlan<cr>', { desc = 'Select Test Plan' })
    vim.keymap.set('n', '<leader>xc', '<cmd>XcodebuildToggleCodeCoverage<cr>', { desc = 'Toggle Code Coverage' })
    vim.keymap.set('n', '<leader>xC', '<cmd>XcodebuildShowCodeCoverageReport<cr>', { desc = 'Show Code Coverage Report' })
    vim.keymap.set('n', '<leader>xq', '<cmd>Telescope quickfix<cr>', { desc = 'Show QuickFix List' })
    vim.keymap.set('n', '<leader>xn', '<cmd>XcodebuildCreateNewFile<cr>', { desc = 'Create a new file to the project' })
    vim.keymap.set('n', '<leader>xN', '<cmd>XcodebuildAddCurrentFile<cr>', { desc = 'Add the current file to project target' })
    vim.keymap.set('n', '<leader>xg', '<cmd>XcodebuildCreateNewGroup<cr>', { desc = 'Create a new folder (group) to the project target' })
    vim.keymap.set('n', '<leader>xG', '<cmd>XcodebuildAddCurrentGroup<cr>', { desc = 'Add the current folder (group) to the project target' })
  end,
}
