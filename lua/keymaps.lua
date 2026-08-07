-- Sensible default keymaps. Leader is <Space>.

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Better defaults
map("n", "<Esc>", "<cmd>nohlsearch<CR>", opts) -- clear search highlight
map("n", "j", "gj", opts)
map("n", "k", "gk", opts)
map("n", "<C-d>", "<C-d>zz", opts)
map("n", "<C-u>", "<C-u>zz", opts)
map("n", "n", "nzzzv", opts)
map("n", "N", "Nzzzv", opts)
map("x", "<leader>p", [["_dP]], opts) -- paste without yanking the deleted text
map({ "n", "v" }, "<leader>y", [["+y]], opts) -- yank to system clipboard
map("n", "<leader>Y", [["+Y]], opts)

-- Buffers & windows
map("n", "<leader>w", "<cmd>w<CR>", opts)
map("n", "<leader>q", "<cmd>q<CR>", opts)
map("n", "<leader>x", "<cmd>bdelete<CR>", opts)
map("n", "<leader>|", "<cmd>vsplit<CR>", opts)
map("n", "<leader>-", "<cmd>split<CR>", opts)
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)

-- Move lines (normal + visual + insert)
map("n", "<A-j>", "<cmd>m .+1<CR>==", opts)
map("n", "<A-k>", "<cmd>m .-2<CR>==", opts)
map("v", "<A-j>", ":m '>+1<CR>gv=gv", opts)
map("v", "<A-k>", ":m '<-2<CR>gv=gv", opts)
map("i", "<A-j>", "<Esc><cmd>m .+1<CR>==gi", opts)
map("i", "<A-k>", "<Esc><cmd>m .-2<CR>==gi", opts)

-- Quickfix / diagnostics navigation
map("n", "[q", "<cmd>cprev<CR>zz", opts)
map("n", "]q", "<cmd>cnext<CR>zz", opts)
map("n", "[d", vim.diagnostic.goto_prev, opts)
map("n", "]d", vim.diagnostic.goto_next, opts)

-- Terminal
map("t", "<Esc>", "<C-\\><C-n>", opts)
map("n", "<leader>t", "<cmd>split | terminal<CR>", opts)

-- LSP fallback (overridden by lsp.lua when servers attach)
map("n", "gd", vim.lsp.buf.definition, opts)
map("n", "K", vim.lsp.buf.hover, opts)
map("n", "<leader>rn", vim.lsp.buf.rename, opts)