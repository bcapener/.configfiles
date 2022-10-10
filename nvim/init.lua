-- git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim

require("plugins/packer")
require("settings")
require("plugins/nvim-treesitter")
require("plugins/nvim-lspconfig")
require("plugins/lualine")
require("plugins/bufferline")
require("plugins/toggleterm")


-- https://github.com/LunarVim/Neovim-from-scratch
-- https://github.com/nanotee/nvim-lua-guide
-- https://github.com/brainfucksec/neovim-lua
-- https://github.com/wbthomason/dotfiles/tree/linux/neovim/.config/nvim
