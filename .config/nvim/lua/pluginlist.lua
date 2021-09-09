-- check if packer is installed (~/local/share/nvim/site/pack)
local packer_exists = pcall(vim.cmd, [[packadd packer.nvim]])

-- using { } when using a different branch of the plugin or loading the plugin with certain commands
require('packer').startup(function()
    use 'wbthomason/packer.nvim'

    use 'windwp/nvim-autopairs'
    use 'blackCauldron7/surround.nvim'
    use 'b3nj5m1n/kommentary'

    use 'nvim-treesitter/nvim-treesitter'
    use 'neovim/nvim-lspconfig'
    use 'nvim-lua/lsp_extensions.nvim'
    use 'simrat39/rust-tools.nvim'
    use 'onsails/lspkind-nvim'
    -- use 'nvim-lua/completion-nvim'
    use 'hrsh7th/nvim-compe'
    use 'jose-elias-alvarez/null-ls.nvim'
    use 'jose-elias-alvarez/nvim-lsp-ts-utils'
    use 'christoomey/vim-tmux-navigator'
    use 'ryanoasis/vim-devicons'
    use {
        'nvim-telescope/telescope.nvim',
        requires = {
            'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope-fzy-native.nvim'
        }
    }
    use 'hrsh7th/vim-vsnip'
    use 'hrsh7th/vim-vsnip-integ'
    use 'folke/tokyonight.nvim'
    use {
        'hoob3rt/lualine.nvim',
        requires = {'kyazdani42/nvim-web-devicons', opt = true}
    }
    use 'sbdchd/neoformat'
    use 'sakshamgupta05/vim-todo-highlight'

    use 'vimwiki/vimwiki'
    use 'ferrine/md-img-paste.vim'
    use 'itspriddle/vim-marked'
    -- use 'mfussenegger/nvim-dap'
    -- use { 'chmanie/nvim-dap-rust' }
    use 'chmanie/termdebugx.nvim'

    -- use 'kyazdani42/nvim-tree.lua'
    -- use 'lewis6991/gitsigns.nvim'
    -- use 'akinsho/nvim-bufferline.lua'
    -- use '907th/vim-auto-save'
    -- use 'norcalli/nvim-colorizer.lua'
    -- use 'alvan/vim-closetag'
    -- use 'tweekmonster/startuptime.vim'
    -- use 'nvim-telescope/telescope-media-files.nvim'
    -- use 'karb94/neoscroll.nvim'
    -- use 'nekonako/xresources-nvim'

end)
