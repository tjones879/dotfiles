set exrc
set expandtab
set shiftwidth=4
set softtabstop=4
syntax on filetype plugin indent on
let mapleader=","
set number
set list
set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
set encoding=utf-8
set novisualbell
set so=2
set hidden
set pastetoggle=<F2>
set incsearch
set wildmenu

autocmd FileType make,automake set noexpandtab shiftwidth=8 softtabstop=8
highlight ForbiddenWhitespace ctermbg=red guibg=red
match ForbiddenWhitespace /\s\+$|\t/
autocmd InsertEnter * match ForbiddenWhitespace /t\|\s\+\%#\@<!$/

au Filetype html setlocal sw=2 ts=2 sts=2
au Filetype css  setlocal sw=2 ts=2 sts=2
" HTML
au Filetype html setlocal tabstop=2 shiftwidth=2

call plug#begin()

Plug 'w0rp/ale'
Plug 'tjones879/vim-material-monokai'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'majutsushi/tagbar'

Plug 'davidhalter/jedi-vim'
Plug 'maralla/completor.vim'
Plug 'Townk/vim-autoclose'

" Golang
Plug 'fatih/vim-go'

call plug#end()

let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>\<cr>" : "\<cr>"
inoremap jj <ESC>

let g:ale_linters = {
\   'cpp': ['clang'],
\   'rust': ['rustc', 'cargo'],
\}

let g:ale_cpp_clang_options = '-std=c++17 -stdlib=libc++ -I.'
let g:completor_clang_binary = '/usr/bin/clang++'
let g:completor_node_binary = '/usr/bin/node'
nmap <F8> :TagbarToggle<CR>

set background=dark
let g:materialmonokai_italic=1
colorscheme material-monokai

nmap ; :Buffers<CR>
nmap <Leader>t :Files<CR>
nmap <Leader>e :Tags<CR>

function! GitBranch()
    return system("git rev-parse --abbrev-ref HEAD 2> /dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
    let l:branchname = GitBranch()
    return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
endfunction

set laststatus=2
set statusline=
set statusline+=%#LineNr#
set statusline+=%{StatuslineGit()}
set statusline+=\ [%f]
set statusline+=%m
set statusline+=%=
set statusline+=\ %l:%c
set statusline+=\ %p%%
set statusline+=\ %L
set statusline+=\ %y
set statusline+=\ [%{&fileencoding?&fileencoding:&encoding}
set statusline+=\ %{&fileformat}\]
