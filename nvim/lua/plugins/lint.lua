return {

  { -- Linting
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local lint = require 'lint'
      local linters_by_ft = lint.linters_by_ft

      linters_by_ft['javascript'] = { 'eslint_d' }
      linters_by_ft['typescript'] = { 'eslint_d' }
      linters_by_ft['typescriptreact'] = { 'eslint_d' }
      linters_by_ft['markdown'] = nil
      linters_by_ft['terraform'] = { 'tflint' }
      linters_by_ft['go'] = { 'golangcilint' }
      linters_by_ft['swift'] = { 'swiftlint' }

      vim.api.nvim_create_user_command('EslintDebug', function()
        local ft = vim.bo.filetype
        local current_linters = lint.linters_by_ft[ft] or {}
        local is_eslint = vim.tbl_contains(current_linters, 'eslint_d')

        print('Current filetype: ' .. ft)
        print('Linters: ' .. vim.inspect(current_linters))

        if is_eslint then
          local eslint_config = vim.fn.findfile('eslint.config.js', '.;')
          print('ESLint config found: ' .. (eslint_config ~= '' and eslint_config or 'None'))
          print('ESLint args: ' .. vim.inspect(lint.linters.eslint_d.args or 'Default args'))
        end
      end, {})

      -- To allow other plugins to add linters to require('lint').linters_by_ft,
      -- instead set linters_by_ft like this:
      -- lint.linters_by_ft = lint.linters_by_ft or {}
      -- lint.linters_by_ft['markdown'] = { 'markdownlint' }
      --
      -- However, note that this will enable a set of default linters,
      -- which will cause errors unless these tools are available:
      -- {
      --   clojure = { "clj-kondo" },
      --   dockerfile = { "hadolint" },
      --   inko = { "inko" },
      --   janet = { "janet" },
      --   json = { "jsonlint" },
      --   markdown = { "vale" },
      --   rst = { "vale" },
      --   ruby = { "ruby" },
      --   terraform = { "tflint" },
      --   text = { "vale" }
      -- }
      --
      -- You can disable the default linters by setting their filetypes to nil:
      -- lint.linters_by_ft['clojure'] = nil
      -- lint.linters_by_ft['dockerfile'] = nil
      -- lint.linters_by_ft['inko'] = nil
      -- lint.linters_by_ft['janet'] = nil
      -- lint.linters_by_ft['json'] = nil
      -- lint.linters_by_ft['markdown'] = nil
      -- lint.linters_by_ft['rst'] = nil
      -- lint.linters_by_ft['ruby'] = nil
      -- lint.linters_by_ft['terraform'] = nil
      -- lint.linters_by_ft['text'] = nil

      -- Create autocommand which carries out the actual linting
      -- on the specified events.
      local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
        group = lint_augroup,
        callback = function()
          -- Only run the linter in buffers that you can modify in order to
          -- avoid superfluous noise, notably within the handy LSP pop-ups that
          -- describe the hovered symbol using Markdown.
          if vim.opt_local.modifiable:get() then
            -- Dynamically update eslint_d args to set the nearest config filetype
            -- if one is found so that eslint works in monorepo projects
            local ft = vim.bo.filetype
            local current_linters = lint.linters_by_ft[ft] or {}
            local is_eslint = vim.tbl_contains(current_linters, 'eslint_d')
            if is_eslint then
              -- Try to find eslint config in project root
              local eslint_config = vim.fn.findfile('eslint.config.js', '.;')

              if eslint_config ~= '' then
                lint.linters.eslint_d.args = {
                  '--config',
                  eslint_config,
                  '--format',
                  'json',
                  '--stdin',
                  '--stdin-filename',
                  function()
                    return vim.api.nvim_buf_get_name(0) -- current file name
                  end,
                }
              end
            end

            lint.try_lint(nil, {
              -- Ignore errors such as missing eslint configs
              ignore_errors = true,
            })
          end
        end,
      })
    end,
  },
}
