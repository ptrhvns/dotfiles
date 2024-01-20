set nocompatible

let mapleader="\\"

set autoindent
set autoread
set background=dark
set backspace=indent,eol,start
set belloff=all
set clipboard="unnamed"
set expandtab
set hidden
set history=10000
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set lazyredraw
set list
set nofoldenable
set nojoinspaces
set noshowmode
set nostartofline
set notimeout
set number
set relativenumber
set shell=/bin/bash
set shiftwidth=0
set showcmd
set sidescroll=1
set smartcase
set smarttab
set softtabstop=4
set splitbelow
set splitright
set tabstop=4
set textwidth=80
set ttyfast
set undolevels=1000
set virtualedit=all
set wildmenu

if has("multi_byte")
    set encoding=utf-8
endif

if v:version > 703 || v:version == 703 && has("patch541")
  set formatoptions+=j
endif

if exists("+undoreload")
    set undoreload=10000
endif

if has("multi_byte") && &t_Co > 255
    set fillchars=diff:⣿
    set listchars=extends:❯,nbsp:~,precedes:❮,tab:▸\ ,trail:⋅
else
    set listchars=extends:>,nbsp:+,precedes:<,tab:>\ ,trail:-
endif

nnoremap <C-l> :nohlsearch<CR><C-l>
inoremap <C-l> <C-o>:nohlsearch<CR>

nmap <Leader>ip :set invpaste paste?<CR>

nmap <Leader>iw :set invwrap wrap?<CR>

nmap <Leader>u :setlocal cursorcolumn! cursorline!<CR><C-l>

vmap <Leader>sd :sort! n<CR>
vmap <Leader>ss :sort iu<CR>

nmap K <Nop>

nmap <Leader>ve :tabedit $MYVIMRC<CR>
nmap <Leader>vs :source $MYVIMRC<CR>

nmap <Leader>$ :set list! number! relativenumber!<CR><C-l>

nmap <Leader>W :%s/\s\+$//<CR>:let @/=''<CR>

if &t_Co > 1 || has("gui_running")
    syntax on
endif

colorscheme slate

filetype indent on
filetype plugin on

augroup ag_all
    autocmd!

    autocmd FileType gitcommit setlocal nolist
    autocmd FileType sh setlocal softtabstop=4
    autocmd FileType text setlocal textwidth=80
    autocmd InsertLeave * setlocal nopaste

augroup end
