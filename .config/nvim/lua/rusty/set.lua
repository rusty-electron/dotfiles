vim.opt.guicursor = ""

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

-- vim.opt.wrap = false

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.colorcolumn = "80"
vim.g.mapleader = " "

vim.opt.clipboard = 'unnamedplus'
vim.opt.cursorline = true

-- disable netrw
-- Oil can fully replace netrw for local and ssh file browsing/editing, but keep in mind that netrw also supports rsync, http, ftp, and dav.
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1
