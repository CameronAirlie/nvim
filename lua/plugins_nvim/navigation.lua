return {

  {
    "nvim-telescope/telescope.nvim",
    opts = {
      defaults = {
        -- Lua patterns, so the dot must be escaped
        file_ignore_patterns = { "%.git/", "node_modules/" },
      },
      pickers = {
        -- Include dotfiles such as .env
        find_files = { hidden = true },
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
      { "<leader>ef", "<cmd>Oil<cr>", desc = "Oil file browser" },
    },
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },

  {
    "SmiteshP/nvim-navbuddy",
    dependencies = {
      "SmiteshP/nvim-navic",
      "MunifTanjim/nui.nvim",
    },
    -- Attach manually: navbuddy's own auto_attach calls an API deprecated in
    -- Neovim 0.12 when it loads after a client is already running.
    init = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client and client.server_capabilities.documentSymbolProvider then
            require("nvim-navbuddy").attach(client, args.buf)
          end
        end,
      })
    end,
    opts = {},
    keys = {
      { "<leader>es", "<cmd>Navbuddy<cr>", desc = "Navbuddy symbols" },
    },
  },
}
