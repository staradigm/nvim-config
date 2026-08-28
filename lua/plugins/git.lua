-- Git integration: lazygit in a floating terminal, plus fugitive as fallback.
return {
  {
    "kdheepak/lazygit.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = "LazyGit",
    keys = {
      { "<leader>gg", "<cmd>LazyGit<CR>", desc = "open lazygit" },
      { "<leader>gb", "<cmd>LazyGitFilter<CR>", desc = "lazygit current buffer" },
    },
    config = function()
      require("lazygit").setup({
        floating_window_winblend = 0,
        floating_window_scaling_factor = 0.95,
        use_custom_config_file_path = false,
      })
    end,
  },
}