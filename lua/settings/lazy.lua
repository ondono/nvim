local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
    {
        {
            'rcarriga/nvim-notify',
            config = function()
                require("notify").setup({
                    background_colour = "#ffffff",
                    merge_duplicates = true,
                    on_open = function(win)
                        local buf = vim.api.nvim_win_get_buf(win)
                        local close = function()
                            if vim.api.nvim_win_is_valid(win) then
                                vim.api.nvim_win_close(win, true)
                            end
                        end

                        vim.keymap.set("n", "q", close, { buffer = buf, silent = true })
                        vim.keymap.set("n", "<Esc>", close, { buffer = buf, silent = true })

                    end,
                })
            end,
        },

        -- GUI
        'MunifTanjim/nui.nvim',
        'nvim-tree/nvim-web-devicons',
        {
            'nvim-neo-tree/neo-tree.nvim',
            branch = 'main',
            cmd = 'Neotree',
            keys = {
                { '<leader>e', '<cmd>Neotree toggle<cr>', desc = 'Toggle file tree' },
            },
            opts = {},
        },

        -- git in nvim
        'tpope/vim-fugitive',
        'ciaranm/securemodelines',
        {
            'lewis6991/gitsigns.nvim',
            event = { 'BufReadPre', 'BufNewFile' },
            opts = {
                current_line_blame = false,
                on_attach = function(bufnr)
                    local gs = require('gitsigns')
                    local map = function(mode, lhs, rhs, desc)
                        vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
                    end

                    map('n', ']c', function()
                        if vim.wo.diff then
                            vim.cmd.normal({ ']c', bang = true })
                        else
                            gs.nav_hunk('next')
                        end
                    end, 'Next git hunk')
                    map('n', '[c', function()
                        if vim.wo.diff then
                            vim.cmd.normal({ '[c', bang = true })
                        else
                            gs.nav_hunk('prev')
                        end
                    end, 'Previous git hunk')
                    map({ 'n', 'v' }, '<leader>hs', gs.stage_hunk, 'Stage git hunk')
                    map({ 'n', 'v' }, '<leader>hr', gs.reset_hunk, 'Reset git hunk')
                    map('n', '<leader>hp', gs.preview_hunk, 'Preview git hunk')
                    map('n', '<leader>hb', gs.blame_line, 'Blame current line')
                    map('n', '<leader>hd', gs.diffthis, 'Diff current file')
                    map('n', '<leader>hS', gs.stage_buffer, 'Stage current buffer')
                    map('n', '<leader>hR', gs.reset_buffer, 'Reset current buffer')
                    map('n', '<leader>hu', gs.undo_stage_hunk, 'Undo stage hunk')
                end,
            },
        },
        {
            'akinsho/git-conflict.nvim',
            version = '*',
            event = { 'BufReadPre', 'BufNewFile' },
            opts = {
                default_mappings = true,
                default_commands = true,
                disable_diagnostics = false,
            },
        },

        'nvim-lua/plenary.nvim',
        --'nvim-lua/popup.nvim',
        'folke/noice.nvim',
        'nvim-lualine/lualine.nvim',
        {
            'nvim-telescope/telescope.nvim',
            dependencies = {
                'nvim-lua/plenary.nvim',
            }
        },
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'make'
        },

        -- undotree
        'mbbill/undotree',

        -- Colorscheme section
        'RRethy/nvim-base16',
        'gruvbox-community/gruvbox',
        'folke/tokyonight.nvim',
        'catppuccin/nvim',
        'rose-pine/neovim',

        -- Treesitter
        {
            "nvim-treesitter/nvim-treesitter",
            branch = "main",
            lazy = false,
            build = ":TSUpdate"
        },
        'romgrk/nvim-treesitter-context',

        -- coding
        {
            'NumToStr/Comment.nvim',
            config = function()
                require('Comment').setup()
            end
        },
        {
            'Civitasv/cmake-tools.nvim',
            ft = { 'c', 'cpp', 'cmake' },
            keys = {
                { '<leader>cg', '<cmd>CMakeGenerate<cr>', desc = 'CMake generate' },
                { '<leader>cb', '<cmd>CMakeBuild<cr>', desc = 'CMake build' },
                { '<leader>cr', '<cmd>CMakeRun<cr>', desc = 'CMake run target' },
                { '<leader>ct', '<cmd>CMakeRunTest<cr>', desc = 'CMake run tests' },
            },
            opts = {},
        },
        {
            'akinsho/toggleterm.nvim',
            version = '*',
            keys = {
                { '<leader>tt', '<cmd>ToggleTerm<cr>', desc = 'Toggle terminal' },
            },
            opts = {
                open_mapping = [[<c-\>]],
                direction = 'float',
            },
        },
        {
            'stevearc/conform.nvim',
            cmd = { 'ConformInfo' },
            keys = {
                {
                    '<leader>f',
                    function()
                        require('conform').format({ lsp_format = 'fallback' })
                    end,
                    mode = { 'n', 'v' },
                    desc = 'Format buffer or selection',
                },
            },
            opts = {
                formatters_by_ft = {
                    c = { 'clang_format' },
                    cpp = { 'clang_format' },
                    lua = { 'stylua' },
                    python = { 'ruff_format', 'black', stop_after_first = true },
                    rust = { 'rustfmt', lsp_format = 'fallback' },
                    sh = { 'shfmt' },
                    typst = { 'typstyle', lsp_format = 'fallback' },
                    zig = { 'zigfmt' },
                },
                default_format_opts = {
                    lsp_format = 'fallback',
                },
            },
        },
        {
            'folke/trouble.nvim',
            cmd = 'Trouble',
            keys = {
                { '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>', desc = 'Workspace diagnostics' },
                { '<leader>xX', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', desc = 'Buffer diagnostics' },
                { '<leader>xq', '<cmd>Trouble qflist toggle<cr>', desc = 'Quickfix list' },
                { '<leader>xl', '<cmd>Trouble loclist toggle<cr>', desc = 'Location list' },
                { '<leader>xs', '<cmd>Trouble symbols toggle<cr>', desc = 'Document symbols' },
                { '<leader>xr', '<cmd>Trouble lsp_references toggle<cr>', desc = 'LSP references' },
            },
            opts = {},
        },
        {
            'stevearc/overseer.nvim',
            cmd = { 'OverseerRun', 'OverseerToggle', 'OverseerQuickAction' },
            keys = {
                { '<leader>or', '<cmd>OverseerRun<cr>', desc = 'Run task' },
                { '<leader>oo', '<cmd>OverseerToggle<cr>', desc = 'Toggle tasks' },
                { '<leader>oq', '<cmd>OverseerQuickAction<cr>', desc = 'Task action' },
            },
            opts = {},
        },
        {
            'stevearc/oil.nvim',
            lazy = false,
            dependencies = { 'nvim-tree/nvim-web-devicons' },
            keys = {
                { '-', '<cmd>Oil<cr>', desc = 'Open parent directory' },
                { '<leader>pv', '<cmd>Oil<cr>', desc = 'Open file browser' },
            },
            opts = {
                default_file_explorer = true,
                delete_to_trash = true,
                view_options = {
                    show_hidden = true,
                },
            },
        },
        {
            "kylechui/nvim-surround",
            version = "*", -- Use for stability; omit to use `main` branch for the latest features
            event = "VeryLazy",
            config = function()
                require("nvim-surround").setup({
                    -- Configuration here, or leave empty to use defaults
                })
            end
        },


        -- Debugging
        'mfussenegger/nvim-dap',
        'nvim-neotest/nvim-nio',
        {
            'rcarriga/nvim-dap-ui',
            dependencies = { 'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio' },
        },
        'theHamsta/nvim-dap-virtual-text',

        -- zen mode
        'folke/zen-mode.nvim',

        -- github copilot
        'github/copilot.vim',

        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        'neovim/nvim-lspconfig',
        {
            'folke/lazydev.nvim',
            ft = 'lua',
            opts = {
                library = {
                    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                },
            },
        },
        {
            'hrsh7th/nvim-cmp',
            dependencies = {
                'L3MON4D3/LuaSnip',
                'saadparwaiz1/cmp_luasnip',
                'hrsh7th/cmp-nvim-lsp',
                'hrsh7th/cmp-buffer',
                'hrsh7th/cmp-path',
                'hrsh7th/cmp-cmdline',
                'hrsh7th/cmp-nvim-lsp-signature-help',
            },
        },
        {
            'folke/todo-comments.nvim',
            event = { 'BufReadPost', 'BufNewFile' },
            dependencies = { 'nvim-lua/plenary.nvim' },
            keys = {
                { '<leader>pt', '<cmd>TodoTelescope<cr>', desc = 'Find TODO comments' },
                { '<leader>xt', '<cmd>TodoTrouble<cr>', desc = 'TODO comments list' },
            },
            opts = {},
        },

        -- Latex Support
        'lervag/vimtex',

        -- typst support
        { 'kaarmu/typst.vim',        ft = { 'typst' } },

        -- Which key
        {
            "folke/which-key.nvim",
            event = "VeryLazy",
            opts = {
                spec = {
                    { '<leader>c', group = 'CMake' },
                    { '<leader>d', group = 'Debug' },
                    { '<leader>h', group = 'Git hunks' },
                    { '<leader>l', group = 'LSP' },
                    { '<leader>o', group = 'Tasks' },
                    { '<leader>p', group = 'Pickers' },
                    { '<leader>t', group = 'Terminal/Typst' },
                    { '<leader>x', group = 'Lists' },
                },
            },
            keys = {
                {
                    "<leader>?",
                    function()
                        require("which-key").show({ global = false })
                    end,
                    desc = "Buffer Local Keymaps (which-key)",
                },
            },
        }

    }
})
