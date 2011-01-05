let g:author='Sergej Braznikov'
let g:email='<sergej.braznikov@symmetrics.de>'

filetype on
filetype plugin on 
filetype indent on
syntax on

set guifont=Monaco:h12
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
set stl=%f\ %m\ %r\ Line:%l/%L[%p%%]\ Col:%c\ Buf:%n\ [%b][0x%B]
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

" colors
colorscheme desert

" php
let php_noShortTags = 1
autocmd BufRead *.php set makeprg=php\ -l\ %
autocmd BufRead *.php set errorformat=%m\ in\ %f\ on\ line\ %l

" commenter
let EnhCommentifyPretty = "yes"
let EnhCommentifyRespectIndent = "yes"
let EnhCommentifyUseBlockIndent = "yes"

" python
let python_highlight_all = 1
autocmd BufRead *.py set makeprg=python\ -c\ \"import\ py_compile,sys;\ sys.stderr=sys.stdout;\ py_compile.compile(r'%')\"
autocmd BufRead *.py set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m

" omnicomplete
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd BufRead *.py set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class

" keys
let mapleader = ","
nmap <leader>l :silent nohl<CR>
nmap <leader>t <c-]>
nmap <leader>r :%s/\<<c-r>=expand("<cword>")<cr>\>/
nmap <c-k> 3k
nmap <c-j> 3j
nmap <c-l> $
nmap <c-h> 0
nmap <c-t> :tabnew
nmap <c-b> :bn<CR>
nmap X ci"
map <c-t> :e **/
vmap < <gv
vmap > >gv
vmap > >gv
nmap <silent> ,gw
     \ :vimgrep /<C-r><C-w>/ %<CR>:ccl<CR>:cwin<CR><C-W>J:set nohls<CR>

