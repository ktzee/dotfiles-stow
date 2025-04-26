-- colorscheme is set up in lua/plugins/init.lua, at the time of downloading the theme

-- Import user options before installing lazy
require("options")
-- Setup lazy.nvim
require("plugins.config.lazy")
-- Import lsp-config config
require("plugins.config.lsp-config")
-- Import user keybinds after plugins are set up
require("keybinds")
