vim.g.mapleader = "\\"

vim.opt.clipboard = "unnamed"
vim.opt.expandtab = true
vim.opt.fillchars = "diff:⣿"
vim.opt.foldenable = false
vim.opt.ignorecase = true
vim.opt.lazyredraw = true
vim.opt.list = false
vim.opt.listchars = "extends:❯,nbsp:~,precedes:❮,tab:▸ ,trail:⋅"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.shell = "/bin/bash"
vim.opt.shiftwidth = 0
vim.opt.showmode = false
vim.opt.smartcase = true
vim.opt.softtabstop = 4
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.tabstop = 4
vim.opt.textwidth = 80
vim.opt.timeout = false
vim.opt.undolevels = 1000
vim.opt.undoreload = 10000
vim.opt.virtualedit = "all"

local keymap = vim.api.nvim_set_keymap
local keymap_opts = { noremap = true, silent = true }

keymap("n", "<C-l>", ":nohlsearch<CR><C-l>", keymap_opts)
keymap("i", "<C-l>", "<C-o>:nohlsearch<CR>", keymap_opts)

keymap("n", "<Leader>p", ":set invpaste paste?<CR>", keymap_opts)

keymap("n", "<Leader>w", ":set invwrap wrap?<CR>", keymap_opts)

keymap("n", "<Leader>u", ":setlocal cursorcolumn! cursorline!<CR><C-l>", keymap_opts)

keymap("v", "<Leader>sd", ":sort! n<CR>", keymap_opts)
keymap("v", "<Leader>ss", ":sort iu<CR>", keymap_opts)

keymap("n", "<Left>", "gT", keymap_opts)
keymap("n", "<Right>", "gt", keymap_opts)
keymap("n", "<Down>", ":tabmove -1<CR><C-l>", keymap_opts)
keymap("n", "<Up>", ":tabmove +1<CR><C-l>", keymap_opts)

keymap("n", "K", "<Nop>", keymap_opts)

keymap("n", "<Leader>ev", ":tabedit $HOME/src/personal/remote/dotfiles/vimrc<CR>", keymap_opts)

keymap("n", "<Leader>so", ":source $MYVIMRC<CR>", keymap_opts)

keymap("n", "<Leader>$", ":set list! number! relativenumber!<CR><C-l>", keymap_opts)

keymap("n", "<Leader>W", ":%s/\\s\\+$//<CR>:let @/=''<CR>", keymap_opts)

keymap("n", "<Leader>vn", "Ovim:ft=notes<Esc>:set ft=notes<CR><C-l>", keymap_opts)

keymap("n", "<Leader>dt", "O{# Django template #}<Esc>:set ft=htmldjango<CR>", keymap_opts)

vim.cmd [[
    function! FormatFile()
	    write
	    execute "run-formatters " . @%
	    checktime
	endfunction
]]

keymap("n", "<Leader>f", ":call FormatFile()<CR>", keymap_opts)

local fn = vim.fn

local Plug = vim.fn['plug#']

if fn.filereadable(fn.expand("~/.local/share/nvim/site/autoload/plug.vim")) then
    vim.call("plug#begin", "~/.local/share/nvim/site/plugged")

    Plug('altercation/vim-colors-solarized')
    Plug('bkad/CamelCaseMotion')
    Plug('cakebaker/scss-syntax.vim')
    Plug('garbas/vim-snipmate')
    Plug('henrik/vim-indexed-search')
    Plug('itchyny/lightline.vim')
    Plug('jamessan/vim-gnupg')
    Plug('kana/vim-smartinput')
    Plug('MarcWeber/vim-addon-mw-utils')
    Plug('mattn/emmet-vim')
    Plug('preservim/nerdcommenter')
    Plug('preservim/nerdtree')
    Plug('scrooloose/nerdcommenter')
    Plug('sheerun/vim-polyglot')
    Plug('tomtom/tlib_vim')
    Plug('tpope/vim-eunuch')
    Plug('tpope/vim-fugitive')
    Plug('tpope/vim-surround')

    if fn.executable("fzf") then
        Plug('junegunn/fzf', {['do'] = vim.fn['fzf#install']})
        Plug('junegunn/fzf.vim')
    else
        Plug('kien/ctrlp.vim')
    end

    vim.call("plug#end")
end

vim.g.solarized_termcolors = 256
vim.g.solarized_termtrans = 1
local colorscheme = "solarized"
local colorscheme_ok , _ = pcall(vim.cmd, "colorscheme " .. colorscheme)

if not colorscheme_ok then
    vim.cmd("colorscheme default")
else
    vim.cmd("highlight! NonText ctermfg=235")
    vim.cmd("highlight LineNr ctermfg=166 ctermbg=Black")
    vim.cmd("highlight LineNrAbove ctermfg=239 ctermbg=Black")
    vim.cmd("highlight LineNrBelow ctermfg=239 ctermbg=Black")
end

vim.cmd [[
    augroup ag_all
        autocmd!

        autocmd BufNewFile,BufRead .babelrc setlocal filetype=json
        autocmd BufNewFile,BufRead supervisord.conf setlocal filetype=dosini
        autocmd BufReadPost fugitive://* setlocal bufhidden=delete
        autocmd FileType css setlocal softtabstop=2
        autocmd FileType css setlocal tabstop=2
        autocmd FileType css,html,htmldjango,javascript,sass,scss EmmetInstall
        autocmd FileType gitcommit setlocal nolist
        autocmd FileType html setlocal softtabstop=2
        autocmd FileType html setlocal tabstop=2
        autocmd FileType htmldjango setlocal softtabstop=2
        autocmd FileType htmldjango setlocal tabstop=2
        autocmd FileType javascript setlocal softtabstop=2
        autocmd FileType javascript setlocal tabstop=2
        autocmd FileType lua setlocal softtabstop=2
        autocmd FileType lua setlocal tabstop=2
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
]]

-- plug
keymap("n", "<Leader>li", ":PlugInstall<CR>", keymap_opts)
keymap("n", "<Leader>lu", ":PlugUpgrade<CR>:PlugUpdate<CR>", keymap_opts)

-- NERD_commenter
vim.cmd [[
    let NERD_scss_alt_style=1
    let NERDCommentWholeLinesInVMode=2
    let NERDCreateDefaultMappings=0
    let NERDDefaultAlign = "left"
    let NERDSpaceDelims=1
]]
keymap("n", "<Leader>c", "<Plug>NERDCommenterToggle<C-l>", keymap_opts)
keymap("n", "<Leader>i", "<Plug>NERDCommenterAltDelims<C-l>", keymap_opts)
keymap("n", "<Leader>x", "<Plug>NERDCommenterSexy<C-l>", keymap_opts)
keymap("v", "<Leader>c", "<Plug>NERDCommenterToggle<C-l>", keymap_opts)
keymap("v", "<Leader>x", "<Plug>NERDCommenterSexy<C-l>", keymap_opts)

-- NERD_tree
vim.cmd [[
    let NERDChristmasTree=1
    let NERDTreeDirArrows=1
    let NERDTreeQuitOnOpen=1
    let NERDTreeWinSize=50
]]
keymap("n", "<Leader>n", ":NERDTreeToggle<CR>", keymap_opts)

-- gnupg
vim.cmd [[
    let g:GPGExecutable="gpg"
    let g:GPGPreferArmor=1
]]

-- lightline
vim.cmd [[
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
]]

-- CamelCaseMotion
keymap("", ",b", "<Plug>CamelCaseMotion_b", keymap_opts)
keymap("", ",w", "<Plug>CamelCaseMotion_w", keymap_opts)

vim.cmd [[
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
]]

-- fugitive
keymap("n", "<Leader>gb", ":Git blame<CR>", keymap_opts)
keymap("n", "<Leader>gc", ":Git commit --verbose<CR>", keymap_opts)
keymap("n", "<Leader>gd", ":Gitdiffsplit<CR>", keymap_opts)
keymap("n", "<Leader>gp", ":Git push --verbose<CR>", keymap_opts)
keymap("n", "<Leader>gs", ":Git<CR>", keymap_opts)
keymap("n", "<Leader>gw", ":Gwrite<CR>", keymap_opts)

-- fzf
keymap("n", "<Leader>rg", ":Rg", keymap_opts)

-- emmet-vim
vim.g.user_emmet_install_global = 0

-- vim-snipmate
vim.cmd [[
    let g:snipMate = { 'snippet_version' : 1 }
    let g:snippets_dir = $HOME . "/.vim/snippets"
    nmap <Leader>es :tabedit $HOME/src/personal/remote/dotfiles/vim/snippets/
]]
