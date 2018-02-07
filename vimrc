set nocompatible              " be iMproved, required
filetype off                  " required

set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab

set backspace=2 " vim wasn't backspacing properly

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

" traverse file system as tree
Plugin 'scrooloose/nerdtree'

" quick git commands
Plugin 'tpope/vim-fugitive'

" basically a linter
Plugin 'scrooloose/syntastic'

" vim completion and things
Plugin 'vim-ruby/vim-ruby'

" tab completion for anything it knows about
Plugin 'ervandew/supertab'

" completion for C/C++ with clang
Plugin 'Rip-Rip/clang_complete'

" clang formatting for c,c++,obj-c,java,javascript,and protobuf
Plugin 'rhysd/vim-clang-format'

" indention highlighting
Plugin 'nathanaelkane/vim-indent-guides'

" theme 
Plugin 'nanotech/jellybeans.vim'

" theme
Plugin 'morhetz/gruvbox'

" quickly jump to any spot in line
Plugin 'unblevable/quick-scope'

" ruby completion
Plugin 'osyo-manga/vim-monster'

" quickly jump to any letter/word in file
Plugin 'easymotion/vim-easymotion'

" tool to use vim with tmux
Plugin 'felix-d/slimux'

" go development plugin for vim
Plugin 'fatih/vim-go'

" general javascript highlighting and indenting
Plugin 'pangloss/vim-javascript'

" Java highlighting
Plugin 'rudes/vim-java'

" fuzzy file finder
Plugin 'ctrlpvim/ctrlp.vim'

call vundle#end()            " required
filetype plugin indent on    " required

syntax on
colorscheme gruvbox 
set background=dark

" vim javascript highlight jsdoc
let g:javascript_plugin_jsdoc = 1
let g:javascript_conceal_function = "ƒ"
let g:javascript_conceal_null = "ø"

" use jshint for syntax checking
let g:syntastic_javascript_checkers = ['jshint']
" good default settings for syntaxer
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" set javac path to know about acop classes
"let g:syntastic_java_javac_classpath = '<java classes to include>'

" setting clang compiler path for clang_complete plugin
"let g:clang_library_path='<libclang.so path>'

" setting highlighting to only be done when f is pressed.
let g:qs_highlight_on_keys = ['f', 'F']

set foldmethod=indent
set number
set rnu

" tab mappings
map <C-t><up> :tabr<cr>
map <C-t><down> :tabl<cr>
map <C-t><left> :tabp<cr>
map <C-t><right> :tabn<cr>

" NERDTree quick toggle
map <C-n> :NERDTreeToggle<cr>

" Disable Arrow keys in Escape mode
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

" Disable Arrow keys in Insert mode
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>
