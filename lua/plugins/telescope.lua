-- Telescope: fuzzy find everything.
return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = "Telescope",
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "find files" },
      { "<leader>fg", "<cmd>Telescope live_grep<CR>", desc = "grep" },
      { "<leader>fb", "<cmd>Telescope buffers<CR>", desc = "buffers" },
      { "<leader>fh", "<cmd>Telescope help_tags<CR>", desc = "help tags" },
      { "<leader>fq", "<cmd>Telescope quickfix<CR>", desc = "quickfix list" },
      { "<leader>fs", "<cmd>Telescope lsp_document_symbols<CR>", desc = "document symbols" },
    },
    config = function()
      require("telescope").setup({
        defaults = {
          sorting_strategy = "ascending",
          layout_config = { prompt_position = "top" },
          prompt_prefix = "  ",
          borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
          file_ignore_patterns = {
            "node_modules/", ".git/", "dist/", "build/", "target/", ".venv/",
            "__pycache__/", "*.lock",
          },
        },
        pickers = {
          find_files = { hidden = true },
        },
      })
    end,
  },
}