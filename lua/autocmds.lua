-- Autocommands: formatting, filetype tweaks, and editor behavior.

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local User = augroup("UserAutocmds", { clear = true })

-- Trim trailing whitespace on save for most files.
autocmd("BufWritePre", {
  group = User,
  pattern = { "*.py", "*.lua", "*.ts", "*.tsx", "*.js", "*.rs", "*.go", "*.c", "*.h", "*.sh", "*.toml", "*.yml", "*.yaml", "*.json" },
  command = "silent! %s/\\s\\+$//e",
})

-- Return to the last edit position when reopening a file.
autocmd("BufReadPost", {
  group = User,
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Better default folding for python (indent-based) and markdown (by heading).
autocmd("FileType", {
  group = User,
  pattern = { "python", "markdown", "yaml", "toml" },
  command = "setlocal foldmethod=indent foldlevel=99",
})

-- Two-space indent for web languages.
autocmd("FileType", {
  group = User,
  pattern = { "javascript", "typescript", "typescriptreact", "javascriptreact", "json", "html", "css", "lua", "sh" },
  command = "setlocal tabstop=2 shiftwidth=2 softtabstop=2",
})

-- Spell-check prose.
autocmd("FileType", {
  group = User,
  pattern = { "markdown", "text", "gitcommit" },
  command = "setlocal spell spelllang=en_us",
})

-- Highlight on yank (temporary).
autocmd("TextYankPost", {
  group = User,
  callback = function()
    vim.hl.on_yank({ timeout = 200 })
  end,
})