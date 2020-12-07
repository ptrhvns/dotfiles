set nocompatible

let mapleader="\\"

set autoindent
set autoread
set hlsearch
set ignorecase
set lazyredraw
set nofoldenable
set noincsearch
set nojoinspaces
set nolist
set nonumber
set norelativenumber
set noshowmode
set nostartofline
set shell=/bin/bash
set shiftwidth=4
set showcmd
set sidescroll=1
set smartcase
set smarttab
set softtabstop=4
set splitbelow
set splitright
set tabstop=4
set textwidth=79
set timeout
set timeoutlen=3000
set ttimeoutlen=100
set ttyfast
set undolevels=1000
set virtualedit=all
set visualbell
set wildmenu

if exists('+undoreload')
    set undoreload=10000
endif

if has("multi_byte") && &t_Co > 255
    set encoding=utf-8
    set fillchars=diff:⣿
    set list
    set listchars=tab:▸\ ,trail:⋅,extends:❯,precedes:❮
endif

nnoremap <C-l> :nohlsearch<CR><C-l>
inoremap <C-l> <C-o>:nohlsearch<CR>

nmap <Leader>p :set invpaste paste?<CR>

nmap <Leader>w :set invwrap wrap?<CR>

nmap <Leader>u :setlocal cursorcolumn! cursorline!<CR><C-l>

vmap <Leader>s :sort iu<CR>

nmap <Left> gT
nmap <Right> gt
nmap <Down> :tabmove -1<CR><C-l>
nmap <Up> :tabmove +1<CR><C-l>

nmap K <Nop>

nmap <Leader>ev :tabedit $HOME/src/personal/remote/dotfiles/vimrc<CR>
nmap <Leader>sv :source $MYVIMRC<CR>

nmap <Leader>$ :set list! number!<CR><C-l>

nmap <Leader>W :%s/\s\+$//<CR>:let @/=''<CR>

function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
        exec ':edit'
    endif
endfunction

nmap <Leader>R :call RenameFile()<CR>

function! DeleteFile()
    let fname = expand('%')
    exec ':bdelete!'
    exec ':silent !rm -f ' . fname
    redraw!
endfunction

nmap <Leader>D :call DeleteFile()<CR>

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
    elseif (&filetype == 'go')
        execute "!clear; gofmt -w " . t:file
    elseif (&filetype == 'javascript')
        execute "!clear; npx prettier --single-quote --write " . t:file
    elseif (&filetype == 'javascript.html.css')
        execute "!clear; npx prettier --single-quote --write " . t:file
    elseif (&filetype == 'json')
        execute "!clear; npx prettier --single-quote --write " . t:file
    elseif (&filetype == 'python')
        execute "!clear; isort --ac --fas " . t:file . " && black " . t:file . " && flake8 --ignore=E231,E501 " . t:file
        " Ensure black changes are seen.
        :edit
    elseif (&filetype == 'rust')
        execute "!clear; rustfmt " . t:file
    elseif (&filetype == 'scss')
        execute "!clear; npx prettier --write " . t:file
    else
        echoerr "Failed to format: unknown filetype: " . &filetype
    endif
endfunction

nmap <Leader>f :call FormatFile()<CR>

try
    call pathogen#infect()
catch /^Vim\%((\a\+)\)\=:E/
    " Ignore errors if pathogen can't be found.
endtry

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
        highlight IncSearch term=reverse cterm=reverse ctermbg=White ctermfg=Red guibg=Yellow
        highlight Search term=reverse cterm=reverse ctermbg=White ctermfg=Red guibg=Yellow
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

    autocmd BufNewFile,BufRead supervisord.conf setlocal filetype=dosini
    autocmd BufRead,BufNewFile *.js setlocal filetype=javascript.html.css
    autocmd BufRead,BufNewFile .babelrc setlocal filetype=json
    autocmd BufRead,BufNewFile .bowerrc setlocal filetype=json
    autocmd BufReadPost fugitive://* set bufhidden=delete
    autocmd FileType gitcommit setlocal nolist
    autocmd FileType go setlocal noexpandtab
    autocmd FileType go setlocal nolist
    autocmd FileType go setlocal shiftwidth=0
    autocmd FileType go setlocal tabstop=4
    autocmd FileType gomod setlocal noexpandtab
    autocmd FileType gomod setlocal nolist
    autocmd FileType gomod setlocal shiftwidth=0
    autocmd FileType gomod setlocal tabstop=4
    autocmd FileType help setlocal nolist
    autocmd FileType html setlocal expandtab
    autocmd FileType html setlocal shiftwidth=0
    autocmd FileType html setlocal tabstop=2
    autocmd FileType htmldjango setlocal expandtab
    autocmd FileType htmldjango setlocal shiftwidth=0
    autocmd FileType htmldjango setlocal tabstop=4
    autocmd FileType nerdtree setlocal nolist
    autocmd FileType python setlocal expandtab
    autocmd FileType python setlocal shiftwidth=0
    autocmd FileType python setlocal tabstop=4
    autocmd FileType python setlocal textwidth=88
    autocmd FileType rust setlocal expandtab
    autocmd FileType rust setlocal shiftwidth=0
    autocmd FileType rust setlocal tabstop=4
    autocmd FileType scss setlocal iskeyword+=-
    autocmd FileType sh setlocal expandtab
    autocmd FileType sh setlocal shiftwidth=0
    autocmd FileType sh setlocal tabstop=4
    autocmd FileType snippets setlocal list
    autocmd FileType text setlocal nolist
    autocmd FileType text setlocal spell
    autocmd InsertLeave * set nopaste

augroup end

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
let g:snippets_dir=$HOME.'/.vim/snippets'
nmap <Leader>es :tabedit $HOME/src/personal/remote/dotfiles/vim/snippets/

" lightline
set laststatus=2

let g:lightline = {
    \ 'colorscheme': 'solarized',
    \ 'component_function': {
    \   'filename': 'LightlineFilename',
    \ }
\ }

function! LightlineFilename()
  return expand('%:t') !=# '' ? @% : '[No Name]'
endfunction

" fugitive
nmap <Leader>gb :Gblame<CR>
nmap <Leader>gc :Gcommit --verbose<CR>
nmap <Leader>gd :Gdiff<CR>
nmap <Leader>gp :Gpush --verbose<CR>
nmap <Leader>gs :Gstatus<CR>
nmap <Leader>gw :Gwrite<CR>

" ctrlp
let g:ctrlp_arg_map = 1
let g:ctrlp_custom_ignore = {
    \ 'dir': '\v(\.git|node_modules|dist|__pycache__|egg-info|static|target)',
    \ 'file': '\v\.(swp|pyc)'
    \ }
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0

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

" vim-go
nmap <Leader>od <Plug>(go-doc)
nmap <Leader>oi <Plug>(go-info)
nmap <Leader>om <Plug>(go-metalinter)
nmap <Leader>or <Plug>(go-rename)
nmap <Leader>os <Plug>(go-def-split)
nmap <Leader>ot <Plug>(go-test-func)
nmap <Leader>ov <Plug>(go-vet)

" rust
nmap <Leader>rb :Cbuild<CR>
nmap <Leader>rc :Cargo check<CR>
nmap <Leader>rr :Crun<CR>
