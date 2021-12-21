set path+=**

let plugin_install = '~/.config/nvim/plugged'
if has('win32') || has('win64')
    let &shell='cmd.exe'
    let plugin_install = '~/AppData/Local/nvim/plugged'
endif

" Nice menu when typing `:find *.py`
set wildmode=longest,list,full
set wildmenu
" ignore files
set wildignore+=*.pyc
set wildignore+=*_build/*
set wildignore+=**/node_modules/*
set wildignore+=**/.git/*

call plug#begin(plugin_install)

" Language server protocol plugins (can't get to work on windows right now)
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'

" navigate project in directory tree format
Plug 'scrooloose/nerdtree'
" highlighting for {F|f} and {T|t}
Plug 'unblevable/quick-scope'

" quick way to get cheat sheet helpers
Plug 'dbeniamine/cheat.sh-vim'

" git wrapper
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
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
endif

" tree-sitter needs gcc
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" easy file markers
Plug 'ThePrimeagen/harpoon'

" formatter (prettier, etc)
Plug 'sbdchd/neoformat'

" linter (eslint, etc)
Plug 'dense-analysis/ale'

" web devicon support
Plug 'kyazdani42/nvim-web-devicons'

" gruvbox theme
Plug 'gruvbox-community/gruvbox'
" spacemacs theme
Plug 'colepeters/spacemacs-theme.vim'

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

" vim's default for backspace limits it's use.
" set to 2 which allows backspace on: indent, eol, and start
set backspace=2

set guicursor= 
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
nnoremap <leader>tr <cmd>tabr<cr>
nnoremap <leader>tl <cmd>tabl<cr>
nnoremap <leader>tp <cmd>tabp<cr>
nnoremap <leader>tn <cmd>tabn<cr>

" NERDTree quick toggle
map <C-n> :NERDTreeToggle<cr>

" git mappings
nnoremap <leader>gc :GBranches<CR>
nnoremap <leader>ga :Git fetch --all<CR>
nnoremap <leader>gb :Git blame<cr>
" git gutter mappings
nnoremap <leader>gp <cmd>GitGutterPreviewHunk<cr>

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

" harpoon remaps
nnoremap <leader>ht <cmd>lua require("harpoon.ui").toggle_quick_menu()<cr>
nnoremap <leader>hm <cmd>lua require("harpoon.mark").add_file()<cr>
nnoremap <leader>hc <cmd>lua require("harpoon.mark").clear_all()<cr>

" LSP mappings
nnoremap <leader>gd <cmd>lua vim.lsp.buf.definition()<cr>
nnoremap <leader>gD <cmd>lua vim.lsp.buf.declaration()<cr>
nnoremap <leader>gr <cmd>lua vim.lsp.buf.references()<cr>
nnoremap <leader>gi <cmd>lua vim.lsp.buf.implementation()<cr>
nnoremap <leader>K <cmd>lua vim.lsp.buf.hover()<cr>
nnoremap <leader>Ks <cmd>lua vim.lsp.buf.signature_help()<cr>
nnoremap <leader>Kp <cmd>lua vim.lsp.buf.goto_prev()<cr>
nnoremap <leader>Kn <cmd>lua vim.lsp.buf.goto_next()<cr>
nnoremap <leader>rn    <cmd>lua vim.lsp.buf.rename()<cr>
nnoremap <leader><C-f> <cmd>lua vim.lsp.buf.formatting()<cr>
nnoremap <leader>ca <cmd>lua vim.lsp.buf.code_action()<cr>

" tree sitter configurations
lua <<EOF
require'nvim-treesitter.configs'.setup {
    ensure_installed = "maintained",
    highlight = {
        enable = true,
    },
    indent = {
        enable = true
    }
}
EOF

" use tree sitter for folding
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set nofoldenable

" Language server protocol stuff
lua <<EOF
require'lspconfig'.clangd.setup{}
require'lspconfig'.pylsp.setup{
    settings = {
        pylsp = {
            plugins = {
                pycodestyle = {
                    addIgnore = {"C0325","C0111","C0103","W0702"},
                    maxLineLength = 90
                },
                pylint = {
                    enabled = true,
--                    executable = "/path/to/executable"
                },
                yapf = {
                    enabled = true
                }
            }
        }
    }
}
require'lspconfig'.tsserver.setup{
    init_options = {
        hostInfo = "neovim",
        preferences = {
            disableSuggestions = false,
            quotePreference = "single"
        }
    }
}
EOF

" Set completeopt to have a better completion experience
set completeopt=menuone,noselect
" Avoid showing message extra message when using completion
set shortmess+=c

" " nvim-compe defaults
let g:compe = {}
let g:compe.enabled = v:true
let g:compe.autocomplete = v:true
let g:compe.debug = v:false
let g:compe.min_length = 1
let g:compe.preselect = 'enable'
let g:compe.throttle_time = 80
let g:compe.source_timeout = 200
let g:compe.incomplete_delay = 400
let g:compe.max_abbr_width = 100
let g:compe.max_kind_width = 100
let g:compe.max_menu_width = 100
let g:compe.documentation = v:true

let g:compe.source = {}
let g:compe.source.path = v:true
let g:compe.source.buffer = v:true
let g:compe.source.calc = v:true
let g:compe.source.nvim_lsp = v:true
let g:compe.source.nvim_lua = v:true
let g:compe.source.vsnip = v:true

" autoformat
autocmd BufWritePre *.c lua vim.lsp.buf.formatting_sync(nil, 100)
autocmd BufWritePre *.h lua vim.lsp.buf.formatting_sync(nil, 100)

" kludge for quickly executing terminal commands
lua <<EOF
function openTerminalWithCommand(command)
    local term_buf = vim.api.nvim_create_buf(true, false)
    vim.api.nvim_open_term(term_buf, {})
    vim.cmd("terminal " .. command)
end
EOF

-- example usage
-- nnoremap <leader>bp <cmd>lua openTerminalWithCommand("command here")<cr>
nnoremap <leader>bd <cmd>bd!<cr>

" configure ale 
let g:ale_linters_explicit = 1
let g:ale_linters = {
            \ "javascript": ["eslint"]
            \}

augroup PRE_SAVE_STUFF
    autocmd!
    " run neoformat on js files
    autocmd BufWritePre *.js Neoformat
    " get rid of trailing whitespace
    autocmd BufWritePre * %s/\s\+$//e
augroup END
