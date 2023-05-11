local Remap = require("settings.remap")
local nnoremap = Remap.nnoremap
local vnoremap = Remap.vnoremap
local inoremap = Remap.inoremap
local xnoremap = Remap.xnoremap
local nmap = Remap.nmap

-- Project View
nnoremap("<leader>pv", ":Ex<CR>")
-- Show Undo Tree
nnoremap("<leader>u", ":UndotreeShow<CR>")

-- Move cursor (page up/down)
nnoremap("<C-d>", "<C-d>zz")
nnoremap("<C-u>", "<C-u>zz")

-- Move on search (n/N)
nnoremap("n", "nzzzv")
nnoremap("N", "Nzzzv")


--nnoremap("<leader>vwm", function()
--    require("vim-with-me").StartVimWithMe()
--end)
--nnoremap("<leader>svwm", function()
--    require("vim-with-me").StopVimWithMe()
--end)

-- greatest remap ever
-- paste withtout swapping contents of the registers
xnoremap("<leader>p", "\"_dP")

-- next greatest remap ever : asbjornHaland
-- yank to system clipboard
nnoremap("<leader>y", "\"+y")
vnoremap("<leader>y", "\"+y")
-- yank to system clipboard including line ending
nmap("<leader>Y", "\"+Y")

nnoremap("<leader>d", "\"_d")
vnoremap("<leader>d", "\"_d")

vnoremap("<leader>d", "\"_d")

-- This is going to get me cancelled
inoremap("<C-c>", "<Esc>")

nnoremap("Q", "<nop>")
--nnoremap("<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
nnoremap("<leader>f", function()
    vim.lsp.buf.format()
end)

nnoremap("<C-k>", "<cmd>cnext<CR>zz")
nnoremap("<C-j>", "<cmd>cprev<CR>zz")
nnoremap("<leader>k", "<cmd>lnext<CR>zz")
nnoremap("<leader>j", "<cmd>lprev<CR>zz")

nnoremap("<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")
nnoremap("<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

nnoremap("<leader>tc", function()
    tail.reset()
    tmux.reset()
end);

