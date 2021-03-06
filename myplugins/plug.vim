" ----------------------------------------------------------------------------
"   Plug
"
" ----------------------------------------------------------------------------

" Install vim-plug if we don't already have it
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
              \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/plugged')


" set the runtime path to include Vundle and initialize
" set rtp+=~/.config/nvim/bundle/Vundle.vim
" call vundle#begin('~/.config/nvim/bundle/')

" let Vundle manage Vundle, required
" Plugin 'VundleVim/Vundle.vim'

" Plugins
" Plug 'bling/vim-airline'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'jremmen/vim-ripgrep'
Plug 'embear/vim-localvimrc'
Plug 'vimwiki/vimwiki'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dispatch'
Plug 'airblade/vim-gitgutter'
Plug 'mhinz/neovim-remote'
Plug 'guns/xterm-color-table.vim'
Plug 'cocopon/iceberg.vim'
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-vinegar'

Plug 'junegunn/gv.vim'
Plug 'jceb/vim-orgmode'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'rickhowe/diffchar.vim'

" All of your Plugins must be added before the following line
filetype plugin indent on    " required
call plug#end()            " required
