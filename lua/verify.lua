-- CI smoke test: assert the config loads and key pieces are wired up.
-- Run with: nvim --headless -u init.lua -l lua/verify.lua

local ok, errors = true, {}

local function expect(cond, msg)
  if not cond then
    ok = false
    errors[#errors + 1] = msg
  end
end

expect(vim.g.mapleader == " ", "leader key is not set to <Space>")
expect(vim.opt.number.value == true, "line numbers are not enabled")
expect(vim.opt.termguicolors.value == true, "termguicolors is not enabled")

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
    vim.notify(msg, vim.log.levels.ERROR)
    print("FAIL: " .. msg)
  end
  vim.cmd("cq") -- exit non-zero
end

print("OK: nvim-config loads cleanly — " .. vim.fn.len(errors) .. " checks passed")
vim.cmd("qa")