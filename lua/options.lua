-- Editor-wide options. Loaded before plugins so every plugin sees them.

local opt = vim.opt

-- Line handling
opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes"
opt.cursorline = true
opt.scrolloff = 8
opt.sidescrolloff = 5

-- Indentation (4-wide, expand tabs for most languages)
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true
opt.wrap = false

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- Split behavior
opt.splitright = true
opt.splitbelow = true

-- Files & encoding
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"
opt.swapfile = false
opt.backup = false
opt.undofile = true
opt.undodir = vim.fn.stdpath("state") .. "/undo"
vim.fn.mkdir(opt.undodir.value, "p")

-- Appearance
opt.termguicolors = true
opt.showmode = false
opt.laststatus = 3 -- global statusline (lualine)
opt.pumheight = 10
opt.completeopt = "menu,menuone,noselect"
opt.list = true
opt.listchars = { tab = "» ", trail = "·", extends = "›", precedes = "‹" }

-- Clipboard & mouse
opt.clipboard = "unnamedplus"
opt.mouse = "a"

-- Performance
opt.updatetime = 250
opt.timeoutlen = 400
opt.redrawtime = 1500

-- Set leader early so plugins and keymaps can rely on it.
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Language server servers managed by Mason (see lua/plugins/lsp.lua)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1