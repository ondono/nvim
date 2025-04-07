require("noice").setup({
    cmdline = {
        view = "cmdline",
    },
    messages = {
        enabled = true, -- enables the Noice messages UI
        view = "notify",
        view_error = "notify",
        view_warn = "notify",
        view_history = "messages",
        view_search = false, -- default view for search count messages
    },
    popupmenu = {
        enabled = true,  -- enables the Noice popupmenu UI
        backend = "cmp", -- backend to use for completion and path expansion
        -- backend = { "cmp", "nui" }, -- enable both cmp and nui
        kind_icons = {
            CodeAction = "",
            Diagnostic = "",
            LspCodeAction = "",
            LspDiagnostics = "",
            LspSignatureHelp = "",
            LspTypeDefinition = "",
            LspReferences = "",
            LspRename = "",
            LspFormat = "﬏",
        },
    },
    lsp = {
        hover = {
            enabled = true,
            silent = false,
            view = "hover",
            opts = {
            },
        },
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
        },
    },
    -- you can enable a preset for easier configuration
    presets = {
        bottom_search = true,         -- use a classic bottom cmdline for search
        command_palette = true,       -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false,           -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = true,        -- add a border to hover docs and signature help
    },
})
