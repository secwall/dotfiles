local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smarttab = true
vim.opt.expandtab = true
vim.opt.wrap = true
vim.opt.showbreak = "      >"
vim.opt.ai = true
vim.opt.cin = true
vim.opt.backspace = "indent,eol,start"
vim.opt.wrapmargin = 5
vim.opt.laststatus = 2
vim.opt.foldenable = true
vim.opt.foldmethod = "indent"
vim.opt.showmatch = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.listchars = "tab:.."
vim.opt.list = true
vim.opt.background = "dark"
vim.opt.termguicolors = true
vim.opt.colorcolumn = "80"
vim.opt.number = true

vim.g.mapleader = " "

require("lazy").setup("plugins")
