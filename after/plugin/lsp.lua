local cmp = require('cmp')
local luasnip = require('luasnip')

local border = {
    { "╭", "FloatBorder" },
    { "─", "FloatBorder" },
    { "╮", "FloatBorder" },
    { "│", "FloatBorder" },
    { "╯", "FloatBorder" },
    { "─", "FloatBorder" },
    { "╰", "FloatBorder" },
    { "│", "FloatBorder" },
}

local handlers = {
    ["textDocument/hover"] = vim.lsp.buf.hover({ border = "rounded" }),
    --["textDocument/hover"] = vim.lsp.buf.with(vim.lsp.buf.handlers.hover, { border = border }),
    --["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
    ["textDocument/signatureHelp"] = vim.lsp.buf.signature_help,
    { border = border },
    --["textDocument/signatureHelp"] = vim.lsp.buf.with(vim.lsp.buf.handlers.signature_help, { border = border }),
}

local on_attach = function(_, bufnr)
    local bufmap = function(keys, func)
        --vim.keymap.set('n', keys, func, { buffer = bufnr })
    end

    bufmap('<leader>r', vim.lsp.buf.rename)
    bufmap('<leader>a', vim.lsp.buf.code_action)

    bufmap('gd', vim.lsp.buf.definition)
    bufmap('gD', vim.lsp.buf.declaration)
    bufmap('gI', vim.lsp.buf.implementation)
    bufmap('<leader>D', vim.lsp.buf.type_definition)

    bufmap('<leader>vd', vim.diagnostic.open_float)
    --bufmap('[d', vim.diagnostic.goto_next)
    bufmap('[d', vim.diagnostic.jump({ count = 1, float = true }))
    --bufmap(']d', vim.diagnostic.goto_prev)
    bufmap(']d', vim.diagnostic.jump({ count = -1, float = true }))

    bufmap('gr', require('telescope.builtin').lsp_references)
    bufmap('<leader>s', require('telescope.builtin').lsp_document_symbols)
    bufmap('<leader>S', require('telescope.builtin').lsp_dynamic_workspace_symbols)

    bufmap('<leader>f', vim.lsp.buf.format)
    bufmap('K', vim.lsp.buf.hover({border = "rounded"}))

    if vim.lsp.inlay_hint then
        bufmap('<leader>H', vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()))
        vim.lsp.inlay_hint.enable(true)
    end

    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        vim.lsp.buf.format()
    end, {})
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- mason
require("mason").setup()
require("mason-lspconfig").setup_handlers({

    function(server_name)
        require("lspconfig")[server_name].setup {
            on_attach = on_attach,
            capabilities = capabilities
        }
    end,

    ["lua_ls"] = function()
        require('neodev').setup()
        require('lspconfig').lua_ls.setup {
            on_attach = on_attach,
            capabilities = capabilities,
            handlers = handlers,
            settings = {
                Lua = {
                    workspace = { checkThirdParty = false },
                    telemetry = { enable = false },
                },
            }
        }
    end,

    ["clangd"] = function()
        require('lspconfig').clangd.setup {
            on_attach = on_attach,
            capabilities = capabilities,
            handlers = handlers,
            cmd = { "clangd", "--offset-encoding=utf-16", "--clang-tidy" }
        }
    end,

    ["gopls"] = function()
        require('lspconfig').gopls.setup {
            on_attach = on_attach,
            capabilities = capabilities,
            handlers = handlers
        }
    end,

    ["cssls"] = function()
        require('lspconfig').cssls.setup {
            on_attach = on_attach,
            capabilities = capabilities,
            handlers = handlers
        }
    end,

    ["rust_analyzer"] = function()
        require('lspconfig').rust_analyzer.setup {
            on_attach = on_attach,
            capabilities = capabilities,
            handlers = handlers,
        }
    end,

    ["jsonls"] = function()
        require('lspconfig').jsonls.setup {
            on_attach = on_attach,
            capabilities = capabilities,
            handlers = handlers
        }
    end,

    ["html"] = function()
        require('lspconfig').html.setup {
            on_attach = on_attach,
            capabilities = capabilities,
            handlers = handlers
        }
    end,
})


--
--
---- initialize rust_analyzer with rust-tools
---- see :help lsp-zero.build_options()
--local rust_lsp = lsp.build_options('rust_analyzer', {
--    single_file_support = false,
--    on_attach = function(client, bufnr)
--        local opts = { buffer = bufnr, remap = false }
--        -- open cargo.toml
--        vim.keymap.set("n", "<leader>oc", function() require('rust-tools.open_cargo_toml').open_cargo_toml() end, opts)
--        -- hover actions
--        vim.keymap.set("n", "<leader>ha", function() require('rust-tools.hover_actions').hover_actions() end, opts)
--        -- format on save
--        vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]]
--
--
--    end
--})
--
--require('rust-tools').setup({
--    -- disable LSP semantic highlighting
--    server = {
--        on_attach = function(client,bufnr)
--            client.server_capabilities.semanticTokensProvider = nil
--            -- repeat the default on_attach
--            local opts = { buffer = bufnr, remap = false }
--            vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
--            vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
--            vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
--            vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
--            vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
--            vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
--            vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
--            vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
--            vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
--            vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
--        end,
--    },
--    settings = {
--        ["rust-analyzer"] = {
--            assist = {
--                importEnforceGranularity = true,
--                importPrefix = 'crate',
--            },
--            cargo = {
--                allFeatures = true,
--            },
--            -- enable clippy on save
--            checkOnSave = {
--                command = "clippy",
--                overrideCommand = {'cargo','clippy', '--workspace', '--message-format=json',
--                    '--all-features'
--                }
--            },
--        }
--    },
--    tools = {
--        executor = require("rust-tools/executors").termopen,
--        on_initialized = nil,
--        reload_workspace_from_cargo_toml = true,
--
--        autoSetHints = true,
--        runnables = {
--            use_telescope = true
--        },
--        inlay_hints = {
--            show_parameter_hints   = true,
--            parameter_hints_prefix = "<- ",
--            other_hints_prefix     = "=> ",
--        },
--        hover_actions = {
--            border = {
--                { "╭", "FloatBorder" },
--                { "─", "FloatBorder" },
--                { "╮", "FloatBorder" },
--                { "│", "FloatBorder" },
--                { "╯", "FloatBorder" },
--                { "─", "FloatBorder" },
--                { "╰", "FloatBorder" },
--                { "│", "FloatBorder" },
--            },
--            auto_focus = true,
--        }
--    },
--})
