require("options")
require("config.lazy")
require("mappings")

if vim.g.vscode then
  require("vscode_status")
else
  require("lspsetup")
  require("autocommands")
end
