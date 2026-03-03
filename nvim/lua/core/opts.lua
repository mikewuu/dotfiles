vim.g.have_nerd_font = true

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Mouse
vim.opt.mouse = 'a'

-- Don't show mode (statusline handles it)
vim.opt.showmode = false

-- Indentation
vim.o.tabstop = 2
vim.o.expandtab = true
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.opt.breakindent = true

-- Persistent undo
vim.opt.undofile = true

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.inccommand = 'split'

-- UI
vim.opt.signcolumn = 'yes'
vim.opt.cursorline = true
vim.opt.scrolloff = 10
vim.opt.pumheight = 10
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.list = false

-- Timing
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

-- Folding (nvim-ufo)
vim.o.foldcolumn = '1'
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true

-- Keep splits equal size
vim.o.equalalways = false

-- Treat .env.* files as shell
vim.filetype.add { pattern = { ['.env.*'] = 'sh' } }
