" Required for Vundle
set nocompatible
filetype off

" <Space> + shortcut
let mapleader = "\<Space>"
let g:mapleader = "\<Space>"

" " Copy to clipboard
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+y
nnoremap  <leader>yy  "+y

" " Paste from clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P

source ~/.config/nvim/myplugins/plug.vim

if has('nvim')
    source ~/.config/nvim/myplugins/fzf_shortcuts.vim
    source ~/.config/nvim/myplugins/myscripts.vim
endif

" read modeline from files
set modeline

set mouse=

" syntax highlight on
syntax on
filetype plugin indent on
set bg=dark
set termguicolors
" hi Search ctermfg=NONE ctermbg=grey
" hi! Special ctermfg=217 guifg=Orange

" my default indentation
set sw=2 ts=2 sts=2 et
set cino=(0W2st0
set smarttab

set guioptions-=m
set guioptions-=M

set cindent
set autoindent

set incsearch

set tags=./tags,tags
set cscopetag

" allow to hide buffers with changes not written to file
set nohidden

set laststatus=2

" highlight OverLength ctermbg=red ctermfg=white guibg=red guifg=white
" match Overlength '\%>80v.\+'

" highlight RedundantSpaces term=standout ctermbg=red guibg=red
" match RedundantSpaces /\s\+$\| \+\ze\t/

" highlight DiffAdd ctermfg=white ctermbg=darkgrey
" highlight DiffDelete ctermbg=darkcyan
" highlight DiffText ctermfg=grey ctermbg=darkred
" highlight DiffChange ctermfg=white ctermbg=darkmagenta

set listchars=tab:>-,trail:.,extends:>
set list

" Make vim work with tmux
if &term == "screen"
    set t_kN=[6;*~
    set t_kP=[5;*~
endif

" Remap Alt + Space ==> ESC
nmap <Space> <Nop>
inoremap <C-q> <ESC>
nmap <C-q> <Nop>
" inoremap jk <ESC>
" inoremap kj <ESC>

" Get efficient with shortcuts, don't need to press <shift> to enter commands
noremap ; :

" Easy window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Easy window navigation from terminal mode
if has('nvim')
    tnoremap <A-h> <C-\><C-n><C-w>h
    tnoremap <A-j> <C-\><C-n><C-w>j
    tnoremap <A-k> <C-\><C-n><C-w>k
    tnoremap <A-l> <C-\><C-n><C-w>l
endif

" Better navigation on long lines
nnoremap j gj
nnoremap k gk
nnoremap <C-Up> ddkP
nnoremap <C-Down> ddp

" Scroll the viewport faster
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" quickfix window on topleft
cnoremap cw topleft cwindow

nmap <leader>cd :lcd %:p:h<CR>:pwd<CR>
nmap <leader>bd :Bclose<CR>

nnoremap <leader>ve :e $MYVIMRC<CR>
nnoremap <leader>vt :tab split $MYVIMRC<CR>
nnoremap <leader>vl :source $MYVIMRC<CR>

nmap <leader>ma :make<CR>
nmap <leader>mi :make install<CR>

nnoremap <S-Tab> :bp <enter>
nnoremap <Tab> :bn <enter>

nmap <F5> :!ctags -f tags --append --tag-relative -R --c-kinds=+p --fields=+S . <CR>
nmap <F6> :!rm tags <CR>

nmap <Leader>txt :setlocal nocindent tw=72 nolist<CR>
nmap <Leader>cso :setlocal noet nolist ts=8 sw=8 sts=8<CR>
nmap <Leader>sw4 :setlocal et list ts=4 sw=4 sts=4<CR>

"setting mesa indent
nmap <F9> :setlocal ts=3 sw=3 sts=3 et autoindent cindent <enter>

"setting efl indent
nmap <F10> :setlocal cindent ts=8 sw=3 sts=8 expandtab cino=>5n-3f0^-2{2(0W1st0 <enter>

"setting tmp indent
nmap <F8> :setlocal nolist ts=8 sw=8 sts=8 noet cindent autoindent <enter>

"better shortcut for changing to and from previous tab
nnoremap <A-i> gt
nnoremap <A-u> gT

" Configuring the :terminal
if has('nvim')
    tnoremap <A-i> <C-\><C-n>gt
    tnoremap <A-u> <C-\><C-n>gT

    " leave the terminal more easily
    tnoremap <C-h> <C-\><C-n>

    command! -nargs=* T rightbelow split | terminal <args>
    command! -nargs=* VT rightbelow vsplit | terminal <args>
    command! -nargs=* TT tab split | terminal <args>

    augroup nvimterm
        au!
        autocmd TermOpen * setlocal norelativenumber nonumber matchpairs= | startinsert
    augroup END
endif

 hi CursorLine cterm=NONE ctermbg=lightgrey guibg=#202020 guifg=NONE
 set cursorline

set tabline=%!MyTabLine()

let wiki = {}
let wiki.path = '~/vimwiki/'
let wiki.nested_syntaxes = {
    \ 'python': 'python',
    \ 'c++': 'cpp',
    \ 'c': 'c',
    \ 'bash': 'sh',
    \ }
let g:vimwiki_list = [wiki]
let g:vimwiki_hl_headers=1

let g:fugitive_repo_cwd=1

let g:localvimrc_persistent=1

let $FZF_DEFAULT_OPTS .= ' --no-height'

nmap S <Plug>(easymotion-s)

set updatetime=200

" a little more informative version of the above
nmap <Leader>sI :call <SID>SynStack()<CR>

function! <SID>SynStack()
    if !exists("*synstack")
        return
    endif
    echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

nn <silent> K :call CocActionAsync('doHover')<cr>

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nmap <leader>rn <Plug>(coc-rename)
