return {

  {
    "nvim-telescope/telescope.nvim",
    opts = {
      defautls = {
        file_ignore_patterns = { ".git/", "node_modules/" },
        file_includes = {
          ".env",
        },
      },
    },
    keys = {
      { "<space>ff", "<cmd>Telescope find_files<cr>", desc = "Telescope find files" },
      { "<space>fg", "<cmd>Telescope live_grep<cr>",  desc = "Telescope live grep" },
      { "<space>.",  "<cmd>Telescope oldfiles<cr>",   desc = "Telescope old files" },
      { "<space>fh", "<cmd>Telescope help_tags<cr>",  desc = "Telescope help tags" },

    },
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  -- Buffer-Style File Browser
  {
    'stevearc/oil.nvim',
    lazy = false,
    opts = {
      default_file_explorer = true,
      columns = {
        "icon",
        "size"
      },
      view_options = {
        show_hidden = true,
      },
    },
    keys = {
      { "<leader>ef", "<cmd>Oil<cr>" },
    },
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },

  {
    "SmiteshP/nvim-navbuddy",
    dependencies = {
      "SmiteshP/nvim-navic",
      "MunifTanjim/nui.nvim",
    },
  },
}
