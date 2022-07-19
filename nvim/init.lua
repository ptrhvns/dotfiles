vim.g.mapleader = "\\"

vim.opt.completeopt = {"menu", "menuone", "noselect"}
vim.opt.expandtab = true
vim.opt.fillchars = "diff:⣿"
vim.opt.foldenable = false
vim.opt.ignorecase = true
vim.opt.joinspaces = false
vim.opt.lazyredraw = true
vim.opt.list = true
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

map("n", "<Left>", "gT")
map("n", "<Right>", "gt")
map("n", "<Down>", ":tabmove -1<CR><C-l>")
map("n", "<Up>", ":tabmove +1<CR><C-l>")

map("n", "<Leader>ve", ":tabedit $MYVIMRC<CR>")
map("n", "<Leader>vs", ":source $MYVIMRC<CR>")

map("n", "<Leader>$", ":set list! number! relativenumber!<CR><C-l>")

map("n", "<Leader>W", ":%s/\\s\\+$//<CR>:let @/=''<CR>")

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

map("n", "<Leader>dt", "O{# Django template #}<Esc>:set ft=htmldjango<CR>")

local diagnostic_opts = { silent=true }
map("n", "<Leader>dn", vim.diagnostic.goto_next, diagnostic_opts)
map("n", "<Leader>dp", vim.diagnostic.goto_prev, diagnostic_opts)
map('n', '<Leader>do', vim.diagnostic.open_float, diagnostic_opts)

require("packer").startup(function(use)

    use "altercation/vim-colors-solarized"
    use "bkad/CamelCaseMotion"
    use "henrik/vim-indexed-search"
    use "hrsh7th/cmp-buffer"
    use "hrsh7th/cmp-nvim-lsp"
    use "hrsh7th/cmp-path"
    use "hrsh7th/nvim-cmp"
    use "itchyny/lightline.vim"
    use "kana/vim-smartinput"
    use "L3MON4D3/LuaSnip"
    use "lewis6991/gitsigns.nvim"
    use "MarcWeber/vim-addon-mw-utils"
    use "mattn/emmet-vim"
    use "neovim/nvim-lspconfig"
    use "nvim-lua/plenary.nvim"
    use "nvim-telescope/telescope.nvim"
    use "preservim/nerdcommenter"
    use "preservim/nerdtree"
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

local augroup = vim.api.nvim_create_augroup("agall", { clear = true })

vim.api.nvim_create_autocmd("BufNewFile,BufRead", { group = augroup, pattern = ".babelrc", command = "setlocal filetype=json" })
vim.api.nvim_create_autocmd("BufNewFile,BufRead", { group = augroup, pattern = "supervisord.conf", command = "setlocal filetype=dosini" })
vim.api.nvim_create_autocmd("BufReadPost", { group = augroup, pattern = "fugitive://*" , command = "setlocal bufhidden=delete" })
vim.api.nvim_create_autocmd("FileType", { group = augroup, pattern = "css", command = "setlocal softtabstop=2" })
vim.api.nvim_create_autocmd("FileType", { group = augroup, pattern = "css", command = "setlocal tabstop=2" })
vim.api.nvim_create_autocmd("FileType", { group = augroup, pattern = "css,html,htmldjango,javascript,sass,scss", command = "EmmetInstall" })
vim.api.nvim_create_autocmd("FileType", { group = augroup, pattern = "gitcommit", command = "setlocal nolist" })
vim.api.nvim_create_autocmd("FileType", { group = augroup, pattern = "go", command = "setlocal noexpandtab" })
vim.api.nvim_create_autocmd("FileType", { group = augroup, pattern = "go", command = "setlocal nolist" })
vim.api.nvim_create_autocmd("FileType", { group = augroup, pattern = "go", command = "setlocal softtabstop=4" })
vim.api.nvim_create_autocmd("FileType", { group = augroup, pattern = "go", command = "setlocal tabstop=4" })
vim.api.nvim_create_autocmd("FileType", { group = augroup, pattern = "gomod", command = "setlocal noexpandtab" })
vim.api.nvim_create_autocmd("FileType", { group = augroup, pattern = "gomod", command = "setlocal nolist" })
vim.api.nvim_create_autocmd("FileType", { group = augroup, pattern = "gomod", command = "setlocal softtabstop=4" })
vim.api.nvim_create_autocmd("FileType", { group = augroup, pattern = "gomod", command = "setlocal tabstop=4" })
vim.api.nvim_create_autocmd("FileType", { group = augroup, pattern = "html", command = "setlocal softtabstop=2" })
vim.api.nvim_create_autocmd("FileType", { group = augroup, pattern = "html", command = "setlocal tabstop=2" })
vim.api.nvim_create_autocmd("FileType", { group = augroup, pattern = "htmldjango", command = "setlocal commentstring={#\\ %s\\ #}" })
vim.api.nvim_create_autocmd("FileType", { group = augroup, pattern = "htmldjango", command = "setlocal softtabstop=2" })
vim.api.nvim_create_autocmd("FileType", { group = augroup, pattern = "htmldjango", command = "setlocal tabstop=2" })
vim.api.nvim_create_autocmd("FileType", { group = augroup, pattern = "javascript", command = "setlocal softtabstop=2" })
vim.api.nvim_create_autocmd("FileType", { group = augroup, pattern = "javascript", command = "setlocal tabstop=2" })
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

require("telescope").setup({
    -- TODO find more effective way to exit telescope windows
    -- defaults = {
    --     mappings = {
    --         i = {
    --             ["<Esc>"] = "close",
    --         },
    --         n = {
    --             ["<Esc>"] = "close",
    --         },
    --     },
    -- }
})

-- General settings are here. LSP-specific are with nvim-lspconfig.
map("n", "<Leader>ff", "<Cmd>Telescope find_files<CR>")
map("n", "<Leader>tb", "<Cmd>Telescope buffers<CR>")
map("n", "<Leader>td", "<Cmd>Telescope diagnostics<CR>")
map("n", "<Leader>tl", "<Cmd>Telescope live_grep<CR>")

-- NERD_commenter --------------------------------------------------------

vim.g.NERD_scss_alt_style = 1
vim.g.NERDCommentWholeLinesInVMode = 2
vim.g.NERDCreateDefaultMappings = 0
vim.g.NERDDefaultAlign = "left"
vim.g.NERDSpaceDelims = 1

map("n", "<Leader>c", "<Plug>NERDCommenterToggle<C-l>")
map("n", "<Leader>x", "<Plug>NERDCommenterSexy<C-l>")
map("v", "<Leader>c", "<Plug>NERDCommenterToggle<C-l>")
map("v", "<Leader>x", "<Plug>NERDCommenterSexy<C-l>")

-- NERD_tree -------------------------------------------------------------

vim.g.NERDChristmasTree = 1
vim.g.NERDTreeQuitOnOpen = 1
vim.g.NERDTreeWinSize = 50

map("n", "<Leader>nt", ":NERDTreeToggle<CR>")

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
        -- make the variable "greyed" out, but the Neovim client seems to show
        -- them as virtual text just like error diagnostics. Also, there are
        -- legitimate reasons why a variable might not be used (e.g. a function
        -- used by a framework that requires arguments that aren't used).
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

cmp.setup.filetype("javascript", cmp_setup_config)
cmp.setup.filetype("python", cmp_setup_config)

-- gitsigns.nvim --------------------------------------------------------

require("gitsigns").setup()
