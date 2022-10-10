
local map = vim.api.nvim_set_keymap

-----------------------------------------------------------
-- General
-----------------------------------------------------------
map('n', '<Space>', '', {})
vim.g.mapleader = ' '               -- Change leader to a space
vim.opt.mouse = 'a'                 -- Enable mouse support
vim.opt.clipboard = 'unnamedplus'   -- Copy/paste to system clipboard
vim.opt.swapfile = false            -- Don't use swapfile
vim.opt.backup = false              -- creates a backup file
vim.opt.writebackup = false         -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
vim.opt.undofile = true             -- enable persistent undo
vim.opt.conceallevel = 0            -- so that `` is visible in markdown files
vim.opt.fileencoding = "utf-8"      -- the encoding written to a file
vim.opt.hlsearch = true             -- highlight all matches on previous search pattern
vim.opt.timeoutlen = 1000           -- time to wait for a mapped sequence to complete (in milliseconds)
vim.opt.updatetime = 300            -- faster completion (4000ms default)

-----------------------------------------------------------
-- Neovim UI
-----------------------------------------------------------
vim.opt.number = true               -- Show line number
vim.opt.showmatch = true            -- Highlight matching parenthesis
vim.opt.foldmethod = 'marker'       -- Enable folding (default 'foldmarker')
vim.opt.colorcolumn = '80'          -- Line lenght marker at 80 columns
vim.opt.splitright = true           -- Vertical split to the right
vim.opt.splitbelow = true           -- Orizontal split to the bottom
vim.opt.ignorecase = true           -- Ignore case letters when search
vim.opt.smartcase = true            -- Ignore lowercase for the whole pattern
vim.opt.linebreak = true            -- Wrap on word boundary
vim.opt.cmdheight = 2               -- more space in the neovim command line for displaying messages
--vim.opt.showmode = false            -- we don't need to see things like -- INSERT -- anymore
vim.opt.cursorline = true           -- highlight the current line
vim.opt.relativenumber = false      -- set relative numbered lines
vim.opt.numberwidth = 4             -- set number column width to 2 {default 4}
vim.opt.signcolumn = "yes"          -- always show the sign column, otherwise it would shift the text each time
vim.opt.wrap = false                -- display lines as one long line
vim.opt.scrolloff = 8               -- is one of my fav
vim.opt.sidescrolloff = 8
vim.opt.guifont = "monospace:h17"   -- the font used in graphical neovim applications
vim.opt.showtabline = 2             -- always show tabs
vim.opt.pumheight = 10              -- pop up menu height

-- Remove whitespace on save
vim.cmd [[au BufWritePre * :%s/\s\+$//e]]

-- Highlight on yank
vim.api.nvim_exec([[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=800}
  augroup end
]], false)

-----------------------------------------------------------
-- Memory, CPU
-----------------------------------------------------------
vim.opt.hidden = true               -- Enable background buffers
vim.opt.history = 100               -- Remember N lines in history
vim.opt.lazyredraw = true           -- Faster scrolling
vim.opt.synmaxcol = 240             -- Max column for syntax highlight

-----------------------------------------------------------
-- Colorscheme
-----------------------------------------------------------
vim.opt.termguicolors = true        -- Enable 24-bit RGB colors
vim.cmd('colorscheme darkplus')

-----------------------------------------------------------
-- Tabs, indent
-----------------------------------------------------------
vim.opt.expandtab = true            -- Use spaces instead of tabs
vim.opt.shiftwidth = 4              -- Shift 4 spaces when tab
vim.opt.tabstop = 4                 -- 1 tab == 4 spaces
vim.opt.smartindent = true          -- Autoindent new lines

-- Don't auto commenting new lines
vim.cmd [[au BufEnter * set fo-=c fo-=r fo-=o]]

-- Remove line lenght marker for selected filetypes
vim.cmd [[autocmd FileType text,markdown,html,xhtml,javascript setlocal cc=0]]

-- 2 spaces for selected filetypes
vim.cmd [[
  autocmd FileType xml,html,xhtml,css,scss,javascript,lua,yaml setlocal shiftwidth=2 tabstop=2
]]

-----------------------------------------------------------
-- Autocompletion
-----------------------------------------------------------

-- Insert mode completion options
vim.opt.completeopt = { "menuone", "noselect" } -- mostly just for cmp

-----------------------------------------------------------
-- Terminal
-----------------------------------------------------------

-- Open a terminal pane on the right using :Term
vim.cmd [[command Term :botright vsplit term://$SHELL]]

-- Terminal visual tweaks:
--- enter insert mode when switching to terminal
--- close terminal buffer on process exit
vim.cmd [[
    autocmd TermOpen * setlocal listchars= nonumber norelativenumber nocursorline
    autocmd TermOpen * startinsert
    autocmd BufLeave term://* stopinsert
]]

-----------------------------------------------------------
-- Startup
-----------------------------------------------------------

-- Disable nvim intro
vim.opt.shortmess:append "sI"
--vim.opt.shortmess:append "c"
--- In lsp attach function
local mapb = vim.api.nvim_buf_set_keymap



-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  --vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  --vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)


  mapb(bufnr, "n", "gr", "<cmd>Lspsaga rename<cr>", {silent = true, noremap = true})
  mapb(bufnr, "n", "gx", "<cmd>Lspsaga code_action<cr>", {silent = true, noremap = true})
  mapb(bufnr, "x", "gx", ":<c-u>Lspsaga range_code_action<cr>", {silent = true, noremap = true})
  mapb(bufnr, "n", "K",  "<cmd>Lspsaga hover_doc<cr>", {silent = true, noremap = true})
  mapb(bufnr, "n", "go", "<cmd>Lspsaga show_line_diagnostics<cr>", {silent = true, noremap = true})
  mapb(bufnr, "n", "gj", "<cmd>Lspsaga diagnostic_jump_next<cr>", {silent = true, noremap = true})
  mapb(bufnr, "n", "gk", "<cmd>Lspsaga diagnostic_jump_prev<cr>", {silent = true, noremap = true})
  mapb(bufnr, "n", "<C-u>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1, '<c-u>')<cr>", {})
  mapb(bufnr, "n", "<C-d>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1, '<c-d>')<cr>", {})
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'pyright', 'rust_analyzer', 'sumneko_lua'}
for _, lsp in pairs(servers) do
  require('lspconfig')[lsp].setup {
    on_attach = on_attach,
    flags = {
      -- This will be the default in neovim 0.7+
      debounce_text_changes = 150,
    }
  }
end
