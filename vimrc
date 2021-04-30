set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

" traverse file system as tree
Plugin 'scrooloose/nerdtree'

" quick git commands
Plugin 'tpope/vim-fugitive'

" tab completion for anything it knows about
Plugin 'ervandew/supertab'

" autocomplete for multiple langauges
Plugin 'Valloric/YouCompleteMe'

" clang formatting for c,c++,obj-c,java,javascript,and protobuf
Plugin 'rhysd/vim-clang-format'

" indention highlighting
Plugin 'nathanaelkane/vim-indent-guides'

" quickly jump to any spot in line
Plugin 'unblevable/quick-scope'

" gui for undo tree
Plugin 'mbbill/undotree'

" ruby completion
Plugin 'osyo-manga/vim-monster'

" quickly jump to any letter/word in file
Plugin 'easymotion/vim-easymotion'

" tool to use vim with tmux
Plugin 'felix-d/slimux'

" go development plugin for vim
Plugin 'fatih/vim-go'
Plugin 'tweekmonster/gofmt.vim'

" general javascript highlighting and indenting
Plugin 'pangloss/vim-javascript'

" JS beautifier
Plugin 'maksimr/vim-jsbeautify'

" Java highlighting
Plugin 'rudes/vim-java'

" fuzzy file finder
Plugin 'ctrlpvim/ctrlp.vim'

" helps list and manage vim buffers
Plugin 'jeetsukumaran/vim-buffergator'

" Provides a nice status bar at the bottom of the screen
Plugin 'vim-airline/vim-airline'

" easily align text based off of a symbol
Plugin 'junegunn/vim-easy-align'

" a multi language graphical debugger
Plugin 'puremourning/vimspector'

" man page in vim
Plugin 'vim-utils/vim-man'

" theme 
Plugin 'nanotech/jellybeans.vim'
Plugin 'gruvbox-community/gruvbox'

call vundle#end()            " required
filetype plugin indent on    " required

syntax on

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
set foldmethod=indent
set nohlsearch
set number
set rnu
set nowrap
set noerrorbells
set incsearch
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set termguicolors
set scrolloff=8

set updatetime=50

set colorcolumn=80

" vim javascript highlight jsdoc
let g:javascript_plugin_jsdoc = 1
let g:javascript_conceal_function = "ƒ"
let g:javascript_conceal_null = "ø"

" setting highlighting to only be done when f is pressed.
let g:qs_highlight_on_keys = ['f', 'F']

" default ignores for CtrlP plugin
let g:ctrlp_custom_ignore = {
    \ 'dir': '\v[\/](\.(git|hg|svn))$',
    \ 'file': '\v\.(exe|so|dll|class|png|jpg|jpeg)$',
\}

" use the right side of the screen
let g:buffergator_viewport_split_policy = 'R'
" use custom keymappings
let g:buffergator_suppress_keymaps = 1

" enables buffers to be at the top of the screen like tabs (if no tabs are
" open)
let g:airline#extensions#tabline#enabled = 1

" remap vim multiple cursors keys to not interfer with other plugin key
" mappings
let g:multi_cursor_use_default_mapping = 0
let g:multi_cursor_start_word_key      = '<leader>n<cr>'
let g:multi_cursor_start_key           = 'g<leader>n<cr>'
let g:multi_cursor_next_key            = '<leader>n<cr>'
let g:multi_cursor_prev_key            = '<leader>p<cr>'

" this mappings are the same as default but we had to re-assign them
let g:multi_cursor_select_all_word_key = '<A-n>'
let g:multi_cursor_select_all_key      = 'g<A-n>'
let g:multi_cursor_skip_key            = '<C-x>'
let g:multi_cursor_quit_key            = '<Esc>'

" go to prev buffer
nmap <leader>jj :BuffergatorMruCyclePrev<cr>
" go to next buffer
nmap <leader>kk :BuffergatorMruCycleNext<cr>
" view entire list of buffers
nmap <leader>bl :BuffergatorOpen<cr>
nmap <leader>T  :enew<cr>

" fuzzy file search
nmap <leader>p :CtrlP<cr>

" shortcut for GoTo command for youCompleteMe
nmap <leader>g :YcmCompleter GoTo<cr>

" start interactive EasyAlign in visual mode
xmap ga <Plug>(EasyAlign)

" start interactive EasyAlign in normal mode
nmap ga <Plug>(EasyAlign)

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

" undo tree mappings
nnoremap <leader>u :UndotreeToggle<CR>

" Disable Arrow keys in Escape mode
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
