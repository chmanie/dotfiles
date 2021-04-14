-- check if packer is installed (~/local/share/nvim/site/pack)
local packer_exists = pcall(vim.cmd, [[packadd packer.nvim]])

-- using { } when using a different branch of the plugin or loading the plugin with certain commands
require("packer").startup(function()
  use "wbthomason/packer.nvim"
  use "nvim-treesitter/nvim-treesitter"
  use "neovim/nvim-lspconfig"
  use "hrsh7th/nvim-compe"
  use "windwp/nvim-autopairs"
  use "b3nj5m1n/kommentary"
  use "christoomey/vim-tmux-navigator"
  use 'onsails/lspkind-nvim'
  use 'norcalli/snippets.nvim'
  use 'srcery-colors/srcery-vim'
  use {
    'glepnir/galaxyline.nvim',
    branch = 'main',
    requires = {'kyazdani42/nvim-web-devicons', opt = true}
  }

  -- use "norcalli/nvim-base16.lua"
  -- use "kyazdani42/nvim-tree.lua"
  -- use "nvim-lua/plenary.nvim"
  -- use "lewis6991/gitsigns.nvim"
  -- use "akinsho/nvim-bufferline.lua"
  -- use "907th/vim-auto-save"
  -- use "norcalli/nvim-colorizer.lua"
  -- use "ryanoasis/vim-devicons"
  -- use "sbdchd/neoformat"
  -- use "neovim/nvim-lspconfig"
  -- use "alvan/vim-closetag"
  -- use "tweekmonster/startuptime.vim"
  -- use "nvim-telescope/telescope.nvim"
  -- use "nvim-telescope/telescope-media-files.nvim"
  -- use "nvim-lua/popup.nvim"
  -- use "karb94/neoscroll.nvim"

  -- use "nekonako/xresources-nvim"
        
end)
