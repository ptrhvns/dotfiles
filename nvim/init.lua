vim.g.mapleader = "\\"

vim.opt.breakindent = true
vim.opt.completeopt = { "menu", "menuone", "preview" }
vim.opt.expandtab = true
vim.opt.fillchars = { diff = "⣿", vert = "|" }
vim.opt.foldenable = false
vim.opt.ignorecase = true
vim.opt.joinspaces = false
vim.opt.lazyredraw = true
vim.opt.linebreak = true
vim.opt.list = true
vim.opt.listchars = { extends = "❯", nbsp = "~", precedes = "❮", tab = "▸ ", trail = "⋅" }
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

map("n", "<Leader>bdc", ":wall | bufdo bdelete<CR><C-l>")

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

function run_code_commands_format_only()
  vim.cmd [[
    write
    execute "!run-code-commands -f " . @%
    checktime
  ]]
end

map("n", "<Leader>rc", ":lua run_code_commands()<CR>")
map("n", "<Leader>rf", ":lua run_code_commands_format_only()<CR>")

map("n", "<Leader>dt", "O{# Django template #}<Esc>:set ft=htmldjango<CR>")

local diagnostic_opts = { silent = true }
map("n", "<Leader>dn", vim.diagnostic.goto_next, diagnostic_opts)
map("n", "<Leader>dp", vim.diagnostic.goto_prev, diagnostic_opts)
map('n', '<Leader>do', vim.diagnostic.open_float, diagnostic_opts)

map("v", "J", ":move '>+1<CR>gv=gv")
map("v", "K", ":move '<-2<CR>gv=gv")

vim.cmd "filetype indent on"
vim.cmd "filetype plugin on"

local augroup = vim.api.nvim_create_augroup("all", { clear = true })
local autocmd = vim.api.nvim_create_autocmd

autocmd("BufReadPost", { group = augroup, pattern = "fugitive://*" , command = "setlocal bufhidden=delete" })
autocmd("FileType", { group = augroup, pattern = "css", command = "EmmetInstall" })
autocmd("FileType", { group = augroup, pattern = "css", command = "setlocal softtabstop=2 tabstop=2" })
autocmd("FileType", { group = augroup, pattern = "gitcommit", command = "setlocal nolist" })
autocmd("FileType", { group = augroup, pattern = "go", command = "setlocal noexpandtab nolist softtabstop=4 tabstop=4" })
autocmd("FileType", { group = augroup, pattern = "gomod", command = "setlocal tabstop=4 noexpandtab nolist softtabstop=4" })
autocmd("FileType", { group = augroup, pattern = "html", command = "EmmetInstall" })
autocmd("FileType", { group = augroup, pattern = "html", command = "setlocal softtabstop=2 tabstop=2" })
autocmd("FileType", { group = augroup, pattern = "htmldjango", command = "EmmetInstall" })
autocmd("FileType", { group = augroup, pattern = "htmldjango", command = "setlocal commentstring={#\\ %s\\ #} softtabstop=2 tabstop=2" })
autocmd("FileType", { group = augroup, pattern = "javascript", command = "EmmetInstall" })
autocmd("FileType", { group = augroup, pattern = "javascript", command = "setlocal expandtab softtabstop=2 tabstop=2" })
autocmd("FileType", { group = augroup, pattern = "javascriptreact", command = "EmmetInstall" })
autocmd("FileType", { group = augroup, pattern = "javascriptreact", command = "setlocal expandtab softtabstop=2 tabstop=2" })
autocmd("FileType", { group = augroup, pattern = "lua", command = "setlocal expandtab softtabstop=2 tabstop=2" })
autocmd("FileType", { group = augroup, pattern = "markdown", command = "setlocal expandtab softtabstop=2 tabstop=2" })
autocmd("FileType", { group = augroup, pattern = "python", command = "setlocal softtabstop=4 tabstop=4" })
autocmd("FileType", { group = augroup, pattern = "rust", command = "setlocal noexpandtab nolist softtabstop=4 tabstop=4" })
autocmd("FileType", { group = augroup, pattern = "sass", command = "EmmetInstall" })
autocmd("FileType", { group = augroup, pattern = "sass", command = "setlocal softtabstop=2 tabstop=2" })
autocmd("FileType", { group = augroup, pattern = "scss", command = "EmmetInstall" })
autocmd("FileType", { group = augroup, pattern = "scss", command = "setlocal softtabstop=2 tabstop=2" })
autocmd("FileType", { group = augroup, pattern = "sh", command = "setlocal softtabstop=4" })
autocmd("FileType", { group = augroup, pattern = "text", command = "setlocal commentstring=//\\ %s" })
autocmd("FileType", { group = augroup, pattern = "typescript", command = "EmmetInstall" })
autocmd("FileType", { group = augroup, pattern = "typescript", command = "setlocal expandtab softtabstop=2 tabstop=2" })
autocmd("FileType", { group = augroup, pattern = "typescriptreact", command = "EmmetInstall" })
autocmd("FileType", { group = augroup, pattern = "typescriptreact", command = "setlocal expandtab softtabstop=2 tabstop=2" })
autocmd("FileType", { group = augroup, pattern = "yaml", command = "setlocal expandtab" })
autocmd("InsertLeave", { group = augroup, command = "setlocal nopaste" })

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

local plugins = {

  "bkad/CamelCaseMotion",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-nvim-lua",
  "hrsh7th/cmp-path",
  "hrsh7th/nvim-cmp",
  { "j-hui/fidget.nvim", tag = "legacy", event = "LspAttach" },
  "kana/vim-smartinput",
  "kyazdani42/nvim-tree.lua",
  "L3MON4D3/LuaSnip",
  "lewis6991/gitsigns.nvim",
  "MarcWeber/vim-addon-mw-utils",
  "mattn/emmet-vim",
  "neovim/nvim-lspconfig",
  "numToStr/Comment.nvim",
  "nvim-lua/plenary.nvim",
  "nvim-lualine/lualine.nvim",
  "nvim-telescope/telescope-ui-select.nvim",
  "nvim-telescope/telescope.nvim",
  "nvim-treesitter/nvim-treesitter",
  "rebelot/kanagawa.nvim",
  "saadparwaiz1/cmp_luasnip",
  "sheerun/vim-polyglot",
  "tomtom/tlib_vim",
  "tpope/vim-eunuch",
  "tpope/vim-fugitive",
  "tpope/vim-surround",
  "williamboman/mason-lspconfig.nvim",
  "williamboman/mason.nvim",

}

require("lazy").setup(plugins, {})

-- ///////////////////////////////////////////////////////////////////////
-- nvim-treesitter

require('nvim-treesitter.configs').setup {
  ensure_installed = {
    "bash",
    "css",
    "go",
    "html",
    "javascript",
    "json",
    "lua",
    "python",
    "rust",
    "scss",
    "typescript",
    "vim",
  },
  highlight = {
    enable = true,
  },
  sync_install = false,
}

-- ///////////////////////////////////////////////////////////////////////
-- kanagawa.nvim

require('kanagawa').setup({
    transparent = true,
})

vim.cmd "colorscheme kanagawa"

vim.cmd "highlight LineNr guibg=NONE guifg=#ffa066"
vim.cmd "highlight LineNrAbove guibg=NONE guifg=#54546d"
vim.cmd "highlight LineNrBelow guibg=NONE guifg=#54546d"
vim.cmd "highlight Normal guibg=NONE guifg=#c5c9c5"
vim.cmd "highlight SignColumn guibg=NONE"

-- ///////////////////////////////////////////////////////////////////////
-- telescope.nvim

local telescope = require("telescope")
local telescope_builtin = require("telescope.builtin")

telescope.setup {
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {}
    }
  }
}

telescope.load_extension("ui-select")

-- General settings are here. LSP-related are with nvim-lspconfig.
map("n", "<Leader>ff", telescope_builtin.find_files)
map("n", "<Leader>td", telescope_builtin.diagnostics)
map("n", "<Leader>tg", telescope_builtin.git_files)
map("n", "<Leader>th", telescope_builtin.help_tags)
map("n", "<Leader>tk", telescope_builtin.keymaps)
map("n", "<Leader>tl", telescope_builtin.live_grep)

-- ///////////////////////////////////////////////////////////////////////
-- Comment.nvim

require('Comment').setup {
  mappings = {
    basic = false,
    extra = false,
  },
}

local comment_opts = { expr = true, remap = true, replace_keycodes = false }

map('n', '<Leader>cb', "v:count == 0 ? '<Plug>(comment_toggle_blockwise_current)' : '<Plug>(comment_toggle_blockwise_count)'", comment_opts)
map('n', '<Leader>cc', "v:count == 0 ? '<Plug>(comment_toggle_linewise_current)' : '<Plug>(comment_toggle_linewise_count)'", comment_opts)
map('n', '<Leader>cM', '<Plug>(comment_toggle_blockwise)')
map('n', '<Leader>cm', '<Plug>(comment_toggle_linewise)')
map('v', '<Leader>cC', '<Plug>(comment_toggle_blockwise_visual)')
map('v', '<Leader>cc', '<Plug>(comment_toggle_linewise_visual)')

-- ///////////////////////////////////////////////////////////////////////
-- LuaSnip

require("luasnip.loaders.from_snipmate").lazy_load()

-- XXX Do edits in a split to get reloading to work.
map("n", "<Leader>se", ":split +lua\\ require('luasnip.loaders').edit_snippet_files()<CR>")
map("n", "<Leader>sl", ":lua require('luasnip.loaders.from_snipmate').lazy_load()<CR>")

vim.cmd "imap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'"
vim.cmd "imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'"
vim.cmd "inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr>"
vim.cmd "smap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'"
vim.cmd "snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<Cr>"
vim.cmd "snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<Cr>"

-- ///////////////////////////////////////////////////////////////////////
-- CamelCaseMotion

map("", ",b", "<Plug>CamelCaseMotion_b", { silent = true })
map("", ",w", "<Plug>CamelCaseMotion_w", { silent = true })

-- ///////////////////////////////////////////////////////////////////////
-- fugitive

map("n", "<Leader>gb", ":Git blame<CR>")
map("n", "<Leader>gc", ":Git commit --verbose<CR>")
map("n", "<Leader>gp", ":Git push --verbose<CR>")
map("n", "<Leader>gw", ":Gwrite<CR>")

-- ///////////////////////////////////////////////////////////////////////
-- emmet-vim

vim.g.user_emmet_install_global = 0

-- ///////////////////////////////////////////////////////////////////////
-- mason.nvim

require("mason").setup {}

map("n", "<Leader>lm", ":Mason<CR>")

-- ///////////////////////////////////////////////////////////////////////
-- mason-lspconfig.nvim

require("mason-lspconfig").setup {}

-- ///////////////////////////////////////////////////////////////////////
-- nvim-lspconfig

function on_attach(client, bufnr)
  local on_attach_opts = { silent=true, buffer=bufnr }

  map("n", "<Leader>tc", ":Telescope lsp_incoming_calls<CR>", on_attach_opts)
  map("n", "<Leader>tC", ":Telescope lsp_outgoing_calls<CR>", on_attach_opts)
  map("n", "<Leader>tD", ":Telescope lsp_definitions<CR>", on_attach_opts)
  map("n", "<Leader>ti", ":Telescope lsp_implementations<CR>", on_attach_opts)
  map("n", "<Leader>tr", ":Telescope lsp_references<CR>", on_attach_opts)
  map("n", "<Leader>ts", ":Telescope lsp_document_symbols<CR>", on_attach_opts)
  map("n", "<Leader>tt", ":Telescope lsp_type_definitions<CR>", on_attach_opts)

  map('n', '<C-k>', vim.lsp.buf.signature_help, on_attach_opts)
  map('n', '<Leader>lb', ":LspRestart<CR>", on_attach_opts)
  map('n', '<Leader>lc', vim.lsp.buf.code_action, on_attach_opts)
  map('n', '<Leader>lD', vim.lsp.buf.declaration, on_attach_opts)
  map('n', '<Leader>ld', vim.lsp.buf.definition, on_attach_opts)
  map('n', '<Leader>lf', vim.lsp.buf.format, on_attach_opts)
  map('n', '<Leader>li', vim.lsp.buf.implementation, on_attach_opts)
  map('n', '<Leader>lr', vim.lsp.buf.references, on_attach_opts)
  map('n', '<Leader>lR', vim.lsp.buf.rename, on_attach_opts)
  map('n', '<Leader>lt', vim.lsp.buf.type_definition, on_attach_opts)
  map('n', 'K', vim.lsp.buf.hover, on_attach_opts)

end

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover, {
    border = "single"
  }
)

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

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
  vim.lsp.handlers.signature_help, {
    border = "single"
  }
)

vim.diagnostic.config{
  float={border="single"}
}

local capabilities = require('cmp_nvim_lsp').default_capabilities()
local lspconfig = require("lspconfig")

lspconfig.bashls.setup {
  capabilities = capabilities,
  on_attach = on_attach,
}

lspconfig.cssls.setup {
  capabilities = capabilities,
  on_attach = on_attach,
}

lspconfig.gopls.setup {
  capabilities = capabilities,
  on_attach = on_attach,
}

lspconfig.html.setup {
  capabilities = capabilities,
  on_attach = on_attach,
}

lspconfig.pylsp.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    pylsp = {
      plugins = {
        -- Commands to run:
        -- :PylspInstall pylsp-mypy
        -- :PylspInstall pylsp-rope
        -- :PylspInstall python-lsp-ruff

        autopep8 = { enabled = false },
        mccabe = { enabled = false },
        pycodestyle = { enabled = false },
        pydocstyle = { enabled = false },
        pyflakes = { enabled = false },
        pylint = { enabled = false },
        yapf = { enabled = false },
      },
    },
  },
}

lspconfig.rust_analyzer.setup {
  capabilities = capabilities,
  on_attach = on_attach,
}

lspconfig.tsserver.setup {
  capabilities = capabilities,
  on_attach = on_attach,
}

-- ///////////////////////////////////////////////////////////////////////
-- nvim-cmp

local cmp = require('cmp')

local cmp_setup_config = {
  formatting = {
    format = function(entry, item)
      local menu_text ={
        nvim_lsp = 'LSP',
        luasnip = 'LuaSnip',
        buffer = 'Buffer',
        path = 'Path'
      }
      item.menu = menu_text[entry.source.name]
      return item
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  }),
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  sources = cmp.config.sources(
    {
      { name = 'path' },
      { name = 'nvim_lsp' },
      { name = 'nvim_lua'},
      { name = 'buffer' },
      { name = 'luasnip' },
    }
  ),
}

local filetype = cmp.setup.filetype

filetype("bash", cmp_setup_config)
filetype("css", cmp_setup_config)
filetype("go", cmp_setup_config)
filetype("html", cmp_setup_config)
filetype("javascript", cmp_setup_config)
filetype("json", cmp_setup_config)
filetype("lua", cmp_setup_config)
filetype("python", cmp_setup_config)
filetype("rust", cmp_setup_config)
filetype("scss", cmp_setup_config)
filetype("sh", cmp_setup_config)
filetype("toml", cmp_setup_config)
filetype("typescript", cmp_setup_config)
filetype("typescriptreact", cmp_setup_config)

-- ///////////////////////////////////////////////////////////////////////
-- gitsigns.nvim

require("gitsigns").setup()

-- ///////////////////////////////////////////////////////////////////////
-- nvim-tree.lua

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
  view = {
    adaptive_size = true,
    centralize_selection = true,
  },
})

map("n", "<Leader>nn", ":NvimTreeToggle<CR>")

-- ///////////////////////////////////////////////////////////////////////
-- fidget.nvim

require("fidget").setup()

-- ///////////////////////////////////////////////////////////////////////
-- lualine.nvim

require('lualine').setup {
  options = {
    component_separators = { left = "", right = ""},
    icons_enabled = false,
    section_separators = { left = "", right = ""},
  },
  sections = {
    lualine_c = {
      {
        "filename",
        path = 1,
      }
    }
  },
  inactive_sections = {
    lualine_c = {
      {
        "filename",
        path = 1,
      }
    }
  },
}
