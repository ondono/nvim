local treesitter = require("nvim-treesitter")

treesitter.setup({})

treesitter.install({
    "c", "rust", "go", "python", "css", "dockerfile",
    "git_config", "gitignore", "devicetree",
    "lua", "vim", "vimdoc", "query",
    "markdown", "markdown_inline",
    "make", "matlab", "regex", "sql",
    "typescript", "zig",
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = {
        "c", "rust", "go", "python", "css", "dockerfile",
        "gitconfig", "gitignore", "devicetree",
        "lua", "vim", "help", "query",
        "markdown", "make", "matlab", "regex", "sql",
        "typescript", "zig",
    },
    callback = function()
        pcall(vim.treesitter.start)
    end,
})
