-- first settings are loaded
require("settings")

-- the settings.packer section will load all plugins
-- the plugin configurations are on after/plugin, and are automatically
-- loaded after having run this script

-- rtp
-- base16 scripts
vim.opt.rtp:append(os.getenv("HOME") .. "/.config/base16-shell/scripts")
