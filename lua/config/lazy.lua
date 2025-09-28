local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.o.termguicolors = true
vim.wo.number = true
vim.opt.guicursor = ""
vim.opt.colorcolumn = "80"
vim.opt.incsearch = true
vim.opt.smartindent = true
vim.opt.scrolloff = 8
vim.opt.relativenumber = true
vim.opt.listchars = "tab:| ,lead:·,trail:·"
vim.opt.title = true
vim.opt.titlelen = 0
vim.opt.titlestring = 'Nvim (%{expand("%:p")})'
vim.o.pumheight = 8
vim.opt.swapfile = false
-- vim.diagnostic.config({ virtual_lines = { only_current_line = true } })
vim.diagnostic.config({
  -- virtual_text = {
  --   source = "if_many",
  --   prefix = "",
  -- },
  virtual_text = false,
  update_in_insert = true,
})
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = "yes"
vim.opt.shortmess:append("c")

vim.opt.backspace = "2"
vim.opt.showcmd = true
vim.opt.laststatus = 2
vim.opt.autowrite = true
vim.opt.cursorline = true

-- use spaces for tabs --
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.shiftround = true
vim.opt.expandtab = true

-- Opacity of floating windows
vim.opt.pumblend = 10
vim.opt.winblend = 10

local plugins
if vim.g.vscode then
  plugins = "plugins_vscode"
else
  plugins = "plugins_nvim"
end

require("lazy").setup({
  spec = {
    { import = plugins, },
  },
  checker = { enabled = true, notify = false },
  defaults = {
    lazy = true
  },

  ui = {
    size = {
      width = 1, height = 1
    }
  }
})

require("mappings")


if vim.g.vscode then
  require("vscode_status")
else
  require("lspsetup")
  require("autocommands")
end
