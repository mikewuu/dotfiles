-- Context bar to show the current function. Similar to what VSCode has at the top.
-- Using this over nvim-treesitter-context because it takes up less space, and
-- only shows the function name, not the entire signature.
return {
  'utilyre/barbecue.nvim',
  name = 'barbecue',
  version = '*',
  dependencies = {
    'SmiteshP/nvim-navic',
    'nvim-tree/nvim-web-devicons', -- optional dependency
  },
  opts = {
    -- configurations go here
  },
}
