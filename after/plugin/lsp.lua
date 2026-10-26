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

local function set_lsp_keymaps(bufnr)
    local bufmap = function(keys, func, desc)
        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
    end

    bufmap('<leader>r', vim.lsp.buf.rename, 'Rename symbol')
    bufmap('<leader>a', vim.lsp.buf.code_action, 'Code action')

    bufmap('gd', vim.lsp.buf.definition, 'Go to definition')
    bufmap('gD', vim.lsp.buf.declaration, 'Go to declaration')
    bufmap('gI', vim.lsp.buf.implementation, 'Go to implementation')
    bufmap('<leader>D', vim.lsp.buf.type_definition, 'Go to type definition')
    bufmap('<leader>lc', vim.lsp.buf.incoming_calls, 'Incoming calls')
    bufmap('<leader>lC', vim.lsp.buf.outgoing_calls, 'Outgoing calls')

    bufmap('<leader>vd', vim.diagnostic.open_float, 'Line diagnostics')
    bufmap('[d', function()
        vim.diagnostic.jump({ count = -1, float = true })
    end, 'Previous diagnostic')
    bufmap(']d', function()
        vim.diagnostic.jump({ count = 1, float = true })
    end, 'Next diagnostic')

    bufmap('gr', require('telescope.builtin').lsp_references, 'LSP references')
    bufmap('<leader>ls', require('telescope.builtin').lsp_document_symbols, 'Document symbols')
    bufmap('<leader>lS', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Workspace symbols')
    bufmap('<leader>ld', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', 'Buffer diagnostics')
    bufmap('<leader>lD', '<cmd>Trouble diagnostics toggle<cr>', 'Workspace diagnostics')

    bufmap('<leader>f', function()
        local ok, conform = pcall(require, 'conform')
        if ok then
            conform.format({ bufnr = bufnr, lsp_format = 'fallback' })
        else
            vim.lsp.buf.format()
        end
    end, 'Format buffer')
    bufmap('K', function()
        vim.lsp.buf.hover({ border = border })
    end, 'Hover documentation')

    if vim.lsp.inlay_hint then
        bufmap('<leader>H', function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }), { bufnr = bufnr })
        end, 'Toggle inlay hints')
        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    end

    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        vim.lsp.buf.format()
    end, {})
end

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('xavi-lsp-keymaps', { clear = true }),
    callback = function(args)
        set_lsp_keymaps(args.buf)
    end,
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

require("mason").setup()
require("mason-lspconfig").setup()

vim.lsp.config("*", {
    capabilities = capabilities,
})

if vim.fn.exists(':LspInfo') == 0 then
    vim.api.nvim_create_user_command('LspInfo', 'checkhealth vim.lsp', {
        desc = 'Alias to :checkhealth vim.lsp',
    })
end

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
