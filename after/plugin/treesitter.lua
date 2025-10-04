require'nvim-treesitter.configs'.setup {
    ensure_installed = { "c", "rust", "go", "python", "css", "dockerfile", "git_config","gitignore","devicetree", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "make", "matlab", "regex", "sql", "typescript", "zig"  },
    sync_install = false,

    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
}

