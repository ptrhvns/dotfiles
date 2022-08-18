vim.g.mapleader = "\\"

vim.opt.completeopt = {"menu", "menuone"}
vim.opt.expandtab = true
vim.opt.fillchars = "diff:⣿"
vim.opt.foldenable = false
vim.opt.ignorecase = true
vim.opt.joinspaces = false
vim.opt.lazyredraw = true
vim.opt.list = true
vim.opt.listchars = "extends:❯,nbsp:~,precedes:❮,tab:▸ ,trail:⋅"
vim.opt.mouse = ""
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.shell = "/bin/bash"
vim.opt.shiftwidth = 0
vim.opt.showmode = false
vim.opt.signcolumn = "yes"
vim.opt.smartcase = true
vim.opt.softtabstop = 4
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.startofline = false
vim.opt.tabstop = 4
vim.opt.textwidth = 80
vim.opt.timeout = false
vim.opt.undolevels = 1000
vim.opt.virtualedit = "all"

function map(mode, lhs, rhs, opts)
    local options = { noremap = true }

    if opts then
        options = vim.tbl_extend("force", options, opts)
    end

    vim.keymap.set(mode, lhs, rhs, options)
end


map("n", "<Leader>ip", ":set invpaste paste?<CR>")

map("n", "<Leader>iw", ":set invwrap wrap?<CR>")

map("n", "<Leader>u", ":setlocal cursorcolumn! cursorline!<CR><C-l>")

map("v", "<Leader>sd", ":sort! n<CR>")
map("v", "<Leader>ss", ":sort iu<CR>")

map("n", "<Left>", "gT")
map("n", "<Right>", "gt")
map("n", "<Down>", ":tabmove -1<CR><C-l>")
map("n", "<Up>", ":tabmove +1<CR><C-l>")

map("n", "<Leader>ve", ":tabedit $MYVIMRC<CR>")
map("n", "<Leader>vs", ":source $MYVIMRC<CR>")

map("n", "<Leader>$", function ()
    vim.cmd("set list! number! relativenumber!")

    if vim.opt.signcolumn:get() == "no" then
        vim.cmd("set signcolumn=yes")
    else
        vim.cmd("set signcolumn=no")
    end
end)

map("n", "<Leader>W", ":%s/\\s\\+$//<CR>:let @/=''<CR>")

function run_code_commands()
    vim.cmd [[
        write
        execute "!run-code-commands " . @%
        checktime
    ]]
end

map("n", "<Leader>rf", ":lua run_code_commands()<CR>")

map("n", "<Leader>dt", "O{# Django template #}<Esc>:set ft=htmldjango<CR>")

local diagnostic_opts = { silent = true }
map("n", "<Leader>dn", vim.diagnostic.goto_next, diagnostic_opts)
map("n", "<Leader>dp", vim.diagnostic.goto_prev, diagnostic_opts)
map('n', '<Leader>do', vim.diagnostic.open_float, diagnostic_opts)

require("packer").startup(function(use)

    use "altercation/vim-colors-solarized"
    use "bkad/CamelCaseMotion"
    use "folke/trouble.nvim"
    use "hrsh7th/cmp-buffer"
    use "hrsh7th/cmp-nvim-lsp"
    use "hrsh7th/cmp-path"
    use "hrsh7th/nvim-cmp"
    use "itchyny/lightline.vim"
    use "kana/vim-smartinput"
    use "kdheepak/lazygit.nvim"
    use "kevinhwang91/nvim-hlslens"
    use "kyazdani42/nvim-tree.lua" 
    use "L3MON4D3/LuaSnip"
    use "lewis6991/gitsigns.nvim"
    use "MarcWeber/vim-addon-mw-utils"
    use "mattn/emmet-vim"
    use "neovim/nvim-lspconfig"
    use "numToStr/Comment.nvim"
    use "nvim-lua/plenary.nvim"
    use "nvim-telescope/telescope.nvim"
    use "saadparwaiz1/cmp_luasnip"
    use "sheerun/vim-polyglot"
    use "tomtom/tlib_vim"
    use "tpope/vim-eunuch"
    use "tpope/vim-fugitive"
    use "tpope/vim-surround"
    use "wbthomason/packer.nvim"
    use "williamboman/nvim-lsp-installer"

end)

vim.g.solarized_termcolors = 256
vim.g.solarized_termtrans = 1

vim.cmd "colorscheme solarized"

vim.cmd "highlight SignColumn ctermbg=Black"
vim.cmd "highlight WinSeparator guibg=None"
vim.cmd "highlight! NonText ctermfg=235"

-- Only highlight absolute line number inside relative numbers.
vim.cmd "highlight LineNr ctermfg=166 ctermbg=Black"
vim.cmd "highlight LineNrAbove ctermfg=239 ctermbg=Black"
vim.cmd "highlight LineNrBelow ctermfg=239 ctermbg=Black"

vim.cmd "filetype indent on"
vim.cmd "filetype plugin on"

local augroup = vim.api.nvim_create_augroup("all", { clear = true })

vim.api.nvim_create_autocmd("BufNewFile,BufRead", { group = augroup, pattern = ".babelrc", command = "setlocal filetype=json" })
vim.api.nvim_create_autocmd("BufNewFile,BufRead", { group = augroup, pattern = "supervisord.conf", command = "setlocal filetype=dosini" })
vim.api.nvim_create_autocmd("BufReadPost", { group = augroup, pattern = "fugitive://*" , command = "setlocal bufhidden=delete" })
vim.api.nvim_create_autocmd("FileType", { group = augroup, pattern = "css", command = "setlocal softtabstop=2" })
vim.api.nvim_create_autocmd("FileType", { group = augroup, pattern = "css", command = "setlocal tabstop=2" })
vim.api.nvim_create_autocmd("FileType", { group = augroup, pattern = "css,html,htmldjango,javascript,sass,scss,typescriptreact", command = "EmmetInstall" })
vim.api.nvim_create_autocmd("FileType", { group = augroup, pattern = "gitcommit", command = "setlocal nolist" })
vim.api.nvim_create_autocmd("FileType", { group = augroup, pattern = "html", command = "setlocal softtabstop=2" })
vim.api.nvim_create_autocmd("FileType", { group = augroup, pattern = "html", command = "setlocal tabstop=2" })
vim.api.nvim_create_autocmd("FileType", { group = augroup, pattern = "htmldjango", command = "setlocal commentstring={#\\ %s\\ #}" })
vim.api.nvim_create_autocmd("FileType", { group = augroup, pattern = "htmldjango", command = "setlocal softtabstop=2" })
vim.api.nvim_create_autocmd("FileType", { group = augroup, pattern = "htmldjango", command = "setlocal tabstop=2" })
vim.api.nvim_create_autocmd("FileType", { group = augroup, pattern = "javascript", command = "setlocal softtabstop=2" })
vim.api.nvim_create_autocmd("FileType", { group = augroup, pattern = "javascript", command = "setlocal tabstop=2" })
vim.api.nvim_create_autocmd("FileType", { group = augroup, pattern = "lua", command = "setlocal expandtab" })
vim.api.nvim_create_autocmd("FileType", { group = augroup, pattern = "lua", command = "setlocal softtabstop=2" })
vim.api.nvim_create_autocmd("FileType", { group = augroup, pattern = "lua", command = "setlocal tabstop=2" })
vim.api.nvim_create_autocmd("FileType", { group = augroup, pattern = "lua", command = "setlocal textwidth=80" })
vim.api.nvim_create_autocmd("FileType", { group = augroup, pattern = "markdown", command = "setlocal softtabstop=2" })
vim.api.nvim_create_autocmd("FileType", { group = augroup, pattern = "markdown", command = "setlocal tabstop=2" })
vim.api.nvim_create_autocmd("FileType", { group = augroup, pattern = "notes", command = "setlocal textwidth=80" })
vim.api.nvim_create_autocmd("FileType", { group = augroup, pattern = "python", command = "setlocal softtabstop=4" })
vim.api.nvim_create_autocmd("FileType", { group = augroup, pattern = "python", command = "setlocal tabstop=4" })
vim.api.nvim_create_autocmd("FileType", { group = augroup, pattern = "scss", command = "setlocal iskeyword+=-" })
vim.api.nvim_create_autocmd("FileType", { group = augroup, pattern = "scss", command = "setlocal iskeyword+=@-@" })
vim.api.nvim_create_autocmd("FileType", { group = augroup, pattern = "scss", command = "setlocal softtabstop=2" })
vim.api.nvim_create_autocmd("FileType", { group = augroup, pattern = "scss", command = "setlocal tabstop=2" })
vim.api.nvim_create_autocmd("FileType", { group = augroup, pattern = "sh", command = "setlocal softtabstop=4" })
vim.api.nvim_create_autocmd("FileType", { group = augroup, pattern = "text", command = "setlocal textwidth=80" })
vim.api.nvim_create_autocmd("FileType", { group = augroup, pattern = "yaml", command = "setlocal expandtab" })
vim.api.nvim_create_autocmd("InsertLeave", { group = augroup, command = "setlocal nopaste" })

-- packer.nvim -----------------------------------------------------------

map("n", "<Leader>li", ":PackerInstall<CR>")
map("n", "<Leader>ls", ":PackerSync<CR>")
map("n", "<Leader>lu", ":PackerUpdate<CR>")

-- telescope.nvim --------------------------------------------------------

require("telescope").setup {}

-- General settings are here. LSP-related are with nvim-lspconfig.
map("n", "<Leader>ff", "<Cmd>Telescope find_files<CR>")
map("n", "<Leader>td", "<Cmd>Telescope diagnostics<CR>")
map("n", "<Leader>tg", "<Cmd>Telescope git_branches<CR>")
map("n", "<Leader>th", "<Cmd>Telescope help_tags<CR>")
map("n", "<Leader>tk", "<Cmd>Telescope keymaps<CR>")
map("n", "<Leader>tl", "<Cmd>Telescope live_grep<CR>")

-- Comment.nvim ----------------------------------------------------------

require('Comment').setup {
    mappings = {
        basic = false,
        extra = false,
    }
}

local comment_opts = { expr = true, remap = true, replace_keycodes = false }

vim.keymap.set('n', '<Leader>cb', "v:count == 0 ? '<Plug>(comment_toggle_blockwise_current)' : '<Plug>(comment_toggle_blockwise_count)'", comment_opts)
vim.keymap.set('n', '<Leader>cc', "v:count == 0 ? '<Plug>(comment_toggle_linewise_current)' : '<Plug>(comment_toggle_linewise_count)'", comment_opts)
vim.keymap.set('n', '<Leader>cM', '<Plug>(comment_toggle_blockwise)')
vim.keymap.set('n', '<Leader>cm', '<Plug>(comment_toggle_linewise)')
vim.keymap.set('v', '<Leader>cC', '<Plug>(comment_toggle_blockwise_visual)')
vim.keymap.set('v', '<Leader>cc', '<Plug>(comment_toggle_linewise_visual)')

-- lazygit.nvim ----------------------------------------------------------

map("n", "<Leader>gg", ":LazyGit<CR>", { silent = true })

-- nvim-hlslens ----------------------------------------------------------

require("hlslens").setup {
    enable_incsearch = true,
}

local hlslens_opts = { silent = true }

map("i", "<C-l>", "<C-o>:nohlsearch<CR>")
map("n", "<C-l>", ":nohlsearch<CR><C-l>")
map('n', '#', "#<Cmd>lua require('hlslens').start()<CR>", hlslens_opts)
map('n', '*', "*<Cmd>lua require('hlslens').start()<CR>", hlslens_opts)
map('n', 'g#', "g#<Cmd>lua require('hlslens').start()<CR>", hlslens_opts)
map('n', 'g*', "g*<Cmd>lua require('hlslens').start()<CR>", hlslens_opts)
map('n', 'n', "<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>", hlslens_opts)

-- LuaSnip ---------------------------------------------------------------

require("luasnip.loaders.from_snipmate").lazy_load()

-- XXX Do edits in a split to get reloading to work.
map("n", "<Leader>se", "<Cmd>split +lua\\ require('luasnip.loaders').edit_snippet_files()<CR>")
map("n", "<Leader>sl", "<Cmd>lua require('luasnip.loaders.from_snipmate').lazy_load()<CR>")

vim.cmd "imap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'"
vim.cmd "imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'"
vim.cmd "inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr>"
vim.cmd "smap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'"
vim.cmd "snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<Cr>"
vim.cmd "snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<Cr>"

-- lightline -------------------------------------------------------------

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

-- CamelCaseMotion -------------------------------------------------------

map("", ",b", "<Plug>CamelCaseMotion_b", { silent = true })
map("", ",w", "<Plug>CamelCaseMotion_w", { silent = true })

-- fugitive --------------------------------------------------------------

map("n", "<Leader>gb", ":Git blame<CR>")
map("n", "<Leader>gc", ":Git commit --verbose<CR>")
map("n", "<Leader>gp", ":Git push --verbose<CR>")
map("n", "<Leader>gw", ":Gwrite<CR>")

-- emmet-vim -------------------------------------------------------------

vim.g.user_emmet_install_global = 0

-- nvim-lsp-installer ----------------------------------------------------

-- This setup must come before any lspconfig setup.
require("nvim-lsp-installer").setup {}

-- nvim-lspconfig --------------------------------------------------------

function on_attach(client, bufnr)
    local on_attach_opts = { silent=true, buffer=bufnr }

    map("n", "<Leader>tc", "<Cmd>Telescope lsp_incoming_calls<CR>", on_attach_opts)
    map("n", "<Leader>tC", "<Cmd>Telescope lsp_outgoing_calls<CR>", on_attach_opts)
    map("n", "<Leader>tD", "<Cmd>Telescope lsp_definitions<CR>", on_attach_opts)
    map("n", "<Leader>ti", "<Cmd>Telescope lsp_implementations<CR>", on_attach_opts)
    map("n", "<Leader>tr", "<Cmd>Telescope lsp_references<CR>", on_attach_opts)
    map("n", "<Leader>ts", "<Cmd>Telescope lsp_document_symbols<CR>", on_attach_opts)
    map("n", "<Leader>tt", "<Cmd>Telescope lsp_type_definitions<CR>", on_attach_opts)

    map('n', '<C-k>', vim.lsp.buf.signature_help, on_attach_opts)
    map('n', '<Leader>lc', vim.lsp.buf.code_action, on_attach_opts)
    map('n', '<Leader>lD', vim.lsp.buf.declaration, on_attach_opts)
    map('n', '<Leader>ld', vim.lsp.buf.definition, on_attach_opts)
    map('n', '<Leader>li', vim.lsp.buf.implementation, on_attach_opts)
    map('n', '<Leader>lr', vim.lsp.buf.references, on_attach_opts)
    map('n', '<Leader>lR', vim.lsp.buf.rename, on_attach_opts)
    map('n', '<Leader>lt', vim.lsp.buf.type_definition, on_attach_opts)
    map('n', 'K', vim.lsp.buf.hover, on_attach_opts)

end

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics,
    {
        -- Disable hints for signs and virtual_text (but leave underline) since
        -- Neovim LSP seems to treat hints as diagnostics. Also, hints are
        -- sometimes not useful.
        signs = { severity = { min = vim.diagnostic.severity.INFO } },
        virtual_text = { severity = { min = vim.diagnostic.severity.INFO } },
    }
)

local capabilities = require('cmp_nvim_lsp').update_capabilities(
    vim.lsp.protocol.make_client_capabilities()
)

local lspconfig = require("lspconfig")

lspconfig.bashls.setup {
    capabilities = capabilities,
    on_attach = on_attach,
}

lspconfig.cssls.setup {
    capabilities = capabilities,
    on_attach = on_attach,
}

lspconfig.html.setup {
    capabilities = capabilities,
    on_attach = on_attach,
}

lspconfig.jsonls.setup {
    capabilities = capabilities,
    on_attach = on_attach,
}

lspconfig.pyright.setup {
    capabilities = capabilities,
    on_attach = on_attach,
}

lspconfig.taplo.setup {
    capabilities = capabilities,
    on_attach = on_attach,
}

lspconfig.tsserver.setup {
    capabilities = capabilities,
    on_attach = on_attach,
}

-- nvim-cmp -------------------------------------------------------------

local cmp = require('cmp')

local cmp_setup_config = {
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }),
    sources = cmp.config.sources(
        {
            { name = 'luasnip' },
            { name = 'nvim_lsp' },
            { name = 'buffer' },
        }
    )
}

cmp.setup.filetype("css", cmp_setup_config)
cmp.setup.filetype("html", cmp_setup_config)
cmp.setup.filetype("javascript", cmp_setup_config)
cmp.setup.filetype("json", cmp_setup_config)
cmp.setup.filetype("python", cmp_setup_config)
cmp.setup.filetype("scss", cmp_setup_config)
cmp.setup.filetype("sh", cmp_setup_config)
cmp.setup.filetype("toml", cmp_setup_config)
cmp.setup.filetype("typescript", cmp_setup_config)

-- gitsigns.nvim ---------------------------------------------------------

require("gitsigns").setup()

-- trouble.nvim ----------------------------------------------------------

require("trouble").setup {
    icons = false,
    fold_open = "v",
    fold_closed = ">",
    indent_lines = false,
    signs = {
        error = "E",
        hint = "H",
        information = "I",
        other = "O",
        warning = "W",
    },
    use_diagnostic_signs = false,
}

map("n", "<Leader>xd", "<Cmd>TroubleToggle document_diagnostics<CR>", {silent = true })
map("n", "<Leader>xl", "<Cmd>TroubleToggle loclist<CR>", {silent = true })
map("n", "<Leader>xq", "<Cmd>TroubleToggle quickfix<CR>", {silent = true })
map("n", "<Leader>xw", "<Cmd>TroubleToggle workspace_diagnostics<CR>", {silent = true })
map("n", "<Leader>xx", "<Cmd>TroubleToggle<CR>", {silent = true })
map("n", "gR", "<Cmd>TroubleToggle lsp_references<CR>", {silent = true })

-- nvim-tree.lua ---------------------------------------------------------

 require("nvim-tree").setup({
  actions = {
      open_file = {
          quit_on_open = true,
      }
  },
  renderer = {
      icons = {
          show = {
              git = false,
          },
          glyphs = {
              default = "",
              symlink = "",
              folder = {
                  arrow_closed = "",
                  arrow_open = "",
                  default = "+",
                  open = "-",
                  empty = "+",
                  empty_open = "-",
                  symlink = "+",
                  symlink_open = "-",
              },
          },
      },
  },
})

map("n", "<Leader>nn", "<Cmd>NvimTreeToggle<CR>")
