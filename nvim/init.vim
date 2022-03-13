set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath=&runtimepath
source ~/.vimrc

lua << EOLUA

local keymap_opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

-- local cmp_ok, cmp = pcall(require, "cmp")
-- if not cmp_ok then
--     return
-- end
-- 
-- local luasnip_ok, luasnip = pcall(require, "luasnip")
-- if not cmp_ok then
--     return
-- end
-- 
-- 
-- cmp.setup({
--     snippet = {
--         expand = function(args)
--           luasnip.lsp_expand(args.body)
--         end,
--     }
-- })

EOLUA
