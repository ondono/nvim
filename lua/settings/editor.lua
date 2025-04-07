
-- basic vim settings

-- Enable relative line numbers
vim.opt.nu = true
vim.opt.relativenumber = true
-- Always keep 8 lines above and below cursor
vim.opt.scrolloff = 8
-- Enable the sign column for showing errors and markers
vim.opt.signcolumn = "yes"

-- disable error bell
vim.opt.errorbells = false

-- tabstuff
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

-- no wrapping at the end of the window please
vim.opt.wrap = false

-- no more annoying .vim in ~
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.cache/nvim/undodir"
vim.opt.undofile = true

-- searching (I prefer highligthing Prime)
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- colors 
vim.opt.termguicolors = true
---- set colorscheme according to base16
local colorscheme = "base16-" .. os.getenv("BASE16_THEME")
local _,_ = pcall(vim.cmd, "colorscheme " .. colorscheme)

vim.cmd [[
    highlight Normal guibg=none
    highlight NonText guibg=none
    highlight Normal ctermbg=none
    highlight NonText ctermbg=none
]]

-- allow vim to open filenames with @
vim.opt.isfname:append("@-@")

-- Give more space for displaying messages.
vim.opt.cmdheight = 1

-- Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
-- delays and poor user experience.
vim.opt.updatetime = 50

-- Don't pass messages to |ins-completion-menu|.
vim.opt.shortmess:append("c")

-- Add a line on column 80 for reference
vim.opt.colorcolumn = "80"
