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
      { "<leader>hs", "<cmd>lua require'gitsigns'.stage_hunk()<CR>", desc = "Stage hunk" },
      { "<leader>hS", "<cmd>lua require'gitsigns'.stage_buffer()<CR>", desc = "Stage buffer" },
      { "<leader>hu", "<cmd>lua require'gitsigns'.undo_stage_hunk()<CR>", desc = "Undo stage hunk" },
      { "<leader>hr", "<cmd>lua require'gitsigns'.reset_hunk()<CR>", desc = "Reset hunk" },
      { "<leader>hR", "<cmd>lua require'gitsigns'.reset_buffer()<CR>", desc = "Reset buffer" },
      { "<leader>hp", "<cmd>lua require'gitsigns'.preview_hunk()<CR>", desc = "Preview hunk" },
      -- Fall back to the built-in ]c/[c when in diff mode
      {
        "]c",
        function()
          if vim.wo.diff then return vim.cmd.normal({ "]c", bang = true }) end
          require("gitsigns").nav_hunk("next")
        end,
        desc = "Next hunk",
      },
      {
        "[c",
        function()
          if vim.wo.diff then return vim.cmd.normal({ "[c", bang = true }) end
          require("gitsigns").nav_hunk("prev")
        end,
        desc = "Previous hunk",
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
      { "<leader>eg", "<cmd>Neogit<CR>", desc = "Neogit" },
    },
    opts = {
      kind = "replace"
    },
  },
}
