set nocompatible

let mapleader="\\"

set autoindent
set autoread
set background=dark
set backspace=indent,eol,start
set belloff=all
set clipboard="unnamed"
set completeopt="menu,menuone,preview,noselect"
set expandtab
set hidden
set history=10000
set hlsearch
set ignorecase
set incsearch
set iskeyword+=-
set laststatus=2
set lazyredraw
set list
set nofoldenable
set nojoinspaces
set nolist
set noshowmode
set nostartofline
set notimeout
set novisualbell
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

nmap <Leader>p :set invpaste paste?<CR>

nmap <Leader>w :set invwrap wrap?<CR>

nmap <Leader>u :setlocal cursorcolumn! cursorline!<CR><C-l>

vmap <Leader>sd :sort! n<CR>
vmap <Leader>ss :sort iu<CR>

nmap <Left> gT
nmap <Right> gt
nmap <Down> :tabmove -1<CR><C-l>
nmap <Up> :tabmove +1<CR><C-l>

nmap K <Nop>

nmap <Leader>ev :tabedit $HOME/src/personal/remote/dotfiles/vimrc<CR>

nmap <Leader>so :source $MYVIMRC<CR>

nmap <Leader>$ :set list! number! relativenumber!<CR><C-l>

nmap <Leader>W :%s/\s\+$//<CR>:let @/=''<CR>

vmap < <gv
vmap > >gv

function FormatFile()
    write
    let t:file = @%

    if (&filetype == "css")
        execute "!clear && npx prettier --write " . t:file
    elseif (&filetype == "html")
        execute "!clear && npx prettier --write " . t:file
    elseif (&filetype == "htmldjango")
        execute "!clear && npx prettier --write " . t:file
    elseif (&filetype == "javascript")
        execute "!clear && npx prettier --write " . t:file
    elseif (&filetype == "javascriptreact")
        execute "!clear && npx prettier --write " . t:file
    elseif (&filetype == "json")
        execute "!clear && npx prettier --write " . t:file
    elseif (&filetype == "jsonc")
        execute "!clear && npx prettier --write " . t:file
    elseif (&filetype == "markdown")
        execute "!clear && npx prettier --write " . t:file
    elseif (&filetype == "python")
        execute "!clear && black " . t:file)
    elseif (&filetype == "scss")
        execute "!clear && npx prettier --write " . t:file
    else
        echo "Failed to format: unknown filetype: " . &filetype
        return
    endif

    checktime
endfunction

nmap <Leader>f :call FormatFile()<CR>

if empty(glob("~/.vim/autoload/plug.vim"))
    if executable("curl")
        silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
          \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif
endif

if filereadable(expand("~/.vim/autoload/plug.vim"))
    call plug#begin("~/.vim/plugged")

    Plug 'altercation/vim-colors-solarized'
    Plug 'bkad/CamelCaseMotion'
    Plug 'cakebaker/scss-syntax.vim'
    Plug 'garbas/vim-snipmate'
    Plug 'henrik/vim-indexed-search'
    Plug 'itchyny/lightline.vim'
    Plug 'jamessan/vim-gnupg'
    Plug 'kana/vim-smartinput'
    Plug 'MarcWeber/vim-addon-mw-utils'
    Plug 'preservim/nerdcommenter'
    Plug 'preservim/nerdtree'
    Plug 'scrooloose/nerdcommenter'
    Plug 'sheerun/vim-polyglot'
    Plug 'tomtom/tlib_vim'
    Plug 'tpope/vim-eunuch'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-surround'

    if executable("fzf")
        Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
        Plug 'junegunn/fzf.vim'
    else
        Plug 'kien/ctrlp.vim'
    endif

    call plug#end()
endif

nmap <Leader>vn Ovim:ft=notes<Esc>:set ft=notes<CR><C-l>

nmap <Leader>dt O{# Django template #}<Esc>:set ft=htmldjango<CR>

if &t_Co > 1 || has("gui_running")
    syntax on
endif

if &t_Co > 255
    let g:solarized_termcolors=256
elseif &t_Co > 15
    let g:solarized_termcolors=16
endif

let g:solarized_termtrans=1

try
    if &t_Co > 15
        colorscheme solarized
    endif
catch /^Vim\%((\a\+)\)\=:E185/
    colorscheme default
endtry

if exists("g:colors_name") && g:colors_name == "solarized" && has("multi_byte")
    highlight! NonText ctermfg=235
endif

" Only highlight absolute line number inside relative numbers.
highlight LineNr ctermfg=166 ctermbg=Black
highlight LineNrAbove ctermfg=239 ctermbg=Black
highlight LineNrBelow ctermfg=239 ctermbg=Black

filetype indent on
filetype plugin on

augroup ag_all
    autocmd!

    autocmd BufNewFile,BufRead .babelrc setlocal filetype=json
    autocmd BufNewFile,BufRead supervisord.conf setlocal filetype=dosini
    autocmd BufReadPost fugitive://* setlocal bufhidden=delete
    autocmd FileType css setlocal softtabstop=2
    autocmd FileType css setlocal tabstop=2
    autocmd FileType gitcommit setlocal nolist
    autocmd FileType html setlocal softtabstop=2
    autocmd FileType html setlocal tabstop=2
    autocmd FileType htmldjango setlocal softtabstop=2
    autocmd FileType htmldjango setlocal tabstop=2
    autocmd FileType javascript setlocal softtabstop=2
    autocmd FileType javascript setlocal tabstop=2
    autocmd FileType markdown setlocal softtabstop=2
    autocmd FileType markdown setlocal tabstop=2
    autocmd FileType notes setlocal textwidth=80
    autocmd FileType python setlocal softtabstop=4
    autocmd FileType python setlocal tabstop=4
    autocmd FileType scss setlocal iskeyword+=-
    autocmd FileType scss setlocal iskeyword+=@-@
    autocmd FileType scss setlocal softtabstop=2
    autocmd FileType scss setlocal tabstop=2
    autocmd FileType sh setlocal softtabstop=4
    autocmd FileType text setlocal textwidth=80
    autocmd FileType yaml setlocal expandtab
    autocmd InsertLeave * setlocal nopaste

augroup end

" plug
nmap <Leader>li :PlugInstall<CR>
nmap <Leader>lu :PlugUpgrade<CR>:PlugUpdate<CR>

" NERD_commenter
let NERD_scss_alt_style=1
let NERDCommentWholeLinesInVMode=2
let NERDCreateDefaultMappings=0
let NERDDefaultAlign = "left"
let NERDSpaceDelims=1
nmap <Leader>c <Plug>NERDCommenterToggle<C-l>
nmap <Leader>i <Plug>NERDCommenterAltDelims<C-l>
nmap <Leader>x <Plug>NERDCommenterSexy<C-l>
vmap <Leader>c <Plug>NERDCommenterToggle<C-l>
vmap <Leader>x <Plug>NERDCommenterSexy<C-l>

" NERD_tree
let NERDChristmasTree=1
let NERDTreeDirArrows= has("multi_byte") ? 1 : 0
let NERDTreeQuitOnOpen=1
let NERDTreeWinSize=50
nmap <Leader>n :NERDTreeToggle<CR>

" gnupg
let g:GPGExecutable="gpg"
let g:GPGPreferArmor=1

" snipmate
let g:snipMate = { "snippet_version" : 1 }
let g:snippets_dir = $HOME . "/.vim/snippets"
nmap <Leader>es :tabedit $HOME/src/personal/remote/dotfiles/vim/snippets/

" lightline
let g:lightline = {
    \ "colorscheme": "solarized",
    \ "component_function": {
    \   "filename": "LightlineFilename",
    \ },
    \ "enable": { "tabline": 0 },
\ }

function LightlineFilename()
  return expand("%:t") !=# "" ? @% : "[No Name]"
endfunction

" CamelCaseMotion
map <silent> ,b <Plug>CamelCaseMotion_b
map <silent> ,w <Plug>CamelCaseMotion_w

if executable("fzf")
    " fzf
    nmap <C-p> :Files<CR>
else
    " ctrlp
    let g:ctrlp_arg_map = 1
    let g:ctrlp_custom_ignore = {
        \ "dir": "\v(\.git|node_modules|dist|__pycache__|egg-info|static|target|cache)",
        \ "file": "\v(\.(swp|pyc)|tags)"
        \ }
    let g:ctrlp_switch_buffer = 0
    let g:ctrlp_working_path_mode = 0
endif

" fugitive
nmap <Leader>gb :Git blame<CR>
nmap <Leader>gc :Git commit --verbose<CR>
nmap <Leader>gd :Gitdiffsplit<CR>
nmap <Leader>gp :Git push --verbose<CR>
nmap <Leader>gs :Git<CR>
nmap <Leader>gw :Gwrite<CR>

" fzf
nmap <Leader>rg :Rg<CR>

" dragvisuals
let g:DVB_TrimWS = 1
vmap <expr><LEFT> DVB_Drag('left')
vmap <expr><RIGHT> DVB_Drag('right')
vmap <expr><DOWN> DVB_Drag('down')
vmap <expr><UP> DVB_Drag('up')
