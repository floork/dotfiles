local opt = vim.opt

-- opt.guicursor = ""
opt.cursorline = true

opt.relativenumber = true
opt.number = true

opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true
opt.autoindent = true
opt.list = true
opt.lcs = "space:·"

opt.wrap = false

opt.ignorecase = true
opt.smartcase = true
-- opt.hlsearch = false
opt.incsearch = true

opt.termguicolors = true
opt.signcolumn = "yes"

opt.backspace = "indent,eol,start"

opt.splitright = true
opt.splitbelow = true

opt.swapfile = false
opt.backup = false
opt.undofile = true

opt.updatetime = 50

-- opt.colorcolumn = "80"

opt.scrolloff = 8

opt.clipboard:append("unnamedplus") -- use system clipboard as default register
