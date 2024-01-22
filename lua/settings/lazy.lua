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
        -- session management
        --'Shatur/neovim-session-manager', -- assign commands

        -- notifcations
        'rcarriga/nvim-notify', -- testing

        -- GUI
        'MunifTanjim/nui.nvim', -- testing
        'kyazdani42/nvim-web-devicons', -- icons
        'nvim-neo-tree/neo-tree.nvim', -- file tree

        -- git in nvim
        'tpope/vim-fugitive',
        'ciaranm/securemodelines',

        'nvim-lua/plenary.nvim',
        'nvim-lua/popup.nvim',
        'nvim-telescope/telescope.nvim',
        'nvim-lualine/lualine.nvim',

        -- undotree
        'mbbill/undotree',

        -- Colorscheme section
        'RRethy/nvim-base16',
        'gruvbox-community/gruvbox',
        'folke/tokyonight.nvim',
        'catppuccin/nvim',
        'rose-pine/neovim',

        -- Treesitter
        { "nvim-treesitter/nvim-treesitter",
            build = ":TSUpdate"
        },
        'nvim-treesitter/playground',
        'romgrk/nvim-treesitter-context',

        -- Debugging
        'mfussenegger/nvim-dap',
        'rcarriga/nvim-dap-ui',
        'theHamsta/nvim-dap-virtual-text',

        -- zen mode
        'folke/zen-mode.nvim',

        -- github copilot
        'github/copilot.vim',

        -- LSP
        {
            'VonHeikemen/lsp-zero.nvim',
            branch = 'v1.x',
            dependencies = {
                -- LSP Support
                { 'neovim/nvim-lspconfig' },
                { 'williamboman/mason.nvim' },
                { 'williamboman/mason-lspconfig.nvim' },
                -- Autocompletion
                { 'hrsh7th/nvim-cmp' },
                { 'hrsh7th/cmp-nvim-lsp' },
                { 'hrsh7th/cmp-buffer' },
                { 'hrsh7th/cmp-path' },
                { 'saadparwaiz1/cmp_luasnip' },
                { 'hrsh7th/cmp-nvim-lua' },
                -- Snippets
                { 'L3MON4D3/LuaSnip' },
                { 'rafamadriz/friendly-snippets' },
            }
        },

        -- Rust support
        'simrat39/rust-tools.nvim',

        -- Latex Support
        'lervag/vimtex',

        -- typst support
        {'kaarmu/typst.vim', ft = { 'typst' }},
        'mfussenegger/nvim-lint',


    }
})
