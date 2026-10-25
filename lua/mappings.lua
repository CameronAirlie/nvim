-- Unfocus terminal with a double <Esc>, so a single <Esc> still reaches
-- programs running inside it (lazygit, fzf, etc.)
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>")

-- Center view after jumping
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Yank to system clipboard with leader key
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y')
vim.keymap.set({ "n", "v" }, "<leader>p", '"+p')

vim.keymap.set("n", "<leader><leader>", "<C-^>", { noremap = true })

-- Clears highlighting after search (keeps <CR> working in quickfix and
-- other special buffers, where it opens the entry under the cursor)
vim.keymap.set("n", "<CR>", function()
  if vim.bo.buftype ~= "" then
    return "<CR>"
  end
  return "<cmd>nohlsearch<CR>"
end, { expr = true, silent = true })

-- Center view after search
vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")

-- Open new buffer
vim.keymap.set("n", '<leader>n', ":enew<CR>")
