--require'nvim-treesitter.configs'.setup {
--    ensure_installed = { "c", "rust", "go", "python", "css", "dockerfile", "git_config","gitignore","devicetree", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "make", "matlab", "regex", "sql", "typescript", "zig"  },
--    sync_install = false,
--
--    highlight = {
--        enable = true,
--        additional_vim_regex_highlighting = false,
--    },
--}
--

-- Enable Tree-sitter highlighting
--
require("nvim-treesitter").install({
  "c", "rust", "go", "python", "css", "dockerfile",
  "git_config", "gitignore", "devicetree",
  "lua", "vim", "vimdoc", "query",
  "markdown", "markdown_inline",
  "make", "matlab", "regex", "sql",
  "typescript", "zig"
})
vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    -- disable regex highlighting
    vim.bo[args.buf].syntax = "off"

    -- start treesitter
    pcall(vim.treesitter.start, args.buf)
  end,
})
