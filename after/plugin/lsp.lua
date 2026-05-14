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

local function extend_unique(list, values)
    list = list or {}
    for _, value in ipairs(values) do
        if not vim.list_contains(list, value) then
            table.insert(list, value)
        end
    end
    return list
end

local on_attach = function(_, bufnr)
    local bufmap = function(keys, func)
        vim.keymap.set('n', keys, func, { buffer = bufnr })
    end

    bufmap('<leader>r', vim.lsp.buf.rename)
    bufmap('<leader>a', vim.lsp.buf.code_action)

    bufmap('gd', vim.lsp.buf.definition)
    bufmap('gD', vim.lsp.buf.declaration)
    bufmap('gI', vim.lsp.buf.implementation)
    bufmap('<leader>D', vim.lsp.buf.type_definition)

    bufmap('<leader>vd', vim.diagnostic.open_float)
    bufmap('[d', function()
        vim.diagnostic.jump({ count = -1, float = true })
    end)
    bufmap(']d', function()
        vim.diagnostic.jump({ count = 1, float = true })
    end)

    bufmap('gr', require('telescope.builtin').lsp_references)
    bufmap('<leader>s', require('telescope.builtin').lsp_document_symbols)
    bufmap('<leader>S', require('telescope.builtin').lsp_dynamic_workspace_symbols)

    bufmap('<leader>f', vim.lsp.buf.format)
    bufmap('K', function()
        vim.lsp.buf.hover({ border = border })
    end)

    if vim.lsp.inlay_hint then
        bufmap('<leader>H', function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }), { bufnr = bufnr })
        end)
        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    end

    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        vim.lsp.buf.format()
    end, {})
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

require("mason").setup()
require("mason-lspconfig").setup()

vim.lsp.config("*", {
    on_attach = on_attach,
    capabilities = capabilities,
})

vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            diagnostics = {
                globals = {
                    "hl",
                },
            },
            workspace = {
                checkThirdParty = false,
                library = extend_unique({}, {
                    "/usr/share/hypr/stubs",
                }),
            },
            telemetry = { enable = false },
        },
    },
})

vim.lsp.config("clangd", {
    cmd = { "clangd", "--offset-encoding=utf-16", "--clang-tidy" },
})
