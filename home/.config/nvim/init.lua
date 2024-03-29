-- Set general options
vim.opt.autochdir = true
vim.opt.breakindent = true
vim.opt.clipboard = "unnamedplus"
vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.cursorline = true
vim.opt.foldenable = false
vim.opt.linebreak = true
vim.opt.mouse = "a"
vim.opt.number = true
vim.opt.signcolumn = "yes"
vim.opt.smartcase = true
vim.opt.termguicolors = true
vim.opt.updatetime = 1000

-- Configure indentation
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.tabstop = 8

vim.api.nvim_create_autocmd("FileType", {
  pattern = "go",
  callback = function()
    vim.opt_local.expandtab = false
    vim.opt_local.tabstop = 2
  end
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "python,groovy",
  callback = function()
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 4
    vim.keymap.set("n", "<localleader>b", "<cmd>!black %<cr>", opts)
  end
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "structurizr",
  callback = function()
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 4
  end
})

-- Set leader keys
vim.g.mapleader = ","
vim.g.maplocalleader = " "

-- Bootstrap lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath
  }
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup "plugins"

-- Set keymaps
local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<leader>b", "<cmd>Buffers<cr>", opts)
vim.keymap.set("n", "<leader>f", "<cmd>FZF<cr>", opts)
vim.keymap.set("n", "<leader>g", "<cmd>GitFiles<cr>", opts)
vim.keymap.set("n", "<leader>r", "<cmd>Rg<cr>", opts)
vim.keymap.set("n", "<leader>m", "<cmd>Maps<cr>", opts)
vim.keymap.set("n", "<leader>t", "<cmd>NvimTreeFocus<cr>", opts)

