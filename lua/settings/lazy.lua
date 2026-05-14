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

                        vim.schedule(function()
                            if vim.api.nvim_win_is_valid(win) then
                                vim.api.nvim_set_current_win(win)
                            end
                        end)
                    end,
                })
            end,
        },

        -- GUI
        'MunifTanjim/nui.nvim',
        'kyazdani42/nvim-web-devicons',
        'nvim-neo-tree/neo-tree.nvim',

        -- git in nvim
        'tpope/vim-fugitive',
        'ciaranm/securemodelines',

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
        'Civitasv/cmake-tools.nvim',
        { 'akinsho/toggleterm.nvim', version = "*",   config = true },
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
        'rcarriga/nvim-dap-ui',
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

        'simrat39/rust-tools.nvim',

        -- Latex Support
        'lervag/vimtex',

        -- typst support
        { 'kaarmu/typst.vim',        ft = { 'typst' } },
        'mfussenegger/nvim-lint',

        -- Which key
        {
            "folke/which-key.nvim",
            event = "VeryLazy",
            opts = {},
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
