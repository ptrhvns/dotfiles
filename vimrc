" GENERAL SETTINGS
" =============================================================


set nocompatible

let mapleader="\\"

set autoindent
set autoread
set backspace=indent,eol,start
" set clipboard=unnamedplus
set expandtab
set fileformat=unix
set hidden
set history=500
set hlsearch
set ignorecase
set laststatus=2
set lazyredraw
set matchpairs+=<:>
set modeline
set modelines=5
set mousehide
set noesckeys
set nofoldenable
set nojoinspaces
set nostartofline
" set number
set ruler
set shell=/bin/bash
set shiftround
set shiftwidth=4
set showcmd
set showmode
set sidescroll=1
set smartcase
set smarttab
set softtabstop=4
set splitbelow
set splitright
set textwidth=79
set timeout timeoutlen=3000 ttimeoutlen=100
set ttyfast

if exists('+undodir')
    set undodir=$HOME/.vim/undo
endif

set undolevels=1000

if exists('+undoreload')
    set undoreload=10000
endif

set virtualedit=all
set visualbell
set wildmenu
set winwidth=96
set wrapscan

if has("multi_byte") && &t_Co > 255
    set encoding=utf-8
    " set fillchars=diff:⣿
    set list
    " set listchars=tab:..,trail:.,extends:>,precedes:<,nbsp:~
    " set listchars=tab:▸\ ,eol:¬,trail:⋅,extends:❯,precedes:❮
    set listchars=tab:▸\ ,trail:⋅,extends:❯,precedes:❮

    " if exists('+relativenumber')
        " set relativenumber
    " end
endif

" Fix problems with dtterm TERM type.
if &term == "dtterm"
    set t_kb=
    set t_Co=256
    fixdel
endif

if has('gui_win32')
    set guifont=Consolas:h11:cANSI
endif

" MAPPINGS & FUNCTIONS
" =============================================================


" Clear highlighting and redraw.
nnoremap <C-l> :nohlsearch<CR><C-l>
inoremap <C-l> <C-o>:nohlsearch<CR>

" Call help on the word under cursor.
nnoremap <Leader>h :execute "help " . expand("<cword>")<CR>

" Toggle paste mode and show result.
nnoremap <Leader>p :set invpaste paste?<CR>

" Insert the current time.
imap <C-t> <C-r>=strftime("%H:%M - ")<CR>

" Insert the current date.
imap <C-d> <C-r>=strftime("%B %e, %Y")<CR>

" Write to the current file with root permissions via sudo.
cnoremap w!! w !sudo tee % >/dev/null<CR>

" Toggle line wrapping and show result.
nnoremap <Leader>w :set invwrap wrap?<CR>

" Toggle highlight the current line of the cursor.
nnoremap <Leader>u :setlocal list! cursorcolumn! cursorline!<CR><C-l>

" Toggle moving cursor to first non-blank of line and show result.
vnoremap <Leader>s :sort u<CR>

" Switch between tabs.
nnoremap <Right> gt
nnoremap <Left> gT

" Move tabs.
nnoremap <Down> :tabmove -1<CR><C-l>
nnoremap <Up> :tabmove +1<CR><C-l>

" Remove manual key.
nnoremap K <Nop>

" Edit my vimrc file.
nnoremap <Leader>ev :tabedit $MYVIMRC<CR>

" Align columns in a "table" (see tabular settings for conflicts).
vnoremap <Leader>ac :!column -t<CR>

" Source my vimrc file.
nnoremap <Leader>sv :source $MYVIMRC<CR>

" Save and load sessions to recover screen layout of files.
nmap <Leader>ss :mksession! ~/.vim/session <CR>
nmap <Leader>sl :source ~/.vim/session <CR>

" Toggle list, number, and relativenumber.
" if exists('+relativenumber')
    " nnoremap <Leader>$ :set list! number! relativenumber!<CR><C-l>
" else
    nnoremap <Leader>$ :set list! number!<CR><C-l>
" endif

" Make Y behave like other capitals.
nnoremap Y y$

" Reselect previous visual block after an indent, or outdent.
vnoremap < <gv
vnoremap > >gv

" Remove all trailing whitespace.
nnoremap <Leader>W :%s/\s\+$//<CR>:let @/=''<CR>

" Keep search matches in the middle of the screen when moving.
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz

" Rename the current file.
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

map <Leader>R :call RenameFile()<CR>

" Delete the current file.
function! DeleteFile()
    let fname = expand('%')
    exec ':bdelete!'
    exec ':silent !rm -f ' . fname
    redraw!
endfunction

map <Leader>D :call DeleteFile()<CR>

" Run tests.
function! RunTestUnderCursor()
    :write

    if (match(expand("%"), '\.feature\|test\|spec\|mocha') != -1)
        let t:test_file = @%
        let t:test_line_number = line('.')
    endif

    execute "!clear; run_test " . t:test_file . " -t " . t:test_line_number
endfunction

function! RunTestFile()
    :write

    if (match(expand("%"), '\.feature\|test\|spec\|mocha') != -1)
        let t:test_file = @%
    endif

    execute "!clear; run_test " . t:test_file
endfunction

nnoremap <Leader>T :call RunTestFile()<CR>
nnoremap <Leader>t :call RunTestUnderCursor()<CR>

function! FormatFile()
    :write
    let t:file = @%

    if (&filetype == 'cpp')
        execute "!clear; astyle --add-braces --align-pointer=type --align-reference=type --break-blocks --max-code-length=80 --pad-header --pad-oper --style=google --suffix=none " . t:file
    elseif (&filetype == 'css')
        execute "!clear; npx prettier --write " . t:file
    elseif (&filetype == 'go')
        execute "!clear; gofmt -s -w " . t:file
    elseif (&filetype == 'html')
        " Do `npm install -g js-beautify` to get the html-beautify command.
        execute "!clear; html-beautify -pIr -s 2 -w 80 -f " . t:file
        execute "!clear; npx prettier --write " . t:file
    " elseif (&filetype == 'htmldjango')
        " Do `npm install -g js-beautify` to get the html-beautify command.
        " execute "!clear; html-beautify -pIr -s 2 -w 80 -f " . t:file
    elseif (&filetype == 'java')
        " execute "!clear; astyle --add-braces --attach-classes --attach-return-type --break-blocks --max-code-length=80 --pad-header --pad-oper --style=java --suffix=none " . t:file
        execute "!clear; google-java-format --replace " . t:file
    elseif (&filetype == 'javascript')
        execute "!clear; npx prettier --single-quote --write " . t:file
    elseif (&filetype == 'javascript.jsx')
        execute "!clear; npx prettier --single-quote --write " . t:file
    elseif (&filetype == 'json')
        execute "!clear; npx prettier --single-quote --write " . t:file
    elseif (&filetype == 'python')
        execute "!clear; isort -ac " . t:file . " && black " . t:file
    elseif (&filetype == 'ruby')
        execute "!clear; rubocop --auto-correct " . t:file
    elseif (&filetype == 'rust')
        execute "!clear; rustfmt " . t:file
    elseif (&filetype == 'scss')
        execute "!clear; npx prettier --write " . t:file
    elseif (&filetype == 'typescript')
        execute "!clear; npx prettier --single-quote --write " . t:file
    elseif (&filetype == 'typescript.jsx')
        execute "!clear; npx prettier --single-quote --write " . t:file
    else
        echoerr "Don't know how to format filetype: " . &filetype
    endif
endfunction

" Format current file.
nmap <Leader>f :call FormatFile()<CR>

" Like windo but restore the current window.
function! WinDo(command)
  let currwin=winnr()
  execute 'windo ' . a:command
  execute currwin . 'wincmd w'
endfunction
command! -nargs=+ -complete=command Windo call WinDo(<q-args>)

" Like bufdo but restore the current buffer.
function! BufDo(command)
  let currBuff=bufnr("%")
  execute 'bufdo ' . a:command
  execute 'buffer ' . currBuff
endfunction
command! -nargs=+ -complete=command Bufdo call BufDo(<q-args>)

" Like tabdo but restore the current tab.
function! TabDo(command)
  let currTab=tabpagenr()
  execute 'tabdo ' . a:command
  execute 'tabn ' . currTab
endfunction
command! -nargs=+ -complete=command Tabdo call TabDo(<q-args>)

" Configure a notes file.
map <Leader>vn Ovim:ft=notes<Esc>:set ft=notes<CR><C-l>

" Start silver seacher.
map <Leader>z :Ag<Space>

map <Leader>hd O{# htmldjango #}<Esc>:set ft=htmldjango<CR>

function! RemoveFancyCharacters()
    let typo = {}
    let typo["“"] = '"'
    let typo["”"] = '"'
    let typo["‘"] = "'"
    let typo["’"] = "'"
    let typo["–"] = '--'
    let typo["—"] = '---'
    let typo["…"] = '...'
    :exe ":%s/".join(keys(typo), '\|').'/\=typo[submatch(0)]/ge'
endfunction
command! RemoveFancyCharacters :call RemoveFancyCharacters()

" Run rust and cargo commands.
nmap <Leader>rb :execute "!clear; cargo build"<CR>
nmap <Leader>rc :execute "!clear; cargo check"<CR>
nmap <Leader>rd :execute "!clear; cargo doc --open"<CR>
nmap <Leader>rf :execut "!clear; cargo fix"<CR>
nmap <Leader>rl :execute "!clear; cargo clippy"<CR>
nmap <Leader>rr :execute "!clear; cargo run"<CR>

" Run go commands.
nmap <Leader>gor :execute "!clear; go run " . expand("%")<CR>

" PATHOGEN SETUP
" =============================================================


try
    call pathogen#infect()
catch /^Vim\%((\a\+)\)\=:E/
    " Ignore errors if pathogen can't be found.
endtry


" COLOR SETUP
" =============================================================


" Color & syntax settings.
if &t_Co > 1 || has('gui_running')
    syntax on
endif

if has('gui_running')
    set background=light
else
    set background=dark
endif

if &t_Co > 255 || has('gui_running')
    let g:solarized_termcolors=256
elseif &t_Co > 15
    let g:solarized_termcolors=16
endif

" let g:solarized_contrast="high"
let g:solarized_termtrans=1

try
    if has('gui_running') || &t_Co > 15
        colorscheme solarized
        highlight IncSearch term=reverse cterm=reverse ctermbg=White ctermfg=Red guibg=Yellow
        highlight Search term=reverse cterm=reverse ctermbg=Black ctermfg=Yellow guibg=Yellow
    endif
catch /^Vim\%((\a\+)\)\=:E185/
    " Ignore errors if solarized can't be found.
endtry

if exists("g:colors_name") && g:colors_name == 'solarized' && has("multi_byte")
    highlight! NonText ctermfg=235
endif


" FILE TYPE SETTINGS & AUTOCMD GROUPS
" =============================================================


" Enable filetype specific indenting.
filetype indent on

" Enable filetype specific plugins.
filetype plugin on

" Use Tabularize to align pipe delimited tables (e.g. in Cucumber features).
function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction

augroup ag_all
    autocmd!

    autocmd BufNewFile,BufRead *.jeco exec "let b:eco_subtype = 'html' | setlocal filetype=eco"
    autocmd BufNewFile,BufRead *.pc setlocal filetype=c
    autocmd BufRead * normal zz
    autocmd BufRead,BufNewFile *.vue setlocal filetype=vue.html.javascript.css
    autocmd BufRead,BufNewFile .babelrc setlocal filetype=json
    autocmd BufRead,BufNewFile .bowerrc setlocal filetype=json
    autocmd BufRead,BufNewFile .pryrc setlocal filetype=ruby
    autocmd BufRead,BufNewFile .sequelizerc setlocal filetype=javascript
    autocmd BufRead,BufNewFile .simplecov setlocal filetype=ruby
    autocmd BufRead,BufNewFile .zprofile setlocal filetype=zsh
    autocmd BufRead,BufNewFile .zshrc setlocal filetype=zsh
    autocmd BufRead,BufNewFile Gemfile setlocal ft=ruby
    autocmd BufRead,BufNewFile zprofile setlocal filetype=zsh
    autocmd BufRead,BufNewFile zshrc setlocal filetype=zsh
    autocmd BufReadPost fugitive://* set bufhidden=delete
    autocmd FileType Gemfile setlocal expandtab
    autocmd FileType Gemfile setlocal shiftwidth=2
    autocmd FileType Gemfile setlocal softtabstop=2
    autocmd FileType c setlocal noexpandtab
    autocmd FileType c setlocal nolist
    autocmd FileType c setlocal shiftwidth=8
    autocmd FileType c setlocal softtabstop=0
    autocmd FileType clojure RainbowParenthesesActivate
    autocmd FileType clojure RainbowParenthesesLoadBraces
    autocmd FileType clojure RainbowParenthesesLoadRound
    autocmd FileType clojure RainbowParenthesesLoadSquare
    autocmd FileType clojure setlocal expandtab
    autocmd FileType clojure setlocal shiftwidth=2
    autocmd FileType clojure setlocal softtabstop=2
    autocmd FileType coffee setlocal expandtab
    autocmd FileType coffee setlocal shiftwidth=2
    autocmd FileType coffee setlocal softtabstop=2
    autocmd FileType css setlocal expandtab
    autocmd FileType css setlocal iskeyword+=-
    autocmd FileType css setlocal omnifunc=csscomplete#Complete
    autocmd FileType css setlocal shiftwidth=2
    autocmd FileType css setlocal softtabstop=2
    autocmd FileType cucumber imap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a
    autocmd FileType cucumber setlocal expandtab
    autocmd FileType cucumber setlocal shiftwidth=2
    autocmd FileType cucumber setlocal softtabstop=2
    autocmd FileType eruby setlocal expandtab
    autocmd FileType eruby setlocal shiftwidth=2
    autocmd FileType eruby setlocal softtabstop=2
    autocmd FileType gitcommit setlocal expandtab
    autocmd FileType gitcommit setlocal nolist
    autocmd FileType gitcommit setlocal shiftwidth=8
    autocmd FileType gitcommit setlocal softtabstop=8
    autocmd FileType gitconfig setlocal expandtab
    autocmd FileType gitconfig setlocal shiftwidth=8
    autocmd FileType gitconfig setlocal softtabstop=8
    autocmd FileType go setlocal noexpandtab
    autocmd FileType go setlocal nolist
    autocmd FileType go setlocal shiftwidth=4
    autocmd FileType go setlocal softtabstop=4
    autocmd FileType go setlocal tabstop=4
    autocmd FileType haml setlocal iskeyword+=-
    autocmd FileType help setlocal nolist
    autocmd FileType html setlocal expandtab
    autocmd FileType html setlocal omnifunc=htmlcomplete#Complete
    autocmd FileType html setlocal shiftwidth=2
    autocmd FileType html setlocal softtabstop=2
    autocmd FileType html.handlebars setlocal expandtab
    autocmd FileType html.handlebars setlocal shiftwidth=2
    autocmd FileType html.handlebars setlocal softtabstop=2
    autocmd FileType htmldjango setlocal expandtab
    autocmd FileType htmldjango setlocal shiftwidth=2
    autocmd FileType htmldjango setlocal softtabstop=2
    autocmd FileType htmldjango setlocal tabstop=2
    autocmd FileType java setlocal expandtab
    autocmd FileType java setlocal shiftwidth=2
    autocmd FileType java setlocal softtabstop=2
    autocmd FileType javascript setlocal expandtab
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#Complete
    autocmd FileType javascript setlocal shiftwidth=2
    autocmd FileType javascript setlocal softtabstop=2
    autocmd FileType json setlocal expandtab
    autocmd FileType json setlocal shiftwidth=2
    autocmd FileType json setlocal softtabstop=2
    autocmd FileType python setlocal autoindent
    autocmd FileType python setlocal expandtab
    autocmd FileType python setlocal fileformat=unix
    autocmd FileType python setlocal shiftwidth=4
    autocmd FileType python setlocal softtabstop=4
    autocmd FileType python setlocal tabstop=4
    autocmd FileType python setlocal textwidth=79
    autocmd Filetype c setlocal omnifunc=ccomplete#Complete

    " if exists('+relativenumber')
        " autocmd FileType nerdtree setlocal nolist nonumber norelativenumber
    " else
        autocmd FileType nerdtree setlocal nolist nonumber
    " endif

    autocmd FileType ruby setlocal expandtab
    autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
    autocmd FileType ruby setlocal shiftwidth=2
    autocmd FileType ruby setlocal softtabstop=2
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
    autocmd FileType svelte setlocal expandtab
    autocmd FileType svelte setlocal shiftwidth=2
    autocmd FileType svelte setlocal softtabstop=2
    autocmd FileType text setlocal nolist
    autocmd FileType text setlocal norelativenumber
    autocmd FileType text setlocal spell
    autocmd FileType typescript setlocal noexpandtab
    autocmd FileType typescript setlocal nolist
    autocmd FileType typescript setlocal shiftwidth=2
    autocmd FileType typescript setlocal softtabstop=2
    autocmd FileType typescript setlocal tabstop=2
    autocmd FileType typescript.jsx setlocal noexpandtab
    autocmd FileType typescript.jsx setlocal nolist
    autocmd FileType typescript.jsx setlocal shiftwidth=2
    autocmd FileType typescript.jsx setlocal softtabstop=2
    autocmd FileType typescript.jsx setlocal tabstop=2
    autocmd FileType vim setlocal expandtab
    autocmd FileType vim setlocal shiftwidth=4
    autocmd FileType vim setlocal softtabstop=4
    autocmd FileType vue.html.javascript.css setlocal expandtab
    autocmd FileType vue.html.javascript.css setlocal shiftwidth=2
    autocmd FileType vue.html.javascript.css setlocal softtabstop=2
    autocmd FileType vue.html.javascript.css syntax sync fromstart
    autocmd FileType xhtml setlocal expandtab
    autocmd FileType xhtml setlocal omnifunc=htmlcomplete#Complete
    autocmd FileType xhtml setlocal shiftwidth=2
    autocmd FileType xhtml setlocal softtabstop=2
    autocmd FileType xml setlocal expandtab
    autocmd FileType xml setlocal omnifunc=xmlcomplete#Complete
    autocmd FileType xml setlocal shiftwidth=4
    autocmd FileType xml setlocal softtabstop=4
    autocmd FileType yaml setlocal expandtab
    autocmd FileType yaml setlocal shiftwidth=2
    autocmd FileType yaml setlocal softtabstop=2
    autocmd InsertLeave * set nopaste
    autocmd VimResized * :wincmd =
augroup END

" PLUGIN SETTINGS
" =============================================================


" NERD_commenter settings
" -----------------------

let NERDCommentWholeLinesInVMode=2
let NERDCreateDefaultMappings=0
let NERDSpaceDelims=1
let NERD_scss_alt_style=1
nmap <Leader>c <Plug>NERDCommenterToggle<C-l>
vmap <Leader>c <Plug>NERDCommenterToggle<C-l>
nmap <Leader>x <Plug>NERDCommenterSexy<C-l>
vmap <Leader>x <Plug>NERDCommenterSexy<C-l>
nmap <Leader>i <Plug>NERDCommenterAltDelims<C-l>

" NERD_tree settings
" ------------------

let NERDChristmasTree=1
let NERDTreeDirArrows= has("multi_byte") ? 1 : 0
let NERDTreeQuitOnOpen=1
let NERDTreeWinSize=50
nnoremap <Leader>n :NERDTreeToggle<CR>

" gnupg settings
" --------------

let g:GPGExecutable="gpg"
let g:GPGPreferArmor=1

" snipmate settings
" -----------------

let g:snippets_dir=$HOME.'/.vim/snippets'
nnoremap <Leader>es :tabedit $HOME/.vim/snippets/

" airline settings
" ----------------

" if has("multi_byte")
    " let g:airline_left_sep='▶'
    " let g:airline_right_sep='◀'
" end

" let g:airline_theme='solarized'

" lightline
" ---------

let g:lightline = {
    \ 'colorscheme': 'solarized',
    \ 'component_function': {
    \   'filename': 'LightlineFilename',
    \ }
\ }

function! LightlineFilename()
  return expand('%:t') !=# '' ? @% : '[No Name]'
endfunction

" tabular settings
" ----------------

nmap <Leader>a# :Tabularize /#<CR>
nmap <Leader>a, :Tabularize /^[^,]*,\zs /l0l0l0<CR>
nmap <Leader>a- :Tabularize /-<CR>
nmap <Leader>a: :Tabularize /^[^:]*:\zs /l0l0l0<CR>
nmap <Leader>a; :Tabularize /^[^;]*;\zs /l0l0l0<CR>
nmap <Leader>a= :Tabularize /=<CR>
nmap <Leader>a> :Tabularize /=><CR>
nmap <Leader>as :Tabularize / <CR>
nmap <Leader>a{ :Tabularize /{<CR>

vmap <Leader>a# :Tabularize /#<CR>
vmap <Leader>a, :Tabularize /^[^,]*,\zs /l0l0l0<CR>
vmap <Leader>a- :Tabularize /-<CR>
vmap <Leader>a: :Tabularize /^[^:]*:\zs /l0l0l0<CR>
vmap <Leader>a; :Tabularize /^[^;]*;\zs /l0l0l0<CR>
vmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a> :Tabularize /=><CR>
vmap <Leader>as :Tabularize / <CR>
vmap <Leader>a{ :Tabularize /{<CR>

" fugitive settings
" -----------------

nnoremap <Leader>gb :Gblame<CR>
nnoremap <Leader>gc :Gcommit --verbose<CR>
nnoremap <Leader>gd :Gdiff<CR>
nnoremap <Leader>gp :Gpush --verbose<CR>
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>gw :Gwrite<CR>

" surround settings
" -----------------

let g:surround_105  = "#{\r}" " 105 = ASCII mapping for 'i'

" ctrlp settings
" --------------

let g:ctrlp_arg_map = 1
let g:ctrlp_custom_ignore = {
    \ 'dir': '\v(\.git|node_modules|dist|coverage|venv|__pycache__|egg-info)',
    \ 'file': '\v\.(swp|pyc)'
    \ }
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0

" if executable('rg')
  " let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
  " let g:ctrlp_use_caching = 0
" endif

" Git Gutter settings
" -------------------

" let g:gitgutter_enabled = 0
" nmap <Leader>gg :GitGutterToggle<CR>
" highlight clear SignColumn

" dragvisuals settings
" --------------------

let g:DVB_TrimWS = 1
vmap  <expr>  <LEFT>   DVB_Drag('left')
vmap  <expr>  <RIGHT>  DVB_Drag('right')
vmap  <expr>  <DOWN>   DVB_Drag('down')
vmap  <expr>  <UP>     DVB_Drag('up')
vmap  <expr>  D        DVB_Duplicate()

" json settings
" -------------

let g:vim_json_syntax_conceal = 0
let g:vim_json_warnings = 1

" vim-sexp settings
" -----------------

" let g:sexp_filetypes = 'clojure,scheme,lisp'

" rainbow_parentheses settings
" ----------------------------

" let g:rbpt_colorpairs = [
    " \ ['brown',       'RoyalBlue3'],
    " \ ['Darkblue',    'SeaGreen3'],
    " \ ['darkgray',    'DarkOrchid3'],
    " \ ['darkgreen',   'firebrick3'],
    " \ ['darkcyan',    'RoyalBlue3'],
    " \ ['darkred',     'SeaGreen3'],
    " \ ['darkmagenta', 'DarkOrchid3'],
    " \ ['brown',       'firebrick3'],
    " \ ['gray',        'RoyalBlue3'],
    " \ ['darkmagenta', 'DarkOrchid3'],
    " \ ['Darkblue',    'firebrick3'],
    " \ ['darkgreen',   'RoyalBlue3'],
    " \ ['darkcyan',    'SeaGreen3'],
    " \ ['darkred',     'DarkOrchid3'],
    " \ ['red',         'firebrick3'],
    " \ ]

" CamelCaseMotion
" ---------------

map <silent> ,w <Plug>CamelCaseMotion_w
map <silent> ,b <Plug>CamelCaseMotion_b

" vim-jsx
" -------

let g:jsx_ext_required = 0
