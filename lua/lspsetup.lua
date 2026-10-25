-- blink.cmp registers its completion capabilities for every server through
-- vim.lsp.config('*') on its own, so no capabilities setup is needed here.

require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = { 'lua_ls', 'gopls', 'tailwindcss', 'html', 'cssls', 'jsonls', },
  -- mason-lspconfig v2 calls vim.lsp.enable() for every installed server.
  -- typescript-tools.nvim already provides the TypeScript server, so keep
  -- ts_ls from attaching a second one to the same buffers.
  automatic_enable = {
    exclude = { 'ts_ls' },
  },
})


-- This is where you enable features that only work
-- if there is a language server active in the file
vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(event)
    local function map(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = event.buf, desc = desc })
    end

    map('n', 'K', vim.lsp.buf.hover, 'LSP: Hover')
    map('n', 'gd', vim.lsp.buf.definition, 'LSP: Go to definition')
    map('n', 'gD', vim.lsp.buf.declaration, 'LSP: Go to declaration')
    map('n', 'gi', vim.lsp.buf.implementation, 'LSP: Go to implementation')
    map('n', 'go', vim.lsp.buf.type_definition, 'LSP: Go to type definition')
    map('n', 'gl', vim.diagnostic.open_float, 'LSP: Line diagnostics')
    map('n', '<leader>gs', vim.lsp.buf.signature_help, 'LSP: Signature help')
    map('n', '<F2>', vim.lsp.buf.rename, 'LSP: Rename')

    -- References use Neovim's built-in grr (alongside grn rename, gri
    -- implementation, grt type definition, gO document symbols). gra is
    -- remapped so it uses the same code action UI as ga.
    local code_action = function() require('tiny-code-action').code_action() end
    map('n', 'ga', code_action, 'LSP: Code action')
    map('n', 'gra', code_action, 'LSP: Code action')
  end,
})

-- ~/.config/nvim/lua/config/clangd.lua

vim.lsp.config("clangd", {
  cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    -- CMake projects commonly keep their compilation database out of tree.
    -- The path is relative to clangd's project working directory.
    "--compile-commands-dir=out",
  },
  root_markers = {
    ".clangd",
    "compile_commands.json",
    "compile_flags.txt",
    ".git",
  },
  filetypes = {
    "c",
    "cpp",
    "objc",
    "objcpp",
    "cuda",
  },
})

vim.lsp.enable("clangd")

vim.filetype.add(
  {
    extension = {
      rml = "html",
      rcss = "css",
      -- Avalonia / WPF markup
      axaml = "xml",
      xaml = "xml",
    },
  }
)
