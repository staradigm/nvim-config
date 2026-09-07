-- CI smoke test: assert the config loads and key pieces are wired up.
-- Run with: nvim --headless "+luafile lua/verify.lua" +qa
-- (config is loaded first because the checkout is linked into XDG_CONFIG_HOME)

local ok, errors = true, {}

local function expect(cond, msg, actual)
  if not cond then
    ok = false
    errors[#errors + 1] = msg .. (actual ~= nil and (" (got " .. tostring(actual) .. ")") or "")
  end
end

expect(vim.g.mapleader == " ", "leader key is not set to <Space>", vim.g.mapleader)
expect(vim.o.number, "line numbers are not enabled", vim.o.number)
expect(vim.o.relativenumber, "relative line numbers are not enabled", vim.o.relativenumber)
expect(vim.o.termguicolors, "termguicolors is not enabled", vim.o.termguicolors)

local function loaded(name)
  return pcall(require, name)
end

expect(loaded("lazy"), "lazy.nvim failed to load")
expect(loaded("nvim-treesitter"), "nvim-treesitter failed to load")
expect(loaded("telescope"), "telescope failed to load")
expect(loaded("lualine"), "lualine failed to load")
expect(loaded("gitsigns"), "gitsigns failed to load")
expect(loaded("bufferline"), "bufferline failed to load")
expect(loaded("nvim-tree"), "nvim-tree failed to load")
expect(loaded("which-key"), "which-key failed to load")
expect(loaded("cmp"), "nvim-cmp failed to load")
expect(loaded("gruvbox"), "gruvbox failed to load")

if not ok then
  for _, msg in ipairs(errors) do
    print("FAIL: " .. msg)
  end
  vim.cmd("cq") -- exit non-zero
end

print("OK: nvim-config loads cleanly — " .. #errors .. " checks failed")
vim.cmd("qa")