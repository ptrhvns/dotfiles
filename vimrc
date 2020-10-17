set nocompatible

let mapleader="\\"

set autoindent
set hlsearch
set ignorecase
set nofoldenable
set nojoinspaces
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
set textwidth=79
set timeout timeoutlen=3000 ttimeoutlen=100
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

" Clear highlighting and redraw.
nnoremap <C-l> :nohlsearch<CR><C-l>
inoremap <C-l> <C-o>:nohlsearch<CR>

" Toggle paste mode and show result.
nmap <Leader>p :set invpaste paste?<CR>

" Toggle line wrapping and show result.
nmap <Leader>w :set invwrap wrap?<CR>

" Toggle highlight the current line of the cursor.
nmap <Leader>u :setlocal list! cursorcolumn! cursorline!<CR><C-l>

" Sort visual selection.
vmap <Leader>s :sort iu<CR>

" Control tabs.
nmap <Left> gT
nmap <Right> gt
nmap <Down> :tabmove -1<CR><C-l>
nmap <Up> :tabmove +1<CR><C-l>

" Remove keywork lookup.
nnoremap K <Nop>

" Manage vimrc file.
nmap <Leader>ev :tabedit $HOME/src/personal/remote/dotfiles/vimrc<CR>
nmap <Leader>sv :source $MYVIMRC<CR>

" Toggle list and number.
nmap <Leader>$ :set list! number!<CR><C-l>

" Remove trailing whitespace.
nmap <Leader>W :%s/\s\+$//<CR>:let @/=''<CR>

" Rename the current buffer file.
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

" Delete the current buffer file.
function! DeleteFile()
    let fname = expand('%')
    exec ':bdelete!'
    exec ':silent !rm -f ' . fname
    redraw!
endfunction

nmap <Leader>D :call DeleteFile()<CR>

" Run tests.
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

" Format current buffer file.
function! FormatFile()
    :write
    let t:file = @%

    if (&filetype == 'css')
        execute "!clear; npx prettier --write " . t:file
    elseif (&filetype == 'javascript')
        execute "!clear; npx prettier --single-quote --write " . t:file
    elseif (&filetype == 'javascript.jsx')
        execute "!clear; npx prettier --single-quote --write " . t:file
    elseif (&filetype == 'json')
        execute "!clear; npx prettier --single-quote --write " . t:file
    elseif (&filetype == 'python')
        execute "!clear; isort --atomic " . t:file . " && black " . t:file . " && flake8 --ignore=E231,E501 " . t:file
    elseif (&filetype == 'scss')
        execute "!clear; npx prettier --write " . t:file
    elseif (&filetype == 'vue.html.javascript.css')
        execute "!clear; npx prettier --single-quote --write " . t:file
    else
        echoerr "Failed to format unknown filetype: " . &filetype
    endif
endfunction

noremap <Leader>f :call FormatFile()<CR>

" Configure Pathogen plugin manager.
try
    call pathogen#infect()
catch /^Vim\%((\a\+)\)\=:E/
    " Ignore errors if pathogen can't be found.
endtry

" Configure a notes file.
map <Leader>vn Ovim:ft=notes<Esc>:set ft=notes<CR><C-l>

" Set a marker for Django HTML templates.
map <Leader>hd O{# htmldjango #}<Esc>:set ft=htmldjango<CR>

" Color & syntax settings.
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
        highlight Search term=reverse cterm=reverse ctermbg=Black ctermfg=Yellow guibg=Yellow
    endif
catch /^Vim\%((\a\+)\)\=:E185/
    colorscheme default
endtry

if exists("g:colors_name") && g:colors_name == 'solarized' && has("multi_byte")
    highlight! NonText ctermfg=235
endif

" Enable filetype specific indenting.
filetype indent on

" Enable filetype specific plugins.
filetype plugin on

augroup ag_all
    autocmd!

    autocmd BufNewFile,BufRead supervisord.conf setlocal filetype=dosini
    autocmd BufRead * normal zz
    autocmd BufRead,BufNewFile *.vue setlocal filetype=vue.html.javascript.css
    autocmd BufRead,BufNewFile .babelrc setlocal filetype=json
    autocmd BufRead,BufNewFile .bowerrc setlocal filetype=json
    autocmd BufRead,BufNewFile .sequelizerc setlocal filetype=javascript
    autocmd BufReadPost fugitive://* set bufhidden=delete
    autocmd FileType c setlocal noexpandtab
    autocmd FileType c setlocal nolist
    autocmd Filetype c setlocal omnifunc=ccomplete#Complete
    autocmd FileType c setlocal shiftwidth=8
    autocmd FileType c setlocal softtabstop=0
    autocmd FileType css setlocal expandtab
    autocmd FileType css setlocal iskeyword+=-
    autocmd FileType css setlocal omnifunc=csscomplete#Complete
    autocmd FileType css setlocal shiftwidth=2
    autocmd FileType css setlocal softtabstop=2
    autocmd FileType Gemfile setlocal expandtab
    autocmd FileType Gemfile setlocal shiftwidth=2
    autocmd FileType Gemfile setlocal softtabstop=2
    autocmd FileType gitcommit setlocal expandtab
    autocmd FileType gitcommit setlocal nolist
    autocmd FileType gitcommit setlocal shiftwidth=8
    autocmd FileType gitcommit setlocal softtabstop=8
    autocmd FileType gitconfig setlocal expandtab
    autocmd FileType gitconfig setlocal shiftwidth=8
    autocmd FileType gitconfig setlocal softtabstop=8
    autocmd FileType help setlocal nolist
    autocmd FileType html setlocal expandtab
    autocmd FileType html setlocal omnifunc=htmlcomplete#Complete
    autocmd FileType html setlocal shiftwidth=2
    autocmd FileType html setlocal softtabstop=2
    autocmd FileType htmldjango setlocal expandtab
    autocmd FileType htmldjango setlocal shiftwidth=2
    autocmd FileType htmldjango setlocal softtabstop=2
    autocmd FileType htmldjango setlocal tabstop=2
    autocmd FileType javascript setlocal expandtab
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#Complete
    autocmd FileType javascript setlocal shiftwidth=2
    autocmd FileType javascript setlocal softtabstop=2
    autocmd FileType json setlocal expandtab
    autocmd FileType json setlocal shiftwidth=2
    autocmd FileType json setlocal softtabstop=2
    autocmd FileType markdown setlocal expandtab
    autocmd FileType markdown setlocal shiftwidth=2
    autocmd FileType markdown setlocal softtabstop=2
    autocmd FileType nerdtree setlocal nolist nonumber
    autocmd FileType python setlocal autoindent
    autocmd FileType python setlocal expandtab
    autocmd FileType python setlocal fileformat=unix
    autocmd FileType python setlocal shiftwidth=4
    autocmd FileType python setlocal softtabstop=4
    autocmd FileType python setlocal tabstop=4
    autocmd FileType python setlocal textwidth=88
    autocmd FileType scss imap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a
    autocmd FileType scss setlocal expandtab
    autocmd FileType scss setlocal iskeyword+=-
    autocmd FileType scss setlocal omnifunc=csscomplete#Complete
    autocmd FileType scss setlocal shiftwidth=2
    autocmd FileType scss setlocal softtabstop=2
    autocmd FileType sh setlocal expandtab
    autocmd FileType sh setlocal shiftwidth=4
    autocmd FileType sh setlocal softtabstop=4
    autocmd FileType sql setlocal expandtab
    autocmd FileType sql setlocal omnifunc=sqlcomplete#Complete
    autocmd FileType sql setlocal shiftwidth=2
    autocmd FileType sql setlocal softtabstop=2
    autocmd FileType text setlocal nolist
    autocmd FileType text setlocal norelativenumber
    autocmd FileType text setlocal spell
    autocmd FileType vim setlocal expandtab
    autocmd FileType vim setlocal shiftwidth=4
    autocmd FileType vim setlocal softtabstop=4
    autocmd FileType vue.html.javascript.css setlocal expandtab
    autocmd FileType vue.html.javascript.css setlocal shiftwidth=2
    autocmd FileType vue.html.javascript.css setlocal softtabstop=2
    autocmd FileType xml setlocal expandtab
    autocmd FileType xml setlocal omnifunc=xmlcomplete#Complete
    autocmd FileType xml setlocal shiftwidth=4
    autocmd FileType xml setlocal softtabstop=4
    autocmd FileType yaml setlocal expandtab
    autocmd FileType yaml setlocal shiftwidth=2
    autocmd FileType yaml setlocal softtabstop=2
    autocmd InsertLeave * set nopaste
    autocmd VimResized * :wincmd =

augroup end

" NERD_commenter settings
let NERDCommentWholeLinesInVMode=2
let NERDCreateDefaultMappings=0
let NERDDefaultAlign = 'left'
let NERDSpaceDelims=1
let NERD_scss_alt_style=1
nmap <Leader>c <Plug>NERDCommenterToggle<C-l>
nmap <Leader>i <Plug>NERDCommenterAltDelims<C-l>
nmap <Leader>x <Plug>NERDCommenterSexy<C-l>
vmap <Leader>c <Plug>NERDCommenterToggle<C-l>
vmap <Leader>x <Plug>NERDCommenterSexy<C-l>

" NERD_tree settings
let NERDChristmasTree=1
let NERDTreeDirArrows= has("multi_byte") ? 1 : 0
let NERDTreeQuitOnOpen=1
let NERDTreeWinSize=50
nmap <Leader>n :NERDTreeToggle<CR>

" gnupg settings
let g:GPGExecutable="gpg"
let g:GPGPreferArmor=1

" snipmate settings
let g:snippets_dir=$HOME.'/.vim/snippets'
nmap <Leader>es :tabedit $HOME/src/personal/remote/dotfiles/vim/snippets/

" lightline settings
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

" fugitive settings
nnoremap <Leader>gb :Gblame<CR>
nnoremap <Leader>gc :Gcommit --verbose<CR>
nnoremap <Leader>gd :Gdiff<CR>
nnoremap <Leader>gp :Gpush --verbose<CR>
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>gw :Gwrite<CR>

" ctrlp settings
let g:ctrlp_arg_map = 1
let g:ctrlp_custom_ignore = {
    \ 'dir': '\v(\.git|node_modules|dist|__pycache__|egg-info|static)',
    \ 'file': '\v\.(swp|pyc)'
    \ }
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0

" dragvisuals settings
let g:DVB_TrimWS = 1
vmap  <expr>  <LEFT>   DVB_Drag('left')
vmap  <expr>  <RIGHT>  DVB_Drag('right')
vmap  <expr>  <DOWN>   DVB_Drag('down')
vmap  <expr>  <UP>     DVB_Drag('up')
vmap  <expr>  D        DVB_Duplicate()

" json settings
let g:vim_json_syntax_conceal = 0
let g:vim_json_warnings = 1

" CamelCaseMotion
map <silent> ,b <Plug>CamelCaseMotion_b
map <silent> ,w <Plug>CamelCaseMotion_w
