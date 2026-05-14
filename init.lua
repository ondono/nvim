-- first settings are loaded
require("settings")

-- rtp
-- base16 scripts
vim.opt.rtp:append(os.getenv("HOME") .. "/.config/base16-shell/scripts")
