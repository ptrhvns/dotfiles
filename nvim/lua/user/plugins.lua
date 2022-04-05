utils = require("user.utils")

local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  local packer_was_installed = fn.system({
      'git',
      'clone',
      '--depth',
      '1',
      'https://github.com/wbthomason/packer.nvim',
      install_path
  })
end

utils.prequire("packer", function(packer)
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
    use 'L3MON4D3/LuaSnip'
    use 'lewis6991/impatient.nvim'
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
      print("Syncing packer")
      require('packer').sync()
    end
  end)
end)

-- fatih/vim-go
vim.g.go_fmt_autosave = 0
vim.g.go_imports_autosave = 0
vim.g.go_metalinter_command = "golangci-lint"
vim.g.go_template_autocreate = 0

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

-- preservim/nerdtree
vim.cmd [[
    let NERDChristmasTree=1
    let NERDTreeDirArrows= has("multi_byte") ? 1 : 0
    let NERDTreeQuitOnOpen=1
    let NERDTreeWinSize=50
]]

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
