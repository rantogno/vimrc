" Required for Vundle
set nocompatible
filetype off

" <Space> + shortcut
let mapleader = "\<Space>"
let g:mapleader = "\<Space>"

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
" set bg=dark
hi Search ctermfg=NONE ctermbg=236
" hi! Special ctermfg=217 guifg=Orange

" my default indentation
set sw=3 ts=3 sts=3 et
set cino=(0W1st0
set smarttab

set guioptions-=m
set guioptions-=M

set cindent
set autoindent

set incsearch

set tags=./tags,tags
set cscopetag

" allow to hide buffers with changes not written to file
set hidden

set laststatus=2

" highlight OverLength ctermbg=red ctermfg=white guibg=red guifg=white
" match Overlength '\%>80v.\+'

" highlight RedundantSpaces term=standout ctermbg=red guibg=red
" match RedundantSpaces /\s\+$\| \+\ze\t/

set listchars=tab:>-,trail:.,extends:>
set list

" Make vim work with tmux
if &term == "screen"
    set t_kN=[6;*~
    set t_kP=[5;*~
endif

" Remap Alt + Space ==> ESC
nmap <Space> <Nop>
inoremap jk <ESC>
inoremap kj <ESC>

" Get efficient with shortcuts, don't need to press <shift> to enter commands
noremap ; :

" Easy window navigation
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

" Easy window navigation from insert mode
inoremap <A-h> <ESC><C-w>h
inoremap <A-j> <ESC><C-w>j
inoremap <A-k> <ESC><C-w>k
inoremap <A-l> <ESC><C-w>l

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

function! CursorLineFunc()
    hi CursorLine cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
    setlocal cursorline
endfunction

command! -nargs=0 CursorLine call CursorLineFunc()
command! -nargs=0 NoCursorLine set nocursorline

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
