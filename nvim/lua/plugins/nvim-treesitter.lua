
require'nvim-treesitter.configs'.setup {
  ensure_installed = {"python", "lua", "vim", "cpp", "c", "rust", "bash"}, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  --ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages

  -- List of parsers to ignore installing
  ignore_install = {},
  highlight = {
      enable = true,
  },
}
