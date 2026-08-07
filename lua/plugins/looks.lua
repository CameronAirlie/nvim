return {
  -- Colorschemes
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("kanagawa").setup({
        colors = {
          theme = {
            all = {
              ui = {
                bg_gutter = "none"
              }
            }
          }
        },
        transparent = false,
        overrides = function(colors)
          local theme = colors.theme
          return {
            NormalFloat = { bg = "none" },
            FloatBorder = { bg = "none", fg = theme.ui.bg_p2 },
            FloatTitle = { bg = "none" },
            NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },
            LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
            MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
            Pmenu = { fg = theme.ui.fg_dim, bg = theme.ui.bg, blend = vim.o.pumblend },
            PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
            PmenuSbar = { bg = theme.ui.bg_m1 },
            PmenuThumb = { bg = theme.ui.fg_dim },
          }
        end,
      })
      vim.cmd("colorscheme kanagawa")
    end,
  },

  -- Beautiful status bar
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        icons_enabled = true,
        theme = "auto",
        component_separators = '¦',
        section_separators = {
          right = '',
          left = '',
        },
      },
      sections = {
        lualine_a = {
          { 'filename', path = 1 },
        },
      },
    },
  },

  -- File icons for file explorer
  "nvim-tree/nvim-web-devicons",
  {
    "rachartier/tiny-devicons-auto-colors.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "rebelot/kanagawa.nvim"
    },
    event = "VeryLazy",
    -- config = function()
    --   require("tiny-devicons-auto-colors").setup({
    --     colors = require("kanagawa.colors").setup().palette,
    --   })
    -- end,
  },

  -- Indentation guides
  "echasnovski/mini.indentscope",
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = "VimEnter",
    opts = {
      exclude = {
        filetypes = {
          "dashboard"
        }
      }
    }
  },

  -- LSP status
  {
    "j-hui/fidget.nvim",
    event = "BufEnter",
    opts = {
      -- options
    },
  },

  {
    'nvimdev/dashboard-nvim',
    lazy = false,
    config = function()
      require('dashboard').setup {
        theme = 'hyper',
        config = {
          header = {
            [[                                                ]],
            [[                                          _.oo. ]],
            [[                  _.u[[/;:,.         .odMMMMMM' ]],
            [[               .o888UU[[[/;:-.  .o@P^    MMM^   ]],
            [[              oN88888UU[[[/;::-.        dP^     ]],
            [[             dNMMNN888UU[[[/;:--.   .o@P^       ]],
            [[            ,MMMMMMN888UU[[/;::-. o@^           ]],
            [[            NNMMMNN888UU[[[/~.o@P^              ]],
            [[            888888888UU[[[/o@^-..               ]],
            [[           oI8888UU[[[/o@P^:--..                ]],
            [[        .@^  YUU[[[/o@^;::---..                 ]],
            [[      oMP     ^/o@P^;:::---..                   ]],
            [[   .dMMM    .o@^ ^;::---...                     ]],
            [[  dMMMMMMM@^`       `^^^^                       ]],
            [[ YMMMUP^                                        ]],
            [[  ^^                                            ]],
            [[                                                ]],
          },
          project = { enable = false },
          mru = { enable = true, limit = 8 }
        }
      }
    end,
    dependencies = { { 'nvim-tree/nvim-web-devicons' } }
  }

}
