-- UI polish: statusline, buffer tabs, icons, git signs, which-key, indent guides.
return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    config = function()
      require("lualine").setup({
        options = {
          theme = "gruvbox",
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
          globalstatus = true,
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff" },
          lualine_c = { { "filename", path = 1 } },
          lualine_x = { "diagnostics", "encoding", "fileformat" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
      })
    end,
  },

  {
    "akinsho/bufferline.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    config = function()
      require("bufferline").setup({
        options = {
          diagnostics = "nvim_lsp",
          show_buffer_close_icons = false,
          show_close_icon = false,
          separator_style = "slant",
          offsets = { { filetype = "NvimTree", text = "", highlight = "Directory", separator = true } },
        },
      })
      vim.keymap.set("n", "<leader>1", "<cmd>BufferLineGoToBuffer 1<CR>")
      vim.keymap.set("n", "<leader>2", "<cmd>BufferLineGoToBuffer 2<CR>")
      vim.keymap.set("n", "<leader>3", "<cmd>BufferLineGoToBuffer 3<CR>")
      vim.keymap.set("n", "<leader>4", "<cmd>BufferLineGoToBuffer 4<CR>")
      vim.keymap.set("n", "<leader>5", "<cmd>BufferLineGoToBuffer 5<CR>")
    end,
  },

  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("gitsigns").setup({
        signs = {
          add = { text = "│" },
          change = { text = "│" },
          delete = { text = "_" },
          topdelete = { text = "‾" },
          changedelete = { text = "~" },
        },
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns
          local map = function(keys, fn, desc)
            vim.keymap.set("n", keys, fn, { buffer = bufnr, desc = desc })
          end
          map("]h", gs.next_hunk, "next hunk")
          map("[h", gs.prev_hunk, "prev hunk")
          map("<leader>hp", gs.preview_hunk, "preview hunk")
          map("<leader>hs", gs.stage_hunk, "stage hunk")
          map("<leader>hr", gs.reset_hunk, "reset hunk")
          map("<leader>hu", gs.undo_stage_hunk, "undo stage hunk")
        end,
      })
    end,
  },

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      require("which-key").setup({
        spec = {
          { "<leader>f", group = "find" },
          { "<leader>h", group = "hunks" },
          { "<leader>w", group = "write" },
          { "<leader>q", group = "quit" },
        },
      })
    end,
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPre", "BufNewFile" },
    main = "ibl",
    opts = {
      indent = { char = "▏" },
      scope = { enabled = true },
      exclude = { filetypes = { "help", "dashboard", "NvimTree" } },
    },
  },

  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    keys = {
      { "<leader>e", "<cmd>NvimTreeToggle<CR>", desc = "toggle file tree" },
    },
    config = function()
      require("nvim-tree").setup({
        filters = { dotfiles = false },
        disable_netrw = true,
        renderer = {
          indent_markers = { enable = true },
          group_empty = true,
        },
        view = { width = 34 },
      })
    end,
  },
}