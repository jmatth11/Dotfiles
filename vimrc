set nocompatible              " be iMproved, required
filetype off                  " required

set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab

set backspace=2 " vim wasn't backspacing properly

set rtp+=~/.vim/bundle/vundle/
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

" traverse file system as tree
Plugin 'scrooloose/nerdtree'

" quick get commands
Plugin 'tpope/vim-fugitive'

" basically a linter
Plugin 'scrooloose/syntastic'

" vim completion and things
Plugin 'vim-ruby/vim-ruby'

" tab completion for anything it knows about
Plugin 'ervandew/supertab'

" completion for C/C++ with clang
Plugin 'Rip-Rip/clang_complete'

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

" javascript formatter
Plugin 'millermedeiros/vim-esformatter'

call vundle#end()            " required
filetype plugin indent on    " required

syntax on
colorscheme gruvbox 
set background=dark

" setting clang compiler path for clang_complete plugin
let g:clang_library_path='/Library/Developer/CommandLineTools/usr/lib/'

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

