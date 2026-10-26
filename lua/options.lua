-- Leader keys must be set before lazy.nvim loads any plugin mappings
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.guicursor = ""
vim.opt.colorcolumn = "80"
vim.opt.scrolloff = 8
vim.opt.cursorline = true
vim.opt.signcolumn = "yes"
vim.opt.listchars = "tab:| ,lead:·,trail:·"
vim.opt.title = true
vim.opt.titlelen = 0
vim.opt.titlestring = 'Nvim (%{expand("%:p")})'
vim.opt.pumheight = 8
vim.opt.shortmess:append("c")

vim.opt.swapfile = false
vim.opt.autowrite = true

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Indentation: use 2 spaces for tabs
vim.opt.smartindent = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.shiftround = true
vim.opt.expandtab = true

-- Floating windows are solid: blending muddies text over a transparent
-- background. Borders are set per window rather than with 'winborder',
-- which also frames plenary's border windows and doubles Telescope's.
vim.opt.pumblend = 0
vim.opt.winblend = 0

vim.diagnostic.config({
  -- Inline diagnostics are drawn by tiny-inline-diagnostic.nvim
  virtual_text = false,
  update_in_insert = true,
  float = { border = "rounded" },
})
