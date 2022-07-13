vim.g.mapleader = "\\"

vim.o.expandtab = true
vim.o.fillchars = "diff:⣿"
vim.o.foldenable = false
vim.o.ignorecase = true
vim.o.joinspaces = false
vim.o.lazyredraw = true
vim.o.list = true
vim.o.listchars = "extends:❯,nbsp:~,precedes:❮,tab:▸\\ ,trail:⋅"
vim.o.number = true
vim.o.relativenumber = true
vim.o.shell = "/bin/bash"
vim.o.shiftwidth = 0
vim.o.showmode = false
vim.o.smartcase = true
vim.o.softtabstop = 4
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.startofline = false
vim.o.tabstop = 4
vim.o.textwidth = 80
vim.o.timeout = false
vim.o.undolevels = 1000
vim.o.virtualedit = "all"

function map(mode, lhs, rhs, opts)
    local options = { noremap = true }

    if opts then
        options = vim.tbl_extend("force", options, opts)
    end

    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

map("n", "<C-l>", ":nohlsearch<CR><C-l>")
map("i", "<C-l>", "<C-o>:nohlsearch<CR>")

map("n", "<Leader>p", ":set invpaste paste?<CR>")

map("n", "<Leader>w", ":set invwrap wrap?<CR>")

map("n", "<Leader>u", ":setlocal cursorcolumn! cursorline!<CR><C-l>")

map("v", "<Leader>sd", ":sort! n<CR>")
map("v", "<Leader>ss", ":sort iu<CR>")

if not vim.g.vscode then
    map("n", "<Left>", "gT")
    map("n", "<Right>", "gt")
    map("n", "<Down>", ":tabmove -1<CR><C-l>")
    map("n", "<Up>", ":tabmove +1<CR><C-l>")
end

map("n", "K", "<Nop>")

map("n", "<Leader>ve", ":tabedit $MYVIMRC<CR>")
map("n", "<Leader>vs", ":source $MYVIMRC<CR>")

map("n", "<Leader>$", ":set list! number! relativenumber!<CR><C-l>")

map("n", "<Leader>W", ":%s/\\s\\+$//<CR>:let @/=''<CR>")

if not vim.g.vscode then
    function run_formatters()
        vim.cmd [[
            write

            if (&filetype == "go")
                GoFmt
                GoImports
                write
            else
                execute "!run-formatters " . @%
                checktime
            endif
        ]]
    end

    map("n", "<Leader>rf", ":lua run_formatters()<CR>")
end

map("n", "<Leader>dt", "O{# Django template #}<Esc>:set ft=htmldjango<CR>")

require("packer").startup(function(use)
    use "wbthomason/packer.nvim"

    use "altercation/vim-colors-solarized"
    use "bkad/CamelCaseMotion"
    use "henrik/vim-indexed-search"
    use "kana/vim-smartinput"
    use "MarcWeber/vim-addon-mw-utils"
    use "preservim/nerdcommenter"
    use "sheerun/vim-polyglot"
    use "tomtom/tlib_vim"
    use "tpope/vim-surround"

    if not vim.g.vscode then
        use "itchyny/lightline.vim"
        use "jamessan/vim-gnupg"
        use "mattn/emmet-vim"
        use "preservim/nerdtree"
        use "tpope/vim-eunuch"
        use "tpope/vim-fugitive"

        use {
            'nvim-telescope/telescope.nvim',
            tag = '0.1.0',
            requires = { {'nvim-lua/plenary.nvim'} }
        }
    end
end)

vim.g.solarized_termcolors = 256
vim.g.solarized_termtrans = 1

vim.cmd "colorscheme solarized"

vim.cmd "highlight WinSeparator guibg=None"
vim.cmd "highlight! NonText ctermfg=235"

-- Only highlight absolute line number inside relative numbers.
vim.cmd "highlight LineNr ctermfg=166 ctermbg=Black"
vim.cmd "highlight LineNrAbove ctermfg=239 ctermbg=Black"
vim.cmd "highlight LineNrBelow ctermfg=239 ctermbg=Black"

vim.cmd "filetype indent on"
vim.cmd "filetype plugin on"

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
        autocmd FileType go setlocal noexpandtab
        autocmd FileType go setlocal nolist
        autocmd FileType go setlocal softtabstop=4
        autocmd FileType go setlocal tabstop=4
        autocmd FileType gomod setlocal noexpandtab
        autocmd FileType gomod setlocal nolist
        autocmd FileType gomod setlocal softtabstop=4
        autocmd FileType gomod setlocal tabstop=4
        autocmd FileType html setlocal softtabstop=2
        autocmd FileType html setlocal tabstop=2
        autocmd FileType htmldjango set commentstring={#\ %s\ #}
        autocmd FileType htmldjango setlocal softtabstop=2
        autocmd FileType htmldjango setlocal tabstop=2
        autocmd FileType javascript setlocal softtabstop=2
        autocmd FileType javascript setlocal tabstop=2
        autocmd FileType lua setlocal softtabstop=2
        autocmd FileType lua setlocal tabstop=2
        autocmd FileType lua setlocal textwidth=80
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

-- packer.nvim
map("n", "<Leader>li", ":PackerInstall<CR>")
map("n", "<Leader>lu", ":PackerUpdate<CR>")

-- telescope.nvim
map("n", "<Leader>ff", "<Cmd>lua require('telescope.builtin').find_files()<CR>")
map("n", "<Leader>fg", "<Cmd>lua require('telescope.builtin').live_grep()<CR>")

-- " NERD_commenter
vim.g.NERD_scss_alt_style = 1
vim.g.NERDCommentWholeLinesInVMode = 2
vim.g.NERDCreateDefaultMappings = 0
vim.g.NERDDefaultAlign = "left"
vim.g.NERDSpaceDelims = 1

map("n", "<Leader>c", "<Plug>NERDCommenterToggle<C-l>")
map("n", "<Leader>i", "<Plug>NERDCommenterAltDelims<C-l>")
map("n", "<Leader>x", "<Plug>NERDCommenterSexy<C-l>")
map("v", "<Leader>c", "<Plug>NERDCommenterToggle<C-l>")
map("v", "<Leader>x", "<Plug>NERDCommenterSexy<C-l>")

-- NERD_tree
vim.g.NERDChristmasTree = 1
vim.g.NERDTreeQuitOnOpen = 1
vim.g.NERDTreeWinSize = 50

if not vim.g.vscode then
    map("n", "<Leader>n", ":NERDTreeToggle<CR>")
end

-- gnupg
vim.g.GPGExecutable = "gpg"
vim.g.GPGPreferArmor = 1

-- lightline
vim.cmd [[
    function! LightlineFilename()
      return expand("%:t") !=# "" ? @% : "[No Name]"
    endfunction

    let g:lightline = {
        \ "colorscheme": "solarized",
        \ "component_function": {
        \   "filename": "LightlineFilename",
        \ },
        \ "enable": { "tabline": 0 },
    \ }
]]

-- CamelCaseMotion
map("", ",b", "<Plug>CamelCaseMotion_b", { silent = true })
map("", ",w", "<Plug>CamelCaseMotion_w", { silent = true })

-- fugitive
if not vim.g.vscode then
    map("n", "<Leader>gb", ":Git blame<CR>")
    map("n", "<Leader>gc", ":Git commit --verbose<CR>")
    map("n", "<Leader>gd", ":Gitdiffsplit<CR>")
    map("n", "<Leader>gp", ":Git push --verbose<CR>")
    map("n", "<Leader>gs", ":Git<CR>")
    map("n", "<Leader>gw", ":Gwrite<CR>")
end

-- emmet-vim
vim.g.user_emmet_install_global = 0
