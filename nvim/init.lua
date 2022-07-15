vim.g.mapleader = "\\"

vim.opt.completeopt = {"menu", "menuone", "noselect"}
vim.opt.expandtab = true
vim.opt.fillchars = "diff:⣿"
vim.opt.foldenable = false
vim.opt.ignorecase = true
vim.opt.joinspaces = false
vim.opt.lazyredraw = true
vim.opt.list = true
vim.opt.listchars = "extends:❯,nbsp:~,precedes:❮,tab:▸\\ ,trail:⋅"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.shell = "/bin/bash"
vim.opt.shiftwidth = 0
vim.opt.showmode = false
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

map("n", "<C-l>", ":nohlsearch<CR><C-l>")
map("i", "<C-l>", "<C-o>:nohlsearch<CR>")

map("n", "<Leader>ip", ":set invpaste paste?<CR>")

map("n", "<Leader>iw", ":set invwrap wrap?<CR>")

map("n", "<Leader>u", ":setlocal cursorcolumn! cursorline!<CR><C-l>")

map("v", "<Leader>sd", ":sort! n<CR>")
map("v", "<Leader>ss", ":sort iu<CR>")

if not vim.g.vscode then
    map("n", "<Left>", "gT")
    map("n", "<Right>", "gt")
    map("n", "<Down>", ":tabmove -1<CR><C-l>")
    map("n", "<Up>", ":tabmove +1<CR><C-l>")
end

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

local diagnostic_opts = { silent=true }
map("n", "<Leader>dn", vim.diagnostic.goto_next, diagnostic_opts)
map("n", "<Leader>dp", vim.diagnostic.goto_prev, diagnostic_opts)
map('n', '<Leader>do', vim.diagnostic.open_float, diagnostic_opts)

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
        use "hrsh7th/cmp-buffer"
        use "hrsh7th/cmp-nvim-lsp"
        use "hrsh7th/cmp-path"
        use "hrsh7th/nvim-cmp"
        use "itchyny/lightline.vim"
        use "jamessan/vim-gnupg"
        use "L3MON4D3/LuaSnip"
        use "mattn/emmet-vim"
        use "neovim/nvim-lspconfig"
        use "preservim/nerdtree"
        use "saadparwaiz1/cmp_luasnip"
        use "tpope/vim-eunuch"
        use "tpope/vim-fugitive"
        use "williamboman/nvim-lsp-installer"

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

-- TODO convert automatic commands to Lua.
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

-- packer.nvim -----------------------------------------------------------

map("n", "<Leader>li", ":PackerInstall<CR>")
map("n", "<Leader>lu", ":PackerUpdate<CR>")

-- telescope.nvim --------------------------------------------------------

if not vim.g.vscode then
    -- General settings are here. LSP-specific are with nvim-lspconfig.
    map("n", "<Leader>ff", "<Cmd>Telescope find_files<CR>")
    map("n", "<Leader>tb", "<Cmd>Telescope buffers<CR>")
    map("n", "<Leader>td", "<Cmd>Telescope diagnostics<CR>")
    map("n", "<Leader>tl", "<Cmd>Telescope live_grep<CR>")
end

-- NERD_commenter --------------------------------------------------------

vim.g.NERD_scss_alt_style = 1
vim.g.NERDCommentWholeLinesInVMode = 2
vim.g.NERDCreateDefaultMappings = 0
vim.g.NERDDefaultAlign = "left"
vim.g.NERDSpaceDelims = 1

if not vim.g.vscode then
    map("n", "<Leader>c", "<Plug>NERDCommenterToggle<C-l>")
    map("n", "<Leader>x", "<Plug>NERDCommenterSexy<C-l>")
    map("v", "<Leader>c", "<Plug>NERDCommenterToggle<C-l>")
    map("v", "<Leader>x", "<Plug>NERDCommenterSexy<C-l>")
end

-- NERD_tree -------------------------------------------------------------

vim.g.NERDChristmasTree = 1
vim.g.NERDTreeQuitOnOpen = 1
vim.g.NERDTreeWinSize = 50

if not vim.g.vscode then
    map("n", "<Leader>nt", ":NERDTreeToggle<CR>")
end

-- gnupg -----------------------------------------------------------------

vim.g.GPGExecutable = "gpg"
vim.g.GPGPreferArmor = 1

-- LuaSnip ---------------------------------------------------------------

require("luasnip.loaders.from_snipmate").lazy_load()

if not vim.g.vscode then
    vim.cmd "imap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'"
    vim.cmd "imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'"
    vim.cmd "inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr>"
    vim.cmd "smap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'"
    vim.cmd "snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<Cr>"
    vim.cmd "snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<Cr>"
end

-- lightline -------------------------------------------------------------

if not vim.g.vscode then
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
end

-- CamelCaseMotion -------------------------------------------------------

map("", ",b", "<Plug>CamelCaseMotion_b", { silent = true })
map("", ",w", "<Plug>CamelCaseMotion_w", { silent = true })

-- fugitive --------------------------------------------------------------

if not vim.g.vscode then
    map("n", "<Leader>gb", ":Git blame<CR>")
    map("n", "<Leader>gc", ":Git commit --verbose<CR>")
    map("n", "<Leader>gp", ":Git push --verbose<CR>")
    map("n", "<Leader>gw", ":Gwrite<CR>")
end

-- emmet-vim -------------------------------------------------------------

vim.g.user_emmet_install_global = 0

-- nvim-lsp-installer ----------------------------------------------------

if not vim.g.vscode then
    -- This setup must come before any lspconfig setup.
    require("nvim-lsp-installer").setup {}
end

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

function filter_array_in_place(arr, fn)
    local new_index = 1
    local size_orig = #arr

    for old_index, v in ipairs(arr) do
        if fn(v, old_index) then
             arr[new_index] = v
             new_index = new_index + 1
        end
    end

    for i = new_index, size_orig do arr[i] = nil end
end

function filter_diagnostics(diagnostic)
    if string.match(diagnostic.source, "Pyright") then
        -- Ignore diagnostic hints about unused variables. These should normally
        -- make the variable "greyed" out, but the Neovim client shows them as
        -- virtual text just like error diagnostics. Also, there are legitimate
        -- reasons why a variable might not be used (e.g. a view function in
        -- Django must accept a request object that is never used.)
        if string.match(diagnostic.message, "is not accessed") then
            return false
        end
    end

    return true
end

function custom_on_publish_diagnostics(a, params, client_id, c, config)
    filter_array_in_place(params.diagnostics, filter_diagnostics)
    vim.lsp.diagnostic.on_publish_diagnostics(a, params, client_id, c, config)
end

if not vim.g.vscode then
    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
        custom_on_publish_diagnostics,
        {}
    )

    local capabilities = require('cmp_nvim_lsp').update_capabilities(
        vim.lsp.protocol.make_client_capabilities()
    )

    local lspconfig = require("lspconfig")

    lspconfig.pyright.setup {
        capabilities = capabilities,
        on_attach = on_attach,
    }

    lspconfig.tsserver.setup {
        capabilities = capabilities,
        on_attach = on_attach,
    }
end

-- nvim-cmp -------------------------------------------------------------

if not vim.g.vscode then
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
                { name = 'nvim_lsp' },
                { name = 'luasnip' },
            },
            {
                { name = 'buffer' },
            }
        )
    }

    cmp.setup.filetype("javascript", cmp_setup_config)
    cmp.setup.filetype("python", cmp_setup_config)
end
