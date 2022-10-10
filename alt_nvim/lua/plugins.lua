-- This file can be loaded by calling `lua require('plugins')` from your init.vim

local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})

  -- Only required if you have packer configured as `opt`
  vim.cmd [[packadd packer.nvim]]

end

return require('packer').startup(function(use)
  use {
    'neoclide/coc.nvim',
    branch = 'release',
    config = function()
      vim.g.coc_global_extensions = {'coc-pyright', 'coc-snippets', 'coc-git', 'coc-spell-checker', 'coc-json', 'coc-lua'}
    end,
  }

  use {
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate'
  }
  use 'christianchiarulli/nvcode-color-schemes.vim'

  --use 'joshdick/onedark.vim'

  --use 'sheerun/vim-polyglot'

  use 'tpope/vim-fugitive'

  use 'jiangmiao/auto-pairs'

  use {
    'luochen1990/rainbow',
    config = [[vim.g.rainbow_active = 1]],
  }

  use 'kyazdani42/nvim-web-devicons'

  -- use 'romgrk/barbar.nvim'
  use {
    'romgrk/barbar.nvim',
    requires = {'kyazdani42/nvim-web-devicons'}
  }

  -- use 'nvim-lualine/lualine.nvim'
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function()
      require('lualine').setup()
    end,
  }

 -- use 'kyazdani42/nvim-tree.lua'
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icon
    },
    config = function() require'nvim-tree'.setup {} end
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)

