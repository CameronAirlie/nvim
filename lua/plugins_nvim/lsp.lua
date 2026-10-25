return {
-- Auto Completion
 {
   'saghen/blink.cmp',
   -- Must load before any language server starts so its completion
   -- capabilities are registered (blink lazy-loads its internals itself)
   lazy = false,
   -- optional: provides snippets for the snippet source
   dependencies = {
     'rafamadriz/friendly-snippets',
     'fang2hou/blink-copilot',
   },

   -- use a release tag to download pre-built binaries
   version = '1.*',
   -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
   -- build = 'cargo build --release',
   -- If you use nix, you can build from source using latest nightly rust with:
   -- build = 'nix run .#build-plugin',

   ---@module 'blink.cmp'
   ---@type blink.cmp.Config
   opts = {
     -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
     -- 'super-tab' for mappings similar to vscode (tab to accept)
     -- 'enter' for enter to accept
     -- 'none' for no mappings
     --
     -- All presets have the following mappings:
     -- C-space: Open menu or open docs if already open
     -- C-n/C-p or Up/Down: Select next/previous item
     -- C-e: Hide menu
     -- C-k: Toggle signature help (if signature.enabled = true)
     --
     -- See :h blink-cmp-config-keymap for defining your own keymap
     keymap = {
       preset = 'default',
       ['<C-n>'] = {
         'show',
         'select_next',
         'fallback'
       },
       ['<C-l>'] = {
         'show_documentation',
         'hide_documentation'
       }
     },

     appearance = {
       -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
       -- Adjusts spacing to ensure icons are aligned
       nerd_font_variant = 'mono'
     },

     -- (Default) Only show the documentation popup when manually triggered
     completion = {
       documentation = {
         auto_show = true,
         window = {
           border = 'rounded',
           winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:BlinkCmpMenuSelection,Search:None",
           winblend = 10
         }
       },
       menu = {
         winblend = 10,
         border = 'rounded',
         winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:BlinkCmpMenuSelection,Search:None"
       },
     },
     signature = {
       enabled = true,
       window = {
         border = 'rounded',
         winblend = 10,
         winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:BlinkCmpMenuSelection,Search:None"
       }
     },

     -- Default list of enabled providers defined so that you can extend it
     -- elsewhere in your config, without redefining it, due to `opts_extend`
     sources = {
       default = { 'lsp', 'path', 'snippets', 'buffer', 'copilot' },
       providers = {
         copilot = {
           name = "copilot",
           module = "blink-copilot",
           score_offset = 100,
           async = true,
         },
       },
     },

     -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
     -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
     -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
     --
     -- See the fuzzy documentation for more information
     fuzzy = { implementation = "prefer_rust_with_warning" }
   },
   opts_extend = { "sources.default" }
 },

   {
     'neovim/nvim-lspconfig',
     -- Only provides server configs (lsp/*.lua) for vim.lsp.enable(), which
     -- must be on the runtimepath before any server starts
     lazy = false,
     dependencies = { 'saghen/blink.cmp' },
     config = function(_, opts)
     end
   },

   { 'williamboman/mason.nvim' },
   { 'williamboman/mason-lspconfig.nvim' },
   {
     "pmizio/typescript-tools.nvim",
     dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
     opts = {},
     ft = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
   },

   -- Formatting
   {
     "stevearc/conform.nvim",
     event = "BufWritePre",
     cmd = "ConformInfo",
     keys = {
       {
         "<F3>",
         function() require("conform").format({ async = true }) end,
         mode = { "n", "x" },
         desc = "Format buffer",
       },
     },
     ---@module "conform"
     ---@type conform.setupOpts
     opts = {
       -- Formatters that aren't installed are skipped. When none of a
       -- filetype's formatters are available, LSP formatting is used instead.
       formatters_by_ft = {
         lua = { "stylua" },
         go = { "goimports", "gofmt", stop_after_first = true },
         python = { "ruff_format" },
         c = { "clang-format" },
         cpp = { "clang-format" },
         cs = { "csharpier" },
         javascript = { "prettierd", "prettier", stop_after_first = true },
         javascriptreact = { "prettierd", "prettier", stop_after_first = true },
         typescript = { "prettierd", "prettier", stop_after_first = true },
         typescriptreact = { "prettierd", "prettier", stop_after_first = true },
         css = { "prettierd", "prettier", stop_after_first = true },
         scss = { "prettierd", "prettier", stop_after_first = true },
         html = { "prettierd", "prettier", stop_after_first = true },
         json = { "prettierd", "prettier", stop_after_first = true },
         yaml = { "prettierd", "prettier", stop_after_first = true },
       },
       default_format_opts = {
         lsp_format = "fallback",
       },
       format_on_save = {
         timeout_ms = 10000,
       },
     },
   },

   {
     "zbirenbaum/copilot.lua",
     event = "InsertEnter",
     opts = {
       suggestion = {
         enabled = false,
         auto_trigger = true,
       },
       panel = {
         enabled = false
       }
     },
   },

   {
     'nvim-treesitter/nvim-treesitter',
     branch = 'main',
     lazy = false,
     build = ":TSUpdate",
     config = function()
       local parsers = {
         "bash",
         "c",
         "cpp",
         "css",
         "dockerfile",
         "go",
         "graphql",
         "html",
         "javascript",
         "json",
         "lua",
         "python",
         "rust",
         "scss",
         "typescript",
         "tsx",
         "yaml",
         "toml",
       }

       require('nvim-treesitter').install(parsers)

       -- Parser names don't always match filetypes (tsx -> typescriptreact,
       -- bash -> sh), so start highlighting for any buffer whose filetype
       -- has an installed parser instead of matching on parser names.
       vim.api.nvim_create_autocmd('FileType', {
         callback = function(args)
           pcall(vim.treesitter.start, args.buf)
         end,
       })
     end,
   },

   {
     "rachartier/tiny-inline-diagnostic.nvim",
     event = "LspAttach",
     priority = 1000,
     config = function()
       require('tiny-inline-diagnostic').setup({
         preset = "simple",
         options = {
           -- enable_on_insert = true,
           throttle = 10,
         },
         blend = {
           factor = 0.5,
         }
       })
       -- vim.diagnostic.config({ virtual_text = false }) -- Only if needed in your configuration, if you already have native LSP diagnostics
     end
   },
   {
     "rachartier/tiny-code-action.nvim",
     dependencies = {
       { "nvim-lua/plenary.nvim" },
       { "nvim-telescope/telescope.nvim" },
     },
     event = "LspAttach",
     config = function()
       require('tiny-code-action').setup()
     end
   },
}
