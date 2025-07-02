-- Pretty print a variable to see
-- the entire shape, and not just
-- the type & reference.
function P(variable)
  print(vim.inspect(variable))
end

-- Grep with glob that allows for searching grep only in files that match a certain glob pattern, eg: search inside *.test.ts
-- Example usage:
-- :GG *.test.ts

function GrepWithGlob(glob_pattern)
  local telescope = require 'telescope.builtin'
  telescope.live_grep {
    additional_args = function()
      return { '--glob', glob_pattern }
    end,
  }
end

vim.api.nvim_create_user_command('GG', function(opts)
  GrepWithGlob(opts.args)
end, {
  nargs = 1,
  complete = 'file', -- optional
})
