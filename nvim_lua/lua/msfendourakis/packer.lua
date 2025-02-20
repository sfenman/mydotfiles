-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- web icons
  use {'kyazdani42/nvim-web-devicons'}

  -- Themes
  use 'folke/tokyonight.nvim'
  use {"ellisonleao/gruvbox.nvim"}
  use({
    'rose-pine/neovim',
    as = 'rose-pine'
  })
  use "rebelot/kanagawa.nvim"
  use "catppuccin/nvim"

  -- Markdown preview
  use {"ellisonleao/glow.nvim"}
  -- Markdown preview plugin.install without yarn or npm
  use({
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
  })

  -- use({ "iamcco/markdown-preview.nvim", run = "cd app && npm install", setup = function() vim.g.mkdp_filetypes = { "markdown" } end, ft = { "markdown" }, })

  -- Syntax highlighting
  -- Run TSInstall hcl
  use("nvim-treesitter/nvim-treesitter", {
      run = ":TSUpdate"
  })
  -- Telescope
  use {
  'nvim-telescope/telescope.nvim', tag = '0.1.4',
  requires = { {'nvim-lua/plenary.nvim'} }
}

  -- Statusline
  -- Install a patched font first. Eg : https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/Ubuntu/Bold/complete/Ubuntu%20Bold%20Nerd%20Font%20Complete.ttf
  use {
  'nvim-lualine/lualine.nvim',
  requires = { 'kyazdani42/nvim-web-devicons', opt = true }
}

  -- LSP
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-nvim-lua'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-buffer'
  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'
  use({
    "glepnir/lspsaga.nvim",
    branch = "main",
  })

  -- Debugging
  use 'mfussenegger/nvim-dap'
  use 'leoluz/nvim-dap-go' -- requires delve. go install delve
  use 'rcarriga/nvim-dap-ui'
  use 'theHamsta/nvim-dap-virtual-text'
  use 'nvim-telescope/telescope-dap.nvim'

  -- Other stuff
  use 'tpope/vim-surround'

  use 'hashivim/vim-terraform'

  -- Git
  use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }
  use { 'rhysd/git-messenger.vim'}

  -- Indentation
  use { 'lukas-reineke/indent-blankline.nvim' }

  -- Comment
  use {
    'numToStr/Comment.nvim',
}

  use { 'towolf/vim-helm' }

  -- Terramate
  use 'terramate-io/vim-terramate'

  -- Nvim tree
  use {
  'nvim-tree/nvim-tree.lua',
  requires = {
    'nvim-tree/nvim-web-devicons', -- optional, for file icons
  },
}

-- duck nvim
  use 'tamton-aquib/duck.nvim'

-- Undotree
  use 'mbbill/undotree'

  -- Use keys to navigate between vim and tmux
  use { 'christoomey/vim-tmux-navigator' }

end)
