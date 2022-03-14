-- local options = {
--   backup = false,                          -- creates a backup file
-- }
-- 
-- vim.opt.shortmess:append "c"
-- 
-- for k, v in pairs(options) do
--   vim.opt[k] = v
-- end
-- 
-- vim.cmd [[set iskeyword+=-]]

-- local keymap_opts = { noremap = true, silent = true }
-- local keymap = vim.api.nvim_set_keymap

local cmp_ok, cmp = pcall(require, "cmp")
if not cmp_ok then
    return
end

local luasnip_ok, luasnip = pcall(require, "luasnip")
if not cmp_ok then
    return
end

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = {
        ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
        ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
        ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
        ['<C-e>'] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        }),
        ['<C-l>'] = cmp.mapping.confirm({ select = true }),
    },
    sources = cmp.config.sources(
        {
            { name = 'nvim_lsp' },
            { name = 'path' },
            { name = 'luasnip' },
            { name = 'buffer' },
        }
    )
})
