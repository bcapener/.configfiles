
set nocompatible              " be iMproved, required
filetype off                  " required
" git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Keep Plugin commands between vundle#begin/end.
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'Valloric/YouCompleteMe'
Plugin 'ctrlpvim/ctrlp.vim'
"Plugin 'scrooloose/syntastic'
Plugin 'tmhedberg/SimpylFold'
Plugin 'bling/vim-bufferline'
Plugin 'altercation/vim-colors-solarized'
Plugin 'scrooloose/nerdcommenter'
"Plugin 'davidhalter/jedi-vim'
"Plugin 'metakirby5/codi.vim'
Plugin 'godlygeek/tabular'
"Plugin 'plasticboy/vim-markdown'
Plugin 'ludovicchabant/vim-gutentags'
Plugin 'majutsushi/tagbar'
"Plugin 'xolox/vim-misc'
"Plugin 'xolox/vim-notes'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
"

" To enable 256 colors in vim, put this your .vimrc before setting the
" colorscheme. see: http://vim.wikia.com/wiki/256_colors_in_vim
set t_Co=256

" Enable syntax highlighting
syntax on

" let mapleader=' '
let mapleader=','

inoremap jk <Esc>
inoremap kj <Esc>
" vnoremap jk <Esc>
" vnoremap kj <Esc>
onoremap jk <Esc>
onoremap kj <Esc>

set nowrap

" Better command-line completion
" set wildmenu

" Show partial commands in the last line of the screen
set showcmd

" Highlight searches (use <C-L> to temporarily turn off highlighting; see the
" mapping of <C-L> below)
set hlsearch

" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase
 
" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start
 
" When opening a new line and no filetype-specific indenting is enabled, keep
" the same indent as the line you're currently on. Useful for READMEs, etc.
set autoindent
 
" Stop certain movements from always going to the first character of a line.
" While this behaviour deviates from that of Vi, it does what most users
" coming from other editors would expect.
set nostartofline
 
" Display the cursor position on the last line of the screen or in the status
" line of a window
set ruler
 
" Always display the status line, even if only one window is displayed
set laststatus=2
 
" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm
 
" Use visual bell instead of beeping when doing something wrong
" set visualbell
 
" And reset the terminal code for the visual bell. If visualbell is set, and
" this line is also included, vim will neither flash nor beep. If visualbell
" is unset, this does nothing.
"set t_vb=
 
" Enable use of the mouse for all modes
set mouse=a
 
" Set the command window height to 2 lines, to avoid many cases of having to
" "press <Enter> to continue"
"set cmdheight=2

" When a bracket is inserted, briefly jump to the matching one.
set showmatch

set clipboard^=unnamed,unnamedplus

set splitbelow
set splitright
 
" Display line numbers on the left
set number
set relativenumber
 
" Quickly time out on keycodes, but never time out on mappings
set notimeout ttimeout ttimeoutlen=200
 
" Use <F2> to toggle between 'paste' and 'nopaste'
set pastetoggle=<F2>
 
""""""""""""""""""""""""""""""""
" Python specific
autocmd FileType python setlocal expandtab shiftwidth=4 softtabstop=4 tabstop=4 textwidth=300 autoindent fileformat=unix
"au BufNewFile,BufRead *.py
    "\ set tabstop=4 |		" Number of spaces that a <Tab> in the file counts for.
    "\ set softtabstop=4 |
    "\ set shiftwidth=4 |
    "\ set textwidth=300 |
    "\ set expandtab |
    "\ set autoindent |
    "\ set fileformat=unix
" Press <F9> to run current python buffer.
autocmd FileType python nnoremap <buffer> <F9> :exec '!python' shellescape(@%, 1)<cr>
" end Python specific
""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""
" Markdown
au! BufRead,BufNewFile *.markdown set filetype=mkd
au! BufRead,BufNewFile *.md       set filetype=mkd
""""""""""""""""""""""""""""""""

"------------------------------------------------------------
" Mappings {{{1
"
" Useful mappings
 
" Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy,
" which is the default
map Y y$
 
" Map <C-L> (redraw screen) to also turn off search highlighting until the
" next search
"nnoremap <C-L> :nohl<CR><C-L>

nnoremap <Leader>w :w<CR>
inoremap <Leader>w :w<CR>
vnoremap <Leader>w :w<CR>

nnoremap <Leader>e :e
inoremap <Leader>e :e
vnoremap <Leader>e :e

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Center Searches
:nnoremap n nzz
:nnoremap N Nzz
:nnoremap * *zz
:nnoremap # #zz
:nnoremap g* g*zz
:nnoremap g# g#zz

let g:ctrlp_working_path_mode = 'ra'

""""""""""""""""""""""""""""""""
" majutsushi/tagbar
nmap <F8> :TagbarToggle<CR>
" end majutsushi/tagbar
""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""
" scrooloose/syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_python_checkers = ['pylint']
" end scrooloose/syntastic
""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""
" Valloric/YouCompleteMe
"let g:ycm_autoclose_preview_window_after_completion=1
"let g:ycm_collect_identifiers_from_tags_files = 1
"let g:ycm_min_num_of_chars_for_completion = 0
"map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>
"let g:ycm_python_binary_path = 'python'
" end Valloric/YouCompleteMe
""""""""""""""""""""""""""""""""
" ---------------------------------- "
"  " Configure YouCompleteMe
" ---------------------------------- "

let g:ycm_python_binary_path = 'python'
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_collect_identifiers_from_tags_files = 1 " Let YCM read tags from Ctags file
"let g:ycm_use_ultisnips_completer = 1 " Default 1, just ensure
let g:ycm_seed_identifiers_with_syntax = 1 " Completion for programming language's keyword
let g:ycm_complete_in_comments = 1 " Completion in comments
"let g:ycm_complete_in_strings = 1 " Completion in string
let g:ycm_min_num_of_chars_for_completion = 1

"let g:ycm_key_list_select_completion = ['<C-j>', '<Down>']
"let g:ycm_key_list_previous_completion = ['<C-k>', '<Up>']

"map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

" Goto definition with F3
"map <F3> :YcmCompleter GoTo<CR>

""""""""""""""""""""""""""""""""
" vim-airline/vim-airline
" Automatically displays all buffers when there's only one tab open.
let g:airline#extensions#tabline#enabled = 1
" end vim-airline/vim-airline
""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""
" scrooloose/nerdcommenter
let g:NERDSpaceDelims = 1
" end scrooloose/nerdcommenter
""""""""""""""""""""""""""""""""
let g:gutentags_cache_dir = '~/.vim/gutentags'
""""""""""""""""""""""""""""""""
" Buffer stuff
":nnoremap <Tab> :bnext<CR>
":nnoremap <S-Tab> :bprevious<CR>

" Mappings to access buffers (don't use "\p" because a
" delay before pressing "p" would accidentally paste).
" \l       : list buffers
" \b \f \g : go back/forward/last-used
" \1 \2 \3 : go to buffer 1/2/3 etc
nnoremap <Leader>l :ls<CR>
nnoremap <Leader>b :bp<CR>
nnoremap <Leader>f :bn<CR>
"nnoremap <Leader>g :e#<CR>
nnoremap <Leader>t :e#<CR>
nnoremap <Leader>1 :1b<CR>
nnoremap <Leader>2 :2b<CR>
nnoremap <Leader>3 :3b<CR>
nnoremap <Leader>4 :4b<CR>
nnoremap <Leader>5 :5b<CR>
nnoremap <Leader>6 :6b<CR>
nnoremap <Leader>7 :7b<CR>
nnoremap <Leader>8 :8b<CR>
nnoremap <Leader>9 :9b<CR>
nnoremap <Leader>0 :10b<CR>
" It's useful to show the buffer number in the status line.
" set laststatus=2 statusline=%02n:%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P
" end Buffer stuff
""""""""""""""""""""""""""""""""

":autocmd InsertEnter * set cul
":autocmd InsertLeave * set nocul

