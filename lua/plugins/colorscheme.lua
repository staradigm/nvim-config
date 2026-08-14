-- gruvbox with Material-style overrides, loaded on first colorscheme request.
return {
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    lazy = false,
    config = function()
      require("gruvbox").setup({
        terminal_colors = true,
        contrast = "hard",
        transparent_mode = false,
        overrides = {
          SignColumn = { bg = "#282828" },
          NormalFloat = { bg = "#282828" },
        },
      })
      vim.cmd.colorscheme("gruvbox")
    end,
  },
}