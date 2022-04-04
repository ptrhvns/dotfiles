vim.g.mapleader = '\\'

local opt = vim.opt

opt.autoindent = true
opt.autoread = true
opt.clipboard = "unnamed"
opt.expandtab = true
opt.foldenable = false
opt.ignorecase = true
opt.joinspaces = false
opt.lazyredraw = true
opt.list = true
opt.listchars = "extends:❯,nbsp:~,precedes:❮,tab:▸ ,trail:⋅"
opt.number = true
opt.relativenumber = true
opt.shell = "/bin/bash"
opt.shiftwidth = 0
opt.showmode = false
opt.smartcase = true
opt.softtabstop = 4
opt.splitbelow = true
opt.splitright = true
opt.tabstop = 4
opt.textwidth = 80
opt.timeout = false
opt.undolevels = 1000
opt.virtualedit=all

local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  packer_was_installed = fn.system({
      'git',
      'clone',
      '--depth',
      '1',
      'https://github.com/wbthomason/packer.nvim',
      install_path
  })
end

local packer_was_required, packer = pcall(require, 'packer')

if packer_was_required then
    packer.startup(function(use)

      use 'altercation/vim-colors-solarized'
      use 'bkad/CamelCaseMotion'
      use 'cakebaker/scss-syntax.vim'
      use 'fatih/vim-go'
      use 'henrik/vim-indexed-search'
      use 'itchyny/lightline.vim'
      use 'jamessan/vim-gnupg'
      use {'junegunn/fzf', run = function() vim.fn['fzf#install()'](0) end}
      use 'junegunn/fzf.vim'
      use 'kana/vim-smartinput'
      use 'MarcWeber/vim-addon-mw-utils'
      use 'mattn/emmet-vim'
      use 'preservim/nerdcommenter'
      use 'preservim/nerdtree'
      use 'sheerun/vim-polyglot'
      use 'tomtom/tlib_vim'
      use 'tpope/vim-eunuch'
      use 'tpope/vim-fugitive'
      use 'tpope/vim-surround'

      -- This goes after all plugins have been specified.
      if packer_was_installed then
        require('packer').sync()
      end
    end)
end

local keymap_opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

-- bkad/CamelCaseMotion
keymap("", ",b", "<Plug>CamelCaseMotion_b", keymap_opts)
keymap("", ",w", "<Plug>CamelCaseMotion_w", keymap_opts)

-- fatih/vim-go
vim.g.go_fmt_autosave = 0
vim.g.go_imports_autosave = 0
vim.g.go_metalinter_command = "golangci-lint"
vim.g.go_template_autocreate = 0
keymap("n", "<Leader>ol", ":GoMetaLinter<CR>", keymap_opts)
keymap("n", "<C-l>", ":nohlsearch<CR><C-l>", keymap_opts)

-- 'itchyny/lightline.vim',
vim.g.lightline = {
  colorscheme = "solarized",
  component_function = { filename = "LightlineFilename" },
  enable = { tabline = 0 }
}

vim.cmd [[
    function! LightlineFilename()
      return expand("%:t") !=# "" ? @% : "[No Name]"
    endfunction
]]

-- jamessan/vim-gnupg
vim.g.GPGExecutable = "gpg"
vim.g.GPGPreferArmor = 1

-- junegunn/fzf.vim
keymap("n", "<C-p>", ":Files<CR>", keymap_opts)
keymap("n", "<Leader>rg", ":Rg ", keymap_opts)

-- mattn/emmet-vim
vim.g.user_emmet_install_global = 0

-- preservim/nerdcommenter
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

-- preservim/nerdtree
vim.cmd [[
    let NERDChristmasTree=1
    let NERDTreeDirArrows= has("multi_byte") ? 1 : 0
    let NERDTreeQuitOnOpen=1
    let NERDTreeWinSize=50
]]

keymap("n", "<Leader>n", ":NERDTreeToggle<CR>", keymap_opts)

-- tpope/vim-fugitive
keymap("n", "<Leader>gb", ":Git blame<CR>", keymap_opts)
keymap("n", "<Leader>gc", ":Git commit --verbose<CR>", keymap_opts)
keymap("n", "<Leader>gd", ":Gitdiffsplit<CR>", keymap_opts)
keymap("n", "<Leader>gp", ":Git push --verbose<CR>", keymap_opts)
keymap("n", "<Leader>gs", ":Git<CR>", keymap_opts)
keymap("n", "<Leader>gw", ":Gwrite<CR>", keymap_opts)

-- General mappings

vim.cmd [[
    function! FormatFile()
        write

        if (&filetype == "go")
            GoFmt
            GoImports
            write
        else
            if has("nvim")
                execute "!run-formatters " . @%
            else
                execute "!clear && run-formatters " . @%
            endif
            checktime
        endif
    endfunction
]]

keymap("i", "<C-l>", "<C-o>:nohlsearch<CR>", keymap_opts)
keymap("n", "<Down>", ":tabmove -1<CR><C-l>", keymap_opts)
keymap("n", "<Leader>$", ":set list! number! relativenumber!<CR><C-l>", keymap_opts)
keymap("n", "<Leader>dt", "O{# Django template #}<Esc>:set ft=htmldjango<CR>", keymap_opts)
keymap("n", "<Leader>ev", ":tabedit $HOME/src/personal/remote/dotfiles/vimrc<CR>", keymap_opts)
keymap("n", "<Leader>f", ":call FormatFile()<CR>", keymap_opts)
keymap("n", "<Leader>p", ":set invpaste paste?<CR>", keymap_opts)
keymap("n", "<Leader>so", ":source $MYVIMRC<CR>", keymap_opts)
keymap("n", "<Leader>t", ":! git ls-files | ctags<CR>", keymap_opts)
keymap("n", "<Leader>u", ":setlocal cursorcolumn! cursorline!<CR><C-l>", keymap_opts)
keymap("n", "<Leader>vn", "Ovim:ft=notes<Esc>:set ft=notes<CR><C-l>", keymap_opts)
keymap("n", "<Leader>W", ":%s/\\s\\+$//<CR>:let @/=''<CR>", keymap_opts)
keymap("n", "<Leader>w", ":set invwrap wrap?<CR>", keymap_opts)
keymap("n", "<Left>", "gT", keymap_opts)
keymap("n", "<Right>", "gt", keymap_opts)
keymap("n", "<Up>", ":tabmove +1<CR><C-l>", keymap_opts)
keymap("n", "K", "<Nop>", keymap_opts)
keymap("v", "<Leader>sd", ":sort! n<CR>", keymap_opts)
keymap("v", "<Leader>ss", ":sort iu<CR>", keymap_opts)

vim.g.solarized_termcolors = 256
vim.g.solarized_termtrans = 1

vim.cmd [[
  try
      if &t_Co > 15
          colorscheme solarized
      endif
  catch /^Vim\%((\a\+)\)\=:E185/
      colorscheme default
  endtry

  highlight! NonText ctermfg=235

  " Only highlight absolute line number inside relative numbers.
  highlight LineNr ctermfg=166 ctermbg=Black
  highlight LineNrAbove ctermfg=239 ctermbg=Black
  highlight LineNrBelow ctermfg=239 ctermbg=Black
]]

vim.cmd [[
    filetype indent on
    filetype plugin on
]]

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

custom_group = augroup("CustomGroup", { clear = true })

autocmd("BufNewFile,BufRead", {
  command = "setlocal filetype=json",
  group = custom_group,
  pattern = ".babelrc"
})

autocmd("BufNewFile,BufRead", {
  command = "setlocal filetype=dosini",
  group = custom_group,
  pattern = "supervisord.conf"
})

autocmd("BufReadPost", {
  command = "setlocal bufhidden=delete",
  group = custom_group,
  pattern = "fugitive://*"
})

autocmd("FileType", {
  command = "setlocal softtabstop=2 tabstop=2",
  group = custom_group,
  pattern = "css"
})

autocmd("FileType", {
  command = "EmmetInstall",
  group = custom_group,
  pattern = "css,html,htmldjango,javascript,sass,scss"
})

autocmd("FileType", {
  command = "setlocal nolist",
  group = custom_group,
  pattern = "gitcommit"
})

autocmd("FileType", {
    command = "setlocal noexpandtab nolist softtabstop=4 tabstop=4",
    group = custom_group,
    pattern = "go,gomod"
})

autocmd("FileType", {
    command = "setlocal softtabstop=2 tabstop=2",
    group = custom_group,
    pattern = "html"
  })

autocmd("FileType", {
  command = "setlocal softtabstop=2 tabstop=2",
  group = custom_group,
  pattern = "htmldjango"
})

autocmd("FileType", {
  command = "setlocal softtabstop=2 tabstop=2",
  group = custom_group,
  pattern = "javascript"
})

autocmd("FileType", {
  command = "setlocal softtabstop=2 tabstop=2",
  group = custom_group,
  pattern = "markdown"
})

autocmd("FileType", {
  command = "setlocal textwidth=80",
  group = custom_group,
  pattern = "notes"
})

autocmd("FileType", {
  command = "setlocal softtabstop=4 tabstop=4",
  group = custom_group,
  pattern = "python"
})

autocmd("FileType", {
  command = "setlocal iskeyword+=- iskeyword+=@-@ softtabstop=2 tabstop=2",
  group = custom_group,
  pattern = "scss"
})

autocmd("FileType", {
  command = "setlocal softtabstop=4",
  group = custom_group,
  pattern = "sh"
})

autocmd("FileType", {
  command = "setlocal textwidth=80",
  group = custom_group,
  pattern = "text"
})

autocmd("FileType", {
  command = "setlocal expandtab",
  group = custom_group,
  pattern = "yaml"
})

autocmd("InsertLeave", {
  command = "setlocal nopaste",
  group = custom_group,
  pattern = "*"
})
