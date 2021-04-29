set path+=**

if has('win32') || has('win64')
    let &shell='cmd.exe'
endif

" Nice menu when typing `:find *.py`
set wildmode=longest,list,full
set wildmenu
" ignore files
set wildignore+=*.pyc
set wildignore+=*_build/*
set wildignore+=**/node_modules/*
set wildignore+=**/.git/*

call plug#begin("~/AppData/Local/nvim/plugged")

" Code completion (want to replace with LSP at some point)
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Language server protocol plugins (can't get to work on windows right now)
" Plug 'neovim/nvim-lspconfig'
" Plug 'hrsh7th/nvim-compe'

" navigate project in directory tree format
Plug 'scrooloose/nerdtree'
" highlighting for {F|f} and {T|t}
Plug 'unblevable/quick-scope'

" git wrapper
Plug 'tpope/vim-fugitive'
" view man pages in vim
Plug 'vim-utils/vim-man'
" navigate vim's undotree in a graphical tree format
Plug 'mbbill/undotree'

" telescope requirements...
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
if has('win32') || has('win64')
    " Windows find and grep 
    Plug 'BurntSushi/ripgrep'
else
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
endif
" web devicon support
Plug 'kyazdani42/nvim-web-devicons'

" gruvbox theme
Plug 'gruvbox-community/gruvbox'
" spacemacs theme
Plug 'colepeters/spacemacs-theme.vim'

" syntax highlighting for javascript
Plug 'pangloss/vim-javascript'
" syntax highlighting for vue.js
Plug 'posva/vim-vue'

" formatter for listed programming languages
Plug 'prettier/vim-prettier', { 'do': 'npm install', 'for': ['javascript', 'css', 'json', 'vue', 'html' ] }

" status line of info
Plug 'vim-airline/vim-airline'

call plug#end()

filetype plugin indent on    " required

syntax enable

colorscheme gruvbox 
set background=dark

" needed to correct problem with colorscheme inside of tmux
set t_Co=256

set tabstop=4 softtabstop=4 expandtab shiftwidth=4 smarttab
set smartindent

" vim doesn't perform a backspace in some instances
" so set this
set backspace=2

set guicursor= 
set foldmethod=indent
set nohlsearch
set number
set rnu
set nowrap
set noerrorbells
set incsearch
set inccommand=split
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set termguicolors
set scrolloff=8

set updatetime=50

set colorcolumn=80

" convenient newlines
nnoremap <leader>o o<esc>
nnoremap <leader>O O<esc>

" setting highlighting for F and T
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" enables buffers to be at the top of the screen like tabs (if no tabs are
" open)
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme='dark'

" tab mappings
map <C-t><up> :tabr<cr>
map <C-t><down> :tabl<cr>
map <C-t><left> :tabp<cr>
map <C-t><right> :tabn<cr>

" NERDTree quick toggle
map <C-n> :NERDTreeToggle<cr>

" git mappings
nnoremap <leader>gc :GBranches<CR>
nnoremap <leader>ga :Git fetch --all<CR>
nnoremap <leader>gb :Git blame<cr>

" undo tree mappings
nnoremap <leader>u :UndotreeToggle<CR>

" Disable Arrow keys in Escape mode
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

" telescope mappings
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" FindVar overrides
" let g:findvar_default_file_matching = '*.json,*.vue,*.js'
" let g:findvar_default_dir_exclude = 'node_modules,dist_electron,dist'

" grep for word in files FindVar
" nnoremap <leader>fg :FindVar<cr>
" autocmd FileType findvar nnoremap <buffer> <cr> :FindVarOpenFile<cr>

" prettier config
let g:prettier#config#print_width = 120
let g:prettier#config#tab_width = 3
let g:prettier#config#use_tabs = 'false'
let g:prettier#config#single_quote = 'false'
let g:prettier#config#arrow_parens = "avoid"
let g:prettier#config#trailing_comma = "none"
let g:prettier#config#jsx_bracket_same_line = 'true'

" run prettier on pre-save
autocmd BufWritePre *.js Prettier
autocmd BufWritePre *.vue Prettier

" Language server protocol stuff
" lua << EOF
" require'lspconfig'.vuels.setup{}
" require'lspconfig'.tsserver.setup{}
" require'lspconfig'.jsonls.setup{}
" EOF
" let g:LanguageClient_serverCommands = {
"             \ 'vue': ['vls'],
"             \ 'js': ['tsserver']
"             \}
" 
" " autocmd BufEnter * lua require'completion'.on_attach()
" 
" " " use tab and s-tab to navigate through popup menus
" " inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
" " inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" " 
" " " Set completeopt to have a better completion experience
" set completeopt=menuone,noselect
" " " Avoid showing message extra message when using completion
" " set shortmess+=c
" " " c-p to trigger completion
" " imap <silent> <c-p> <Plug>(comlpetion_trigger)
" 
" " nvim-compe defaults
" let g:compe = {}
" let g:compe.enabled = v:true
" let g:compe.autocomplete = v:true
" let g:compe.debug = v:false
" let g:compe.min_length = 1
" let g:compe.preselect = 'enable'
" let g:compe.throttle_time = 80
" let g:compe.source_timeout = 200
" let g:compe.incomplete_delay = 400
" let g:compe.max_abbr_width = 100
" let g:compe.max_kind_width = 100
" let g:compe.max_menu_width = 100
" let g:compe.documentation = v:true
" 
" let g:compe.source = {}
" let g:compe.source.path = v:true
" let g:compe.source.buffer = v:true
" let g:compe.source.calc = v:true
" let g:compe.source.nvim_lsp = v:true
" let g:compe.source.nvim_lua = v:true
" let g:compe.source.vsnip = v:true
