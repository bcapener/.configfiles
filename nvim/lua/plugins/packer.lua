local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

--automatically run :PackerCompile whenever packer.lua is updated
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

return require('packer').startup(function(use)
  use "wbthomason/packer.nvim"

  use 'nvim-lua/plenary.nvim'

  use {
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate',
  }
  -- https://github.com/Mofiqul/vscode.nvim
  use 'christianchiarulli/nvcode-color-schemes.vim'
  use "lunarvim/darkplus.nvim"
  use 'kyazdani42/nvim-web-devicons'

  use 'neovim/nvim-lspconfig'

  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }

  use "ahmedkhalf/project.nvim"
  use {'akinsho/bufferline.nvim', requires = 'kyazdani42/nvim-web-devicons'}

   use {"akinsho/toggleterm.nvim"}

  --use { 'tami5/lspsaga.nvim', branch = 'nvim6.0' }
  use({
      "glepnir/lspsaga.nvim",
      branch = "main",
      config = function()
          local saga = require("lspsaga")

          saga.init_lsp_saga({
              -- your configuration
          })
      end,
  })

  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.0',
  -- or                            , branch = '0.1.x',
    requires = { {'nvim-lua/plenary.nvim'} }
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)

