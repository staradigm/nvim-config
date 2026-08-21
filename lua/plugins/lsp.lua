-- LSP: Mason for server installs, lspconfig for wiring, with sensible
-- diagnostics and keymaps wired once a server attaches.

local function on_attach(_, bufnr)
  local map = function(keys, fn, desc)
    vim.keymap.set("n", keys, fn, { buffer = bufnr, desc = desc })
  end
  map("gd", vim.lsp.buf.definition, "go to definition")
  map("gr", vim.lsp.buf.references, "references")
  map("K", vim.lsp.buf.hover, "hover")
  map("<leader>rn", vim.lsp.buf.rename, "rename")
  map("<leader>ca", vim.lsp.buf.code_action, "code action")
  map("<leader>f", function()
    vim.lsp.buf.format({ async = true })
  end, "format buffer")

  vim.api.nvim_buf_create_user_command(bufnr, "Format", function()
    vim.lsp.buf.format({ async = true })
  end, { desc = "Format buffer with LSP" })
end

return {
  -- Server binaries
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    cmd = "Mason",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "pyright", "ts_ls", "rust_analyzer" },
        automatic_enable = true,
      })
    end,
  },

  -- Wire-up
  {
    "neovim/nvim-lspconfig",
    dependencies = { "williamboman/mason-lspconfig.nvim" },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = vim.lsp.protocol.make_client_capabilities()

      local servers = {
        lua_ls = { settings = { Lua = { workspace = { checkThirdParty = false }, telemetry = { enable = false } } } },
        pyright = {},
        ts_ls = {},
        rust_analyzer = {},
      }

      for name, opts in pairs(servers) do
        local ok = pcall(lspconfig[name].setup, {
          capabilities = capabilities,
          on_attach = on_attach,
          settings = opts.settings or {},
        })
        if not ok then
          vim.schedule(function()
            vim.notify("lspconfig: '" .. name .. "' not available", vim.log.levels.WARN)
          end)
        end
      end

      -- Diagnostics UX
      vim.diagnostic.config({
        virtual_text = { prefix = "●" },
        signs = true,
        update_in_insert = false,
        float = { border = "rounded", source = true },
      })
    end,
  },

  -- Autocompletion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
    },
    event = "InsertEnter",
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-y>"] = cmp.mapping.confirm({ select = true }),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "path" },
        }, {
          { name = "buffer" },
        }),
      })
    end,
  },
}