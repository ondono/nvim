local Remap = require("settings.remap")
local nnoremap = Remap.nnoremap
local vnoremap = Remap.vnoremap
local inoremap = Remap.inoremap
local xnoremap = Remap.xnoremap
local nmap = Remap.nmap

-- Project View
nnoremap("<leader>pv", function()
    local ok, oil = pcall(require, "oil")
    if ok then
        oil.open()
    else
        vim.cmd.Ex()
    end
end, { desc = "Open file browser" })
-- Show Undo Tree
nnoremap("<leader>u", ":UndotreeShow<CR>", { desc = "Show undo tree" })

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

nnoremap("Q", "<nop>", { desc = "Disable Ex mode" })
--nnoremap("<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
nnoremap("<leader>f", function()
    local ok, conform = pcall(require, "conform")
    if ok then
        conform.format({ lsp_format = "fallback" })
    else
        vim.lsp.buf.format()
    end
end, { desc = "Format buffer" })

nnoremap("<C-k>", "<cmd>cnext<CR>zz")
nnoremap("<C-j>", "<cmd>cprev<CR>zz")
nnoremap("<leader>k", "<cmd>lnext<CR>zz")
nnoremap("<leader>j", "<cmd>lprev<CR>zz")

nnoremap("<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", { desc = "Substitute word" })
nnoremap("<leader>x", "<cmd>!chmod +x %<CR>", { silent = true, desc = "Make file executable" })
