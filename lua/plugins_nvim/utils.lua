return {
  -- Surround Words/Text with quotes, brackets etc.
  {
    "kylechui/nvim-surround",
    version = "^3.0.0",
    event = "VeryLazy",
    opts = {},
  },


  -- Commenting (extends the built-in gc operator)
  {
    "folke/ts-comments.nvim",
    opts = {},
    event = "VeryLazy",
  },

  -- Join lines
  {
    'Wansmer/treesj',
    event = "VeryLazy",
    keys = {
      { "<leader>m", "<cmd>TSJToggle<cr>", desc = "Join Toggle" },
    },
    opts = {
      use_default_keymaps = false, max_join_length = 150 },
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
  },

  -- Startup time
  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime"
  },

  -- Auto Close Brackets
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true
  },

  -- Keymap hints
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "modern",
      spec = {
        { "<leader>d", group = "debug" },
        { "<leader>e", group = "explore" },
        { "<leader>f", group = "find" },
        { "<leader>g", group = "lsp" },
        { "<leader>h", group = "git hunks" },
      },
    },
  },
}
