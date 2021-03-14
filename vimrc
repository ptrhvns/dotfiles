set nocompatible

let mapleader="\\"

set autoindent
set autoread
set expandtab
set hlsearch
set ignorecase
set incsearch
set lazyredraw
set nofoldenable
set nojoinspaces
set nolist
set nonumber
set norelativenumber
set noshowmode
set nostartofline
set notimeout
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
set ttyfast
set undolevels=1000
set virtualedit=all
set visualbell
set wildmenu

if exists('+undoreload')
    set undoreload=10000
endif

if has("multi_byte")
    set encoding=utf-8
endif

if has("multi_byte") && &t_Co > 255
    set fillchars=diff:⣿
    set list
    set listchars=extends:❯,nbsp:~,precedes:❮,tab:▸\ ,trail:⋅
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

nmap <Leader>so :source %<CR>

nmap <Leader>$ :set list! number!<CR><C-l>

nmap <Leader>W :%s/\s\+$//<CR>:let @/=''<CR>

function! RunTestUnderCursor()
    :write

    if (match(expand("%"), '\.feature\|test\|spec\|mocha') != -1)
        let t:test_file = @%
        let t:test_line_number = line('.')
    endif

    execute "!clear; run_test " . t:test_file . " -t " . t:test_line_number
endfunction

nmap <Leader>t :call RunTestUnderCursor()<CR>

function! RunTestFile()
    :write

    if (match(expand("%"), '\.feature\|test\|spec\|mocha') != -1)
        let t:test_file = @%
    endif

    execute "!clear; run_test " . t:test_file
endfunction

nmap <Leader>T :call RunTestFile()<CR>

function! FormatFile()
    :write
    let t:file = @%

    if (&filetype == 'css')
        execute "!clear; npx prettier --write " . t:file
    elseif (&filetype == 'javascript')
        execute "!clear; npx prettier --single-quote --write " . t:file
    elseif (&filetype == 'json')
        execute "!clear; npx prettier --single-quote --write " . t:file
    elseif (&filetype == 'go')
        execute "!clear; goimports -w " . t:file
    elseif (&filetype == 'python')
        execute "!clear; isort --ac " . t:file . " && black " . t:file . " && flake8 --ignore=E231,E501 " . t:file
        " Ensure black changes are seen.
        :edit
        :normal zz
    elseif (&filetype == 'ruby')
        " execute "!clear; bundle exec rubocop --auto-correct " . t:file
        execute "!clear; bundle exec standardrb --fix " . t:file
    elseif (&filetype == 'rust')
        execute "!clear; rustfmt " . t:file
    elseif (&filetype == 'scss')
        execute "!clear; npx prettier --write " . t:file
    else
        echoerr "Failed to format: unknown filetype: " . &filetype
    endif
endfunction

nmap <Leader>f :call FormatFile()<CR>

" curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"   https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
if filereadable(expand('~/.vim/autoload/plug.vim'))
    call plug#begin('~/.vim/plugged')

    Plug 'https://github.com/altercation/vim-colors-solarized.git'
    Plug 'https://github.com/bkad/CamelCaseMotion.git'
    Plug 'https://github.com/cakebaker/scss-syntax.vim.git'
    Plug 'https://github.com/fatih/vim-go', { 'do': ':GoUpdateBinaries' }
    Plug 'https://github.com/garbas/vim-snipmate.git'
    Plug 'https://github.com/godlygeek/tabular.git'
    Plug 'https://github.com/henrik/vim-indexed-search.git'
    Plug 'https://github.com/itchyny/lightline.vim'
    Plug 'https://github.com/jamessan/vim-gnupg.git'
    Plug 'https://github.com/kana/vim-smartinput.git'
    Plug 'https://github.com/MarcWeber/vim-addon-mw-utils.git'
    Plug 'https://github.com/romainl/vim-cool.git'
    Plug 'https://github.com/scrooloose/nerdcommenter.git'
    Plug 'https://github.com/scrooloose/nerdtree.git'
    Plug 'https://github.com/sheerun/vim-polyglot'
    Plug 'https://github.com/tomtom/tlib_vim.git'
    Plug 'https://github.com/tpope/vim-eunuch.git'
    Plug 'https://github.com/tpope/vim-fugitive.git'
    Plug 'https://github.com/tpope/vim-repeat.git'
    Plug 'https://github.com/tpope/vim-surround.git'

    if executable("fzf")
        Plug 'https://github.com/junegunn/fzf', { 'do': { -> fzf#install() } }
        Plug 'https://github.com/junegunn/fzf.vim'
    else
        Plug 'https://github.com/kien/ctrlp.vim.git'
    endif

    call plug#end()
endif

map <Leader>vn Ovim:ft=notes<Esc>:set ft=notes<CR><C-l>

map <Leader>hd O{# htmldjango #}<Esc>:set ft=htmldjango<CR>

if &t_Co > 1 || has('gui_running')
    syntax on
endif

set background=dark

if &t_Co > 255
    let g:solarized_termcolors=256
elseif &t_Co > 15
    let g:solarized_termcolors=16
endif

let g:solarized_termtrans=1

try
    if &t_Co > 15
        colorscheme solarized
        highlight IncSearch ctermbg=White ctermfg=DarkGrey
        highlight Search ctermbg=White ctermfg=DarkGrey
        highlight Visual ctermbg=White ctermfg=DarkGrey
    endif
catch /^Vim\%((\a\+)\)\=:E185/
    colorscheme default
endtry

if exists("g:colors_name") && g:colors_name == 'solarized' && has("multi_byte")
    highlight! NonText ctermfg=235
endif

filetype indent on
filetype plugin on

augroup ag_all
    autocmd!

    " autocmd BufRead,BufNewFile *.js setlocal filetype=javascript.html.css
    " autocmd FileType javascript.html.css setlocal softtabstop=2
    " autocmd FileType javascript.html.css setlocal tabstop=2
    " autocmd FileType notes setlocal spell
    autocmd BufNewFile,BufRead .babelrc setlocal filetype=json
    autocmd BufNewFile,BufRead .bowerrc setlocal filetype=json
    autocmd BufNewFile,BufRead supervisord.conf setlocal filetype=dosini
    autocmd BufReadPost fugitive://* setlocal bufhidden=delete
    autocmd FileType css setlocal softtabstop=2
    autocmd FileType css setlocal tabstop=2
    autocmd FileType eruby setlocal softtabstop=2
    autocmd FileType eruby setlocal tabstop=2
    autocmd FileType gitcommit setlocal nolist
    autocmd FileType go setlocal noexpandtab
    autocmd FileType go setlocal nolist
    autocmd FileType go setlocal softtabstop=4
    autocmd FileType go setlocal tabstop=4
    autocmd FileType gomod setlocal noexpandtab
    autocmd FileType gomod setlocal nolist
    autocmd FileType gomod setlocal softtabstop=4
    autocmd FileType gomod setlocal tabstop=4
    autocmd FileType html setlocal tabstop=2
    autocmd FileType htmldjango setlocal softtabstop=2
    autocmd FileType htmldjango setlocal tabstop=2
    autocmd FileType javascript setlocal softtabstop=2
    autocmd FileType javascript setlocal tabstop=2
    autocmd FileType markdown setlocal softtabstop=2
    autocmd FileType markdown setlocal tabstop=2
    autocmd FileType python setlocal softtabstop=4
    autocmd FileType ruby setlocal softtabstop=2
    autocmd FileType ruby setlocal tabstop=2
    autocmd FileType rust setlocal softtabstop=4
    autocmd FileType scss setlocal iskeyword+=-
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
let NERDDefaultAlign = 'left'
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
let g:snipMate = { 'snippet_version' : 1 }
let g:snippets_dir=$HOME.'/.vim/snippets'
nmap <Leader>es :tabedit $HOME/src/personal/remote/dotfiles/vim/snippets/

" lightline
set laststatus=2

let g:lightline = {
    \ 'colorscheme': 'solarized',
    \ 'component_function': {
    \   'filename': 'LightlineFilename',
    \ },
    \ 'enable': { 'tabline': 0 },
\ }

function! LightlineFilename()
  return expand('%:t') !=# '' ? @% : '[No Name]'
endfunction

" fugitive
nmap <Leader>gb :Git blame<CR>
nmap <Leader>gc :Git commit --verbose<CR>
nmap <Leader>gd :Gitdiffsplit<CR>
nmap <Leader>gp :Git push --verbose<CR>
nmap <Leader>gs :Git<CR>
nmap <Leader>gw :Gwrite<CR>

" dragvisuals
let g:DVB_TrimWS = 1
vmap  <expr>  <LEFT>   DVB_Drag('left')
vmap  <expr>  <RIGHT>  DVB_Drag('right')
vmap  <expr>  <DOWN>   DVB_Drag('down')
vmap  <expr>  <UP>     DVB_Drag('up')
vmap  <expr>  D        DVB_Duplicate()

" json
let g:vim_json_syntax_conceal = 0
let g:vim_json_warnings = 1

" CamelCaseMotion
map <silent> ,b <Plug>CamelCaseMotion_b
map <silent> ,w <Plug>CamelCaseMotion_w

" rust
nmap <Leader>rb :Cbuild<CR>
nmap <Leader>rc :Cargo check<CR>
nmap <Leader>rr :Crun<CR>

if executable("fzf")
    " fzf
    nmap <C-p> :Files<CR>
else
    " ctrlp
    let g:ctrlp_arg_map = 1
    let g:ctrlp_custom_ignore = {
        \ 'dir': '\v(\.git|node_modules|dist|__pycache__|egg-info|static|target|cache)',
        \ 'file': '\v(\.(swp|pyc)|tags)'
        \ }
    let g:ctrlp_switch_buffer = 0
    let g:ctrlp_working_path_mode = 0
endif

" vim-go
nmap <Leader>ol :GoMetaLinter<CR>

" let g:go_metalinter_enabled = ['vet', 'errcheck']
let g:go_fmt_autosave = 0
let g:go_imports_autosave = 0
let g:go_metalinter_command = "golangci-lint"
let g:go_template_autocreate = 0
