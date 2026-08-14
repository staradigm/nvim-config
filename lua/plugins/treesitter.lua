-- Treesitter: syntax highlighting, incremental selection, text objects.
return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    main = "nvim-treesitter.configs",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      ensure_installed = {
        "lua", "vim", "vimdoc", "python", "bash", "c", "rust", "go",
        "javascript", "typescript", "tsx", "json", "yaml", "toml", "markdown",
      },
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
          },
        },
      },
    },
  },
}