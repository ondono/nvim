-- leader was mapped on editor settings

-- do some magic to do lua based keymaps
local Remap = require("settings.remap")
local nnoremap = Remap.nnoremap
local vnoremap = Remap.vnoremap
local inoremap = Remap.inoremap
local xnoremap = Remap.xnoremap
local nmap = Remap.nmap

-- reload config
nnoremap("<leader><CR>", ":so %<CR>")
-- lua dependencies won't load properly, find a fix

nnoremap("<leader>w", ":w<CR>")

-- move through quickfix lists
--nnoremap("<C-j>",":cnext<CR>")
--nnoremap("<C-k>",":cprev<CR>")

-- move through splits
nnoremap("<C-J>", "<C-W><C-J>")
nnoremap("<C-K>", "<C-W><C-K>")
nnoremap("<C-L>", "<C-W><C-L>")
nnoremap("<C-H>", "<C-W><C-H>")

-- remove seach highlight
nnoremap("<leader>h", ":nohls<CR>")

-- remember the one eyed kirby when searching
-- \(.*\)

-- yank to clipboard
vnoremap("<leader>y", "\"+y")
nnoremap("<leader>y", "\"+y")
-- copy whole file to clipboard
nnoremap("<leader>Y", "gg\"+yG")

-- put without overwriting register
nnoremap("<leader>p", "\"0p")

-- Y to yank from cursor to end of line
nnoremap("Y", "yg$")
-- J to join lines
nnoremap("J", "mzJ`z")

-- move blocks around with J and K (and reindent if needed)
vnoremap("J", ":m '>+1<CR>gv=gv")
vnoremap("K", ":m '<-2<CR>gv=gv")

-- I can type help too!
nmap("<F1>", "<Esc>")
inoremap("<F1>", "<Esc>")

-- disable arrow keys
nnoremap("<Up>", "<Nop>")
nnoremap("<Down>", "<Nop>")
inoremap("<Up>", "<Nop>")
inoremap("<Down>", "<Nop>")

-- move buffers
--nnoremap("<leader>n",":bn<CR>")
--nnoremap("<leader>p",":bp<CR>")

-- move buffers with arrow keys too
nnoremap("<Right>", ":bn<CR>")
nnoremap("<Left>", ":bp<CR>")

-- <leader><leader> to toggle between buffers
nnoremap("<leader><leader>", ":b#<CR>")

-- <leader>, to show/hide hidden characters
nnoremap("<leader>,", ":set invlist<CR>")

-- <leader>f to flash
nnoremap("<leader>t", ":make flash<CR>")

--vim.g.clipboard = {
--    name = "wl-copy",
--    copy = {
--        ["+"] = { "wl-copy", "--type", "text/plain" },
--        ["*"] = { "wl-copy", "--primary", "--type", "text/plain" },
--    },
--    paste = {
--        ["+"] = { "wl-paste", "--no-newline" },
--        ["*"] = { "wl-paste", "--no-newline", "--primary" },
--    },
--}
