-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Themes
  use 'folke/tokyonight.nvim'
  use({
    'rose-pine/neovim',
    as = 'rose-pine'
  })

  -- Markdown preview
  use {"ellisonleao/glow.nvim"}

  -- Telescope
  use("nvim-treesitter/nvim-treesitter", {
      run = ":TSUpdate"
  })
  use {
  'nvim-telescope/telescope.nvim', tag = '0.1.0',
  requires = { {'nvim-lua/plenary.nvim'} }
}

  -- Statusline
  -- Install a patched font first. Eg : https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/Ubuntu/Bold/complete/Ubuntu%20Bold%20Nerd%20Font%20Complete.ttf
  use {
  'nvim-lualine/lualine.nvim',
  requires = { 'kyazdani42/nvim-web-devicons', opt = true }
}
end)
