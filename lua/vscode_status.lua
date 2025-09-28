vim.api.nvim_create_autocmd("ModeChanged", {
    pattern = "*",
    callback = function()
        local mode = vim.api.nvim_get_mode().mode
        if mode == "i" then
            require('vscode').action("neovim-ui-indicator.insert")
        elseif mode == "v" then
            require('vscode').action("neovim-ui-indicator.visual")
        elseif mode == "n" then
            require('vscode').action("neovim-ui-indicator.normal")
        end
    end,
})


vim.keymap.set({ "n", "x" }, "<C-u>", function()
    local visibleRanges = require('vscode').eval("return vscode.window.activeTextEditor.visibleRanges")
    local height = visibleRanges[1][2].line - visibleRanges[1][1].line
    for i = 1, height * 2 / 3 do
        vim.api.nvim_feedkeys("k", "n", false)
    end
    require('vscode').action("neovim-ui-indicator.cursorCenter")
end)
vim.keymap.set({ "n", "x" }, "<C-d>", function()
    local visibleRanges = require('vscode').eval("return vscode.window.activeTextEditor.visibleRanges")
    local height = visibleRanges[1][2].line - visibleRanges[1][1].line
    for i = 1, height * 2 / 3 do
        vim.api.nvim_feedkeys("j", "n", false)
    end
    require('vscode').action("neovim-ui-indicator.cursorCenter")
end)
vim.keymap.set({ "n", "x" }, "<C-f>", function()
    local visibleRanges = require('vscode').eval("return vscode.window.activeTextEditor.visibleRanges")
    local height = visibleRanges[1][2].line - visibleRanges[1][1].line
    for i = 1, height do
        vim.api.nvim_feedkeys("j", "n", false)
    end
    require('vscode').action("neovim-ui-indicator.cursorCenter")
end)
vim.keymap.set({ "n", "x" }, "<C-b>", function()
    local visibleRanges = require('vscode').eval("return vscode.window.activeTextEditor.visibleRanges")
    local height = visibleRanges[1][2].line - visibleRanges[1][1].line
    for i = 1, height do
        vim.api.nvim_feedkeys("k", "n", false)
    end
    require('vscode').action("neovim-ui-indicator.cursorCenter")
end)
