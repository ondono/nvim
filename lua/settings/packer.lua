return require("packer").startup(
  function(use)
    use("wbthomason/packer.nvim")

    -- plugins list
    -- to ensure that settings are modular and loaded *after* this has run
    -- all plugin specific configs are on the plugin folder, in a file named 
    -- <plugin>.lua

    -- git in nvim
    use("tpope/vim-fugitive")
    use("ciaranm/securemodelines")

    use("nvim-lua/plenary.nvim")
    use("nvim-lua/popup.nvim")
    use("nvim-telescope/telescope.nvim")

    use({
        'nvim-lualine/lualine.nvim',
    })

    -- lsp configurations
   -- use("neovim/nvim-lspconfig")
   -- use("hrsh7th/cmp-nvim-lsp")
   -- use("hrsh7th/cmp-buffer")
   -- use("hrsh7th/nvim-cmp")
   -- use("tzachar/cmp-tabnine", { run = "./install.sh" })
   -- use("onsails/lspkind-nvim")
   -- use("nvim-lua/lsp_extensions.nvim")
   -- use("glepnir/lspsaga.nvim")
   -- use("simrat39/symbols-outline.nvim")
   -- use("L3MON4D3/LuaSnip")
   -- use("saadparwaiz1/cmp_luasnip")

    -- extra tools for rust
   -- use("simrat39/rust-tools.nvim")
   -- use("rust-lang/rust.vim")

    -- Primeagen stuff
    use("ThePrimeagen/git-worktree.nvim")
    use("ThePrimeagen/harpoon")
    use{"ThePrimeagen/refactoring.nvim",
        requires = {
            {"nvim-lua/plenary.nvim"},
            {"nvim-treesitter/nvim-treesitter"}
        }
    }

    -- undotree?
    use("mbbill/undotree")

    -- Colorscheme section
    --use("chriskempson/base16-vim")
    use("RRethy/nvim-base16")
    use("gruvbox-community/gruvbox")
    use("folke/tokyonight.nvim")
    use({"catppuccin/nvim", as = "catppuccin" })
    use({'rose-pine/neovim', as = 'rose-pine' })

    -- Treesitter
    use("nvim-treesitter/nvim-treesitter", {
        run = ":TSUpdate"
    })
    use("nvim-treesitter/playground")
    use("romgrk/nvim-treesitter-context")

    -- Debugging
    use("mfussenegger/nvim-dap")
    use("rcarriga/nvim-dap-ui")
    use("theHamsta/nvim-dap-virtual-text")

    -- zen mode
    use("folke/zen-mode.nvim")

    -- github copilot?
    use("github/copilot.vim")

    -- LSP
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v1.x',
        requires = {
        -- LSP Support
        {'neovim/nvim-lspconfig'},
        {'williamboman/mason.nvim'},
        {'williamboman/mason-lspconfig.nvim'},
        -- Autocompletion
        {'hrsh7th/nvim-cmp'},
        {'hrsh7th/cmp-nvim-lsp'},
        {'hrsh7th/cmp-buffer'},
        {'hrsh7th/cmp-path'},
        {'saadparwaiz1/cmp_luasnip'},
        {'hrsh7th/cmp-nvim-lua'},
        -- Snippets
        {'L3MON4D3/LuaSnip'},
        {'rafamadriz/friendly-snippets'},
      }
    }
    -- Rust support
    use("simrat39/rust-tools.nvim")
   -- use("rust-lang/rust.vim")

   -- Latex Support
    use("lervag/vimtex")

  end
)
