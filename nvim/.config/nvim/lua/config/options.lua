vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.o.number = true
vim.o.undofile = true
vim.o.relativenumber = true
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

vim.o.signcolumn = 'yes'
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.updatetime = 250
vim.o.timeoutlen = 500
vim.o.breakindent = true
vim.o.inccommand = 'split'
vim.o.cursorline = true
vim.o.scrolloff = 10
vim.o.confirm = true
vim.o.list = true

vim.opt.signcolumn = 'yes'
vim.opt.colorcolumn = '150'
vim.opt.listchars = 'trail:-,nbsp:+,tab:▏ ,lead:·'
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.undolevels = 10000
vim.opt.mouse = 'a'
vim.opt.conceallevel = 1
vim.opt.ignorecase = true
vim.opt.wildmode = 'longest:full,full'
vim.opt.wrap = false
vim.opt.termguicolors = true
vim.opt.fillchars = {
  foldopen = '',
  foldclose = '',
  fold = ' ',
  foldsep = ' ',
  diff = '╱',
  eob = ' ',
}

-- neovide config
if vim.g.neovide then
  vim.g.guifont = 'Cascadia Code NF:h9'
  vim.g.neovide_scale_factor = 0.8
end

-- rest config
-- vim.opt.rocks.enabled = false
-- vim.opt.rocks.hererocks = true
