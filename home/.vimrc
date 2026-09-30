let g:author='Sergej Braznikov'
let g:email='<394423+sbraznikov@users.noreply.github.com>'

filetype on
filetype plugin on 
filetype indent on
syntax on

set guifont=Monaco:h12
set t_Co=256
set scrolljump=3
set scrolloff=3
set hidden
set enc=utf-8
set termencoding=utf-8
set linebreak
set nocompatible
set hlsearch
set incsearch
set ignorecase
set backspace=start,indent,eol
set showmode
set ruler
set nojoinspaces
set modelines=0
set title
set runtimepath=~/.vim,$VIMRUNTIME
set showmatch
set nowrap
set showcmd
set ttyfast
set noswapfile
set laststatus=2
set splitbelow
set foldmethod=indent
set foldlevel=25
set wildmode=longest,list
set textwidth=79
set visualbell t_vb=
set shellslash
set ch=2
set lazyredraw
set virtualedit=all
set diffopt+=iwhite
" set stl=%f\ %m\ %r\ Line:%l/%L[%p%%]\ Col:%c\ Buf:%n\ [%b][0x%B]
set browsedir=buffer

" indenting
set tabstop=4
set shiftwidth=4
set smarttab
set expandtab
set softtabstop=4
set smartcase
set smartindent
set autoindent

" tags
set tags+=tags;
set complete=.,w,b,t
set showfulltag

"set nojoinspaces
set showfulltag
set report=0
set shortmess-=aI
set shortmess+=T

set listchars=tab:>-,trail:.,extends:+,eol:$,precedes:+
set keymodel-=stopsel
set selection=inclusive

" commenter
let EnhCommentifyPretty = "yes"
let EnhCommentifyRespectIndent = "yes"
let EnhCommentifyUseBlockIndent = "yes"

" keys
let mapleader = "\<Space>"
nmap <leader>l :silent nohl<CR>
nnoremap <leader>p :NERDTreeToggle<cr>
nnoremap <Leader>w :w<CR>
nnoremap <Leader>o :CtrlP<CR>
nnoremap <Leader>d :bd<CR>

vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P
nmap <Leader><Leader> V
nmap <c-k> 3k
nmap <c-j> 3j
nmap <c-l> $
nmap <c-h> 0
