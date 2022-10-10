
lua plugins = require('plugins')

" let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
" if empty(glob(data_dir . '/autoload/plug.vim'))
"   silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
"   autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
" endif
" 
" call plug#begin()
" " The default plugin directory will be as follows:
" "   - Vim (Linux/macOS): '~/.vim/plugged'
" "   - Vim (Windows): '~/vimfiles/plugged'
" "   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
" " You can specify a custom plugin directory by passing it as the argument
" "   - e.g. `call plug#begin('~/.vim/plugged')`
" "   - Avoid using standard Vim directory names like 'plugin'
" 
" " Make sure you use single quotes
" 
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
" 
" Plug 'joshdick/onedark.vim'
" 
" Plug 'sheerun/vim-polyglot'
" 
" Plug 'tpope/vim-fugitive'
" 
" Plug 'jiangmiao/auto-pairs'
" 
" Plug 'luochen1990/rainbow'
" 
" Plug 'kyazdani42/nvim-web-devicons'
" 
" Plug 'romgrk/barbar.nvim'
" 
" Plug 'nvim-lualine/lualine.nvim'
" 
" Plug 'kyazdani42/nvim-tree.lua'
" 
" " Initialize plugin system
" call plug#end()

" configure treesitter
lua << EOF
require'nvim-treesitter.configs'.setup {
	--ensure_installed = {"python", "lua", "vim"}, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
	ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
	-- List of parsers to ignore installing
	ignore_install = {},
	highlight = {
	    enable = true,
	},
}
EOF

" configure nvcode-color-schemes
let g:nvcode_termcolors=256

syntax on
colorscheme onedark

" checks if your terminal has 24-bit color support
if (has("termguicolors"))
    set termguicolors
    hi LineNr ctermbg=NONE guibg=NONE
endif

"let mapleader = " "
map <space> <leader>
"map <Space> <Leader>

" set clipboard^=unnamed,unnamedplus
set clipboard=unnamedplus,unnamed

" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm

" Enable use of the mouse for all modes
set mouse=a

set number

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

"let g:rainbow_active = 1

" let g:coc_global_extensions = ['coc-pyright', 'coc-snippets', 'coc-git', 'coc-spell-checker', 'coc-json']

nnoremap <silent> <leader>gi :CocCommand git.chunkInfo<cr>


" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
" nnoremap <silent> K :call CocActionAsync('doHover')<CR>
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" function! GotoJump()
"   jumps
"   let j = input("Please select your jump: ")
"   if j != ''
"     let pattern = '\v\c^\+'
"     if j =~ pattern
"       let j = substitute(j, pattern, '', 'g')
"       execute "normal " . j . "\<c-i>"
"     else
"       execute "normal " . j . "\<c-o>"
"     endif
"   endif
" endfunction
" 
" nmap <Leader>j :call GotoJump()<CR>

"lua << END
"require('lualine').setup()
"END

" NOTE: If barbar's option dict isn't created yet, create it
let bufferline = get(g:, 'bufferline', {})

" Sets the icon's highlight group.
" If false, will use nvim-web-devicons colors
let bufferline.icon_custom_colors = v:false


