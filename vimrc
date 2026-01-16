set nocompatible

let mapleader="\\"

set autoindent
set autoread
set background=dark
set backspace=indent,eol,start
set belloff=all
set breakindent
set clipboard="unnamed"
set completeopt=menu,preview
set expandtab
set foldmethod=indent
set hidden
set history=10000
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set lazyredraw
set linebreak
set list
set listchars=extends:>,nbsp:+,precedes:<,tab:>\ ,trail:-
set nofoldenable
set noincsearch
set nojoinspaces
set noshowmode
set nostartofline
set notimeout
set number
set path+=**
set relativenumber
set scrolloff=0
set shell=/bin/bash
set shiftwidth=0
set showcmd
set sidescroll=1
set smartcase
set smarttab
set softtabstop=4
set splitbelow
set splitright
set statusline=\ %f\ %m%=%y\ [%{&fileformat}]\ %l:%c\ %p%%\ 
set tabstop=4
set textwidth=80
set ttyfast
set undolevels=1000
set virtualedit=all
set wildmenu

if has("multi_byte")
    set encoding=utf-8
    set listchars=extends:→,nbsp:␣,precedes:←,tab:»·,trail:·
else
    set listchars=extends:>,nbsp:+,precedes:<,tab:>-,trail:-
endif

if v:version > 703 || v:version == 703 && has("patch541")
  set formatoptions+=j
endif

if exists("+undoreload")
    set undoreload=10000
endif

nnoremap <C-l> :nohlsearch<CR><C-l>
inoremap <C-l> <C-o>:nohlsearch<CR>
inoremap <special> <F3> <C-r>=strftime("%c")<CR>

nmap <Leader>ip :set invpaste paste?<CR>

nmap <Leader>iw :set invwrap wrap?<CR>

vmap <Leader>sd :sort! n<CR>:sort !n<CR>
vmap <Leader>ss :sort iu<CR>

nmap K <Nop>

nmap <Leader>ve :tabedit $MYVIMRC<CR>
nmap <Leader>vs :source $MYVIMRC<CR>

nmap <Leader>$ :set list! number! relativenumber!<CR><C-l>

nmap <Leader>W :%s/\s\+$//<CR>:let @/=''<CR>

nmap <Down> :tabmove -1<CR><C-l>
nmap <Left> gT
nmap <Right> gt
nmap <Up> :tabmove +1<CR><C-l>

nnoremap * :keepjumps normal! mi*`i<CR>

nmap <Leader>gb :Git blame<CR>
nmap <Leader>gc :Git commit --verbose<CR>
nmap <Leader>gp :Git push --verbose<CR>
nmap <Leader>gw :Gwrite<CR>

nmap <Leader>ct :!ctags -R .<CR>

function! RunCodeCommands()
    write
    execute "!run-code-commands " . @%
    checktime
endfunction

function! RunCodeCommandsFormatOnly()
    write
    execute "!run-code-commands -f " . @%
    checktime
endfunction

nmap <Leader>rc :call RunCodeCommands()<CR>
nmap <Leader>rf :call RunCodeCommandsFormatOnly()<CR>

if &t_Co > 1 || has("gui_running")
    syntax on
endif

colorscheme slate

highlight Comment ctermfg=darkgrey guifg=#808080
highlight LineNr ctermfg=yellow
highlight LineNrAbove ctermfg=darkgrey
highlight LineNrBelow ctermfg=darkgrey
highlight SignColumn ctermbg=black

filetype indent on
filetype plugin on

augroup ag_all
    autocmd!

    autocmd BufEnter,CursorHold,CursorHoldI,FocusGained * if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == '' | checktime | endif
    autocmd FileType gitcommit setlocal nolist
    autocmd FileType markdown setlocal expandtab softtabstop=2 tabstop=2
    autocmd FileType python setlocal softtabstop=4 tabstop=4
    autocmd FileType sh setlocal softtabstop=4
    autocmd FileType text setlocal commentstring=//\ %s textwidth=80
    autocmd FileType yaml setlocal expandtab
    autocmd InsertLeave * setlocal nopaste

augroup end

" Useful plugins to clone into ~/.vim/pack/plugins/start:
"   catppuccin
"   ctrlp
"   fugitive
"   nerdcommenter
"   nerdtree
"   surround
"   vim-airline
"   vim-gitgutter
"   vim-polyglot

let g:ctrlp_clear_cache_on_exit = 0

let g:airline#extensions#whitespace#enabled = 0
let g:airline_symbols_ascii = 1

if isdirectory(expand('~/.vim/pack/plugins/start/catppuccin'))
    " Force Vim to use true colors evne if the TERM type doesn't cause Vim to
    " enable them (e.g., if TERM=tmux-256color).
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

    set termguicolors
    colorscheme catppuccin_mocha
    let g:airline_theme = 'catppuccin_mocha'
    highlight Normal guibg=NONE
    set cursorline
endif

let vimrc_local = $HOME . "/.vimrc_local"

if filereadable(vimrc_local)
    execute "source " . vimrc_local
endif
