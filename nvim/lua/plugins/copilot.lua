return {
  dir = '/Users/mike/Code/copilot.lua',
  cmd = 'Copilot',
  config = function()
    require('copilot').setup {
      panel = {
        enabled = false,
      },
      suggestion = {
        enabled = true,
        auto_trigger = true,
        hide_during_completion = false,
        debounce = 75,
        keymap = {
          accept = '<tab>',
          accept_word = false,
          accept_line = false,
          next = '<M-n>',
          prev = '<M-p>',
          dismiss = '<C-]>',
        },
      },
    }
  end,
}
