return {
  -- Vim Git Wrapper
  { "tpope/vim-fugitive", },

  -- Git tree
  { "rbong/vim-flog", },

  -- Show hunks in files
  {
    "lewis6991/gitsigns.nvim",
    cmd = "Gitsigns",
    event = "BufReadPre",
    config = function()
      require("gitsigns").setup({})
    end,
    keys = {
      { "<leader>hs", "<cmd>lua require'gitsigns'.stage_hunk()<CR>" },
      { "<leader>hS", "<cmd>lua require'gitsigns'.stage_buffer()<CR>" },
      { "<leader>hu", "<cmd>lua require'gitsigns'.undo_stage_hunk()<CR>" },
      { "<leader>hr", "<cmd>lua require'gitsigns'.reset_hunk()<CR>" },
      { "<leader>hR", "<cmd>lua require'gitsigns'.reset_buffer()<CR>" },
      { "<leader>hp", "<cmd>lua require'gitsigns'.preview_hunk()<CR>" },
      -- Fall back to the built-in ]c/[c when in diff mode
      {
        "]c",
        function()
          if vim.wo.diff then return vim.cmd.normal({ "]c", bang = true }) end
          require("gitsigns").nav_hunk("next")
        end,
      },
      {
        "[c",
        function()
          if vim.wo.diff then return vim.cmd.normal({ "[c", bang = true }) end
          require("gitsigns").nav_hunk("prev")
        end,
      },
    },
  },


  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",

      "nvim-telescope/telescope.nvim",
    },
    keys = {
      { "<leader>eg", "<cmd>Neogit<CR>" },
    },
    opts = {
      kind = "replace"
    },
  },
}
