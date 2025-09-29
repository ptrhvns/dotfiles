vim.g.mapleader = "\\"
vim.g.maplocalleader = "\\"

vim.opt.breakindent = true
vim.opt.clipboard:append("unnamedplus") -- Comment when flickering terminal title bar occurs.
vim.opt.completeopt = { "menu", "preview" }
vim.opt.cursorline = true
vim.opt.expandtab = true
vim.opt.fillchars = { diff = "⣿", vert = "|" }
vim.opt.foldenable = false
vim.opt.foldmethod = "indent"
vim.opt.ignorecase = true
vim.opt.inccommand = "split"
vim.opt.incsearch = false
vim.opt.iskeyword:append("-")
vim.opt.joinspaces = false
vim.opt.laststatus = 3
vim.opt.lazyredraw = true
vim.opt.linebreak = true
vim.opt.list = true
vim.opt.listchars = { extends = "❯", nbsp = "␣", precedes = "❮", tab = "» ", trail = "⋅" }
vim.opt.mouse = "a"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.shell = "/bin/bash"
vim.opt.shiftwidth = 0
vim.opt.showmode = false
vim.opt.signcolumn = "yes"
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.softtabstop = 4
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.startofline = false
vim.opt.tabstop = 4
vim.opt.textwidth = 80
vim.opt.timeout = false
vim.opt.timeoutlen = 300
vim.opt.undofile = true
vim.opt.undolevels = 1000
vim.opt.updatetime = 250
vim.opt.virtualedit = "all"

vim.keymap.set("v", "<Leader>sd", ":sort! n<CR>:sort! n<CR>")
vim.keymap.set("v", "<Leader>ss", ":sort iu<CR>")

vim.keymap.set("n", "<Left>", "gT")
vim.keymap.set("n", "<Right>", "gt")
vim.keymap.set("n", "<Down>", ":tabmove -1<CR><C-l>")
vim.keymap.set("n", "<Up>", ":tabmove +1<CR><C-l>")

vim.keymap.set("n", "<Leader>ve", ":tabedit $MYVIMRC<CR>")

vim.keymap.set("n", "<Leader>$", function ()
  vim.cmd("set list! number! relativenumber!")

  if vim.opt.signcolumn:get() == "no" then
    vim.cmd("set signcolumn=yes")
  else
    vim.cmd("set signcolumn=no")
  end
end)

vim.keymap.set("n", "<Leader>W", ":%s/\\s\\+$//<CR>:let @/=''<CR>")

vim.keymap.set("n", "<Leader>rc", function ()
  vim.cmd [[
    write
    execute "!run-code-commands " . @%
    checktime
  ]]
end)

vim.keymap.set("n", "<Leader>rf", function ()
  vim.cmd [[
    write
    execute "!run-code-commands -f " . @%
    checktime
  ]]
end)

vim.keymap.set("n", "<Leader>dn", vim.diagnostic.goto_next, { silent = true })
vim.keymap.set("n", "<Leader>dp", vim.diagnostic.goto_prev, { silent = true })
vim.keymap.set('n', '<Leader>do', vim.diagnostic.open_float, { silent = true })

vim.keymap.set("v", "<Leader>ct", ":'<,'>!column -o ' ' -t<CR>")

vim.keymap.set("n", "<Leader>gs", ":lua require('gitsigns').next_hunk()<CR>")

vim.keymap.set("n", "<Leader>ml", ":diffget LO<CR>")
vim.keymap.set("n", "<Leader>mr", ":diffget RE<CR>")

vim.keymap.set("n", "<Leader>nf", ":lua vim.opt.foldenable = false")

vim.keymap.set("n", "*", ":keepjumps normal! mi*`i<CR>", { noremap = true })
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")

vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

vim.keymap.set("n", "J", "mzJ`z")

vim.cmd "filetype indent on"
vim.cmd "filetype plugin on"

local augroup = vim.api.nvim_create_augroup("all", { clear = true })
local autocmd = vim.api.nvim_create_autocmd

autocmd(
  {
    "BufNewFile",
    "BufRead",
  },
  {
    callback = function()
      vim.cmd [[
        if getline(1) =~ '^#!.*/bin/env\s\+-S\s\+uv\>'
          setfiletype python
        endif
      ]]
    end,
    group = augroup,
    pattern = "*",
  }
)

autocmd(
  "BufReadPost",
  {
    command = "setlocal bufhidden=delete",
    group = augroup,
    pattern = "fugitive://*" ,
  }
)

autocmd(
  "FileType",
  {
    command = "setlocal softtabstop=2 tabstop=2",
    group = augroup,
    pattern = "css",
  }
)

autocmd(
  "FileType",
  {
    command = "setlocal nolist",
    group = augroup,
    pattern = "gitcommit",
  }
)

autocmd(
  "FileType",
  {
    command = "setlocal noexpandtab nolist softtabstop=4 tabstop=4",
    group = augroup,
    pattern = "go",
  }
)

autocmd(
  "FileType",
  {
    command = "setlocal tabstop=4 noexpandtab nolist softtabstop=4",
    group = augroup,
    pattern = "gomod",
  }
)

autocmd(
  "FileType",
  {
    command = "setlocal softtabstop=2 tabstop=2",
    group = augroup,
    pattern = "html",
  }
)

autocmd(
  "FileType",
  {
    command = "setlocal expandtab softtabstop=2 tabstop=2",
    group = augroup,
    pattern = "javascript",
  }
)

autocmd(
  "FileType",
  {
    command = "setlocal commentstring=//\\ %s",
    group = augroup,
    pattern = "Jenkinsfile",
  }
)

autocmd(
  "FileType",
  {
    command = "setlocal expandtab softtabstop=2 tabstop=2",
    group = augroup,
    pattern = "lua",
  }
)

autocmd(
  "FileType",
  {
    command = "setlocal expandtab softtabstop=2 tabstop=2",
    group = augroup,
    pattern = "markdown",
  }
)

autocmd(
  "FileType",
  {
    command = "setlocal expandtab softtabstop=4 tabstop=4",
    group = augroup,
    pattern = "python",
  }
)

autocmd(
  "FileType",
  {
    command = "setlocal softtabstop=4",
    group = augroup,
    pattern = "sh",
  }
)

autocmd(
  "FileType",
  {
    command = "setlocal commentstring=//\\ %s",
    group = augroup,
    pattern = "text",
  }
)

autocmd(
  "FileType",
  {
    command = "setlocal expandtab softtabstop=2 tabstop=2",
    group = augroup,
    pattern = "typescript",
  }
)

autocmd(
  "FileType",
  {
    command = "setlocal expandtab",
    group = augroup,
    pattern = "yaml",
  }
)

autocmd(
  "InsertLeave",
  {
    command = "setlocal nopaste",
    group = augroup,
  }
)

autocmd(
  "VimResized",
  {
    callback = function()
      vim.cmd("tabdo wincmd =")
    end,
    group = augroup,
  }
)

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"

  local out = vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    lazyrepo,
    lazypath
  })

  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
        { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
        { out, "WarningMsg" },
        { "\nPress any key to exit..." },
      },
      true,
      {}
    )

    vim.fn.getchar()
    os.exit(1)
  end
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup(
  {

    {
      "bkad/CamelCaseMotion",
      keys = {
        { ",b", "<Plug>CamelCaseMotion_b", mode = "" },
        { ",w", "<Plug>CamelCaseMotion_w", mode = "" },
      },
    },

    {
      "catppuccin/nvim",
      config = function()
        require("catppuccin").setup({ transparent_background = true })
        vim.cmd.colorscheme "catppuccin"
      end,
    },

    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-path",

    {
      "hrsh7th/nvim-cmp",
      config = function()
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
          sources = cmp.config.sources({
            { name = 'path' },
            { name = 'nvim_lsp' },
            { name = 'nvim_lua'},
            { name = 'buffer' },
            { name = 'luasnip' },
          }),
        }

        local filetype = cmp.setup.filetype

        filetype("bash", cmp_setup_config)
        filetype("css", cmp_setup_config)
        filetype("dockerfile", cmp_setup_config)
        filetype("go", cmp_setup_config)
        filetype("html", cmp_setup_config)
        filetype("javascript", cmp_setup_config)
        filetype("json", cmp_setup_config)
        filetype("lua", cmp_setup_config)
        filetype("python", cmp_setup_config)
        filetype("sh", cmp_setup_config)
        filetype("toml", cmp_setup_config)
        filetype("typescript", cmp_setup_config)
        filetype("yaml", cmp_setup_config)

      end
    },

    {
      "j-hui/fidget.nvim",
      config = function()
        require("fidget").setup()
      end,
    },

    "kana/vim-smartinput",

    {
      "kyazdani42/nvim-tree.lua",
      keys = {
        { "<Leader>nn", ":NvimTreeToggle<CR>", mode = "n" }
      },
      config = function()
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
      end,
    },

    {
      "L3MON4D3/LuaSnip",
      keys = {
        -- HACK: Do edits in a split to get reloading to work.
        {
          "<Leader>se",
          ":split +lua\\ require('luasnip.loaders').edit_snippet_files()<CR>",
          mode = "n",
        },
        {
          "<Leader>sl",
          ":lua require('luasnip.loaders.from_snipmate').lazy_load()<CR>",
          mode = "n",
        },
        {
          "<C-k>",
          function()
            require("luasnip").expand()
          end,
          mode = "i",
          silent = true,
        },
        {
          "<C-l>",
          function()
            require("luasnip").jump(1)
          end,
          mode = {"i", "s"},
          silent = true,
        },
        {
          "<C-h>",
          function()
            require("luasnip").jump(-1)
          end,
          mode = {"i", "s"},
          silent = true,
        },
        {
          "<C-e>",
          function()
            local luasnip = require("luasnip")

            if luasnip.choice_active() then
              luasnip.change_choice(1)
            end
          end,
          mode = {"i", "s"},
          silent = true,
        }
      },
      config = function()
        require("luasnip.loaders.from_snipmate").lazy_load()
      end
    },

    {
      "lewis6991/gitsigns.nvim",
      config = function()
        require("gitsigns").setup()
      end,
    },

    "MarcWeber/vim-addon-mw-utils",
    "neovim/nvim-lspconfig",

    {
      "numToStr/Comment.nvim",
      keys = {
        {
          "<Leader>cb",
          "v:count == 0 ? '<Plug>(comment_toggle_blockwise_current)' : '<Plug>(comment_toggle_blockwise_count)'",
          expr = true,
          mode = "n",
          remap = true,
          replace_keycodes = false,
        },
        {
          "<Leader>cc",
          "v:count == 0 ? '<Plug>(comment_toggle_linewise_current)' : '<Plug>(comment_toggle_linewise_count)'",
          expr = true,
          mode = 'n',
          remap = true,
          replace_keycodes = false,
        },
        {
          "<Leader>cM",
          "<Plug>(comment_toggle_blockwise)",
          mode = "n",
        },
        {
          "<Leader>cm",
          "<Plug>(comment_toggle_linewise)",
          mode = 'n',
        },
        {
          "<Leader>cC",
          "<Plug>(comment_toggle_blockwise_visual)",
          mode = "v",
        },
        {
          "<Leader>cc",
          "<Plug>(comment_toggle_linewise_visual)",
          mode = "v",
        },
      },
      config = function()
        require('Comment').setup({
          mappings = {
            basic = false,
            extra = false,
          },
        })
      end,

    },

    "nvim-lua/plenary.nvim",

    {
      "nvim-lualine/lualine.nvim",
      config = function()
        require('lualine').setup({
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
        })
      end,
    },

    "nvim-telescope/telescope-ui-select.nvim",

    {
      "nvim-telescope/telescope.nvim",
      keys = {
        -- General settings are here. LSP-related are with nvim-lspconfig.
        {
          "<Leader>ff",
          function()
            require("telescope.builtin").find_files()
          end,
          mode = "n",
        },
        {
          "<Leader>td",
          function()
            require("telescope.builtin").diagnostics()
          end,
          mode = "n",
        },
        {
          "<Leader>tg",
          function()
            require("telescope.builtin").git_files()
          end,
          mode = "n",
        },
        {
          "<Leader>th",
          function()
            require("telescope.builtin").help_tags()
          end,
          mode = "n",
        },
        {
          "<Leader>tk",
          function()
            require("telescope.builtin").keymaps()
          end,
          mode = "n",
        },
        {
          "<Leader>tl",
          function()
            require("telescope.builtin").live_grep()
          end,
          mode = "n",
        },
      },
      config = function()
        local telescope = require("telescope")

        telescope.setup({
          extensions = {
            ["ui-select"] = {
              require("telescope.themes").get_dropdown({})
            },
          },
        })

        telescope.load_extension("ui-select")
      end
    },

    {
      "nvim-treesitter/nvim-treesitter",
      config = function()
        require('nvim-treesitter.configs').setup({
            ensure_installed = {

              "bash",
              "css",
              "diff",
              "dockerfile",
              "go",
              "html",
              "javascript",
              "json",
              "lua",
              "markdown",
              "python",
              "toml",
              "tsx",
              "typescript",
              "vim",
              "vimdoc",
              "yaml",

            },
            highlight = {
              enable = true,
            },
            sync_install = false,
          })
      end,
    },

    "saadparwaiz1/cmp_luasnip",
    "sheerun/vim-polyglot",
    "tomtom/tlib_vim",
    "tpope/vim-eunuch",

    {
      "tpope/vim-fugitive",
      keys = {
        { "<Leader>gb", ":Git blame<CR>", mode = "n" },
        { "<Leader>gc", ":Git commit --verbose<CR>", mode = "n" },
        { "<Leader>gp", ":Git push --verbose<CR>", mode = "n" },
        { "<Leader>gw", ":Gwrite<CR>", mode = "n" }
      },
    },

    "tpope/vim-surround",

    {
      "williamboman/mason-lspconfig.nvim",
      config = function()
        require("mason-lspconfig").setup({})
      end,
    },

    {
      "williamboman/mason.nvim",
      config = function()
        require("mason").setup({})
      end,
    },

  },
  {
    ui = {
      icons = {
        cmd = "",
        config = "",
        event = "",
        favorite = "",
        ft = "",
        init = "",
        import = "",
        keys = "",
        lazy = "",
        loaded = "",
        not_loaded = "",
        plugin = "",
        runtime = "",
        require = "",
        source = "",
        start = "",
        task = "",
        list = {
          "",
          "",
          "",
          "",
        },
      },
    }
  }
)

-- HACK: Setup LSP servers outside of lazy setup to avoid some issues (e.g.
-- :PylspInstall not being available).

local function on_attach(client, bufnr)
  local on_attach_opts = { silent = true, buffer = bufnr }

  vim.keymap.set("n", "<Leader>tc", ":Telescope lsp_incoming_calls<CR>", on_attach_opts)
  vim.keymap.set("n", "<Leader>tC", ":Telescope lsp_outgoing_calls<CR>", on_attach_opts)
  vim.keymap.set("n", "<Leader>tD", ":Telescope lsp_definitions<CR>", on_attach_opts)
  vim.keymap.set("n", "<Leader>ti", ":Telescope lsp_implementations<CR>", on_attach_opts)
  vim.keymap.set("n", "<Leader>tr", ":Telescope lsp_references<CR>", on_attach_opts)
  vim.keymap.set("n", "<Leader>ts", ":Telescope lsp_document_symbols<CR>", on_attach_opts)
  vim.keymap.set("n", "<Leader>tt", ":Telescope lsp_type_definitions<CR>", on_attach_opts)

  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, on_attach_opts)
  vim.keymap.set('n', '<Leader>lb', ":LspRestart<CR>", on_attach_opts)
  vim.keymap.set('n', '<Leader>lc', vim.lsp.buf.code_action, on_attach_opts)
  vim.keymap.set('n', '<Leader>lD', vim.lsp.buf.declaration, on_attach_opts)
  vim.keymap.set('n', '<Leader>ld', vim.lsp.buf.definition, on_attach_opts)
  vim.keymap.set('n', '<Leader>lf', vim.lsp.buf.format, on_attach_opts)
  vim.keymap.set('n', '<Leader>li', vim.lsp.buf.implementation, on_attach_opts)
  vim.keymap.set('n', '<Leader>lr', vim.lsp.buf.references, on_attach_opts)
  vim.keymap.set('n', '<Leader>lR', vim.lsp.buf.rename, on_attach_opts)
  vim.keymap.set('n', '<Leader>lt', vim.lsp.buf.type_definition, on_attach_opts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, on_attach_opts)

end

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover, {
    border = "single"
  }
)

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics,
  {
    -- HACK: Disable hints for signs and virtual_text (but leave
    -- underline) since Neovim LSP seems to treat hints as diagnostics.
    -- Also, hints are sometimes not useful.
    signs = { severity = { min = vim.diagnostic.severity.INFO } },
    virtual_text = { severity = { min = vim.diagnostic.severity.INFO } },
  }
)

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
  vim.lsp.handlers.signature_help,
  { border = "single" }
)

vim.diagnostic.config({
  float={border="single"}
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()
local mason_registry = require("mason-registry")

local function setup_lsp_server(package_name, lsp_name, config)
  if mason_registry.is_installed(package_name) then
    vim.lsp.config(lsp_name, config)
  end
end

local default_lsp_config = {
  capabilities = capabilities,
  on_attach = on_attach,
}

setup_lsp_server("bash-language-server", "bashls", default_lsp_config)
setup_lsp_server("css-lsp", "cssls", default_lsp_config)
setup_lsp_server("dockerfile-language-server", "dockerls", default_lsp_config)
setup_lsp_server("gopls", "gopls", default_lsp_config)
setup_lsp_server("html-lsp", "html", default_lsp_config)
setup_lsp_server("json-lsp", "jsonls", default_lsp_config)

setup_lsp_server("python-lsp-server", "pylsp", {
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    pylsp = {
      plugins = {
        -- Commands to run:
        -- :PylspInstall pylsp-mypy
        -- :PylspInstall pylsp-rope
        --   HACK: fix rope bug:
        --    touch ~/.local/share/nvim/mason/packages/python-lsp-server/venv/lib/<python-version>/site-packages/pylsp/plugins/rope_rename.py
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
})

setup_lsp_server("typescript-language-server", "ts_ls", default_lsp_config)
setup_lsp_server("taplo", "taplo", default_lsp_config)
setup_lsp_server("yaml-language-server", "yamlls", default_lsp_config)
