return {
  -- Surround Words/Text with quotes, brackets etc.
  {
    "tpope/vim-surround",
    event = "BufEnter",
  },


  -- Commenting
  {
    "numToStr/Comment.nvim",
    event = "BufEnter",
    dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
  },

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
}
