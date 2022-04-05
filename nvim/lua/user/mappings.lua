local keymap_opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

keymap("", ",b", "<Plug>CamelCaseMotion_b", keymap_opts)
keymap("", ",w", "<Plug>CamelCaseMotion_w", keymap_opts)

keymap("i", "<C-l>", "<C-o>:nohlsearch<CR>", keymap_opts)
keymap("n", "<C-l>", ":nohlsearch<CR><C-l>", keymap_opts)

keymap("n", "<C-p>", ":Files<CR>", keymap_opts)
keymap("n", "<Leader>rg", ":Rg ", keymap_opts)

keymap("n", "<Down>", ":tabmove -1<CR><C-l>", keymap_opts)
keymap("n", "<Left>", "gT", keymap_opts)
keymap("n", "<Right>", "gt", keymap_opts)
keymap("n", "<Up>", ":tabmove +1<CR><C-l>", keymap_opts)

keymap("n", "<Leader>$", ":set list! number! relativenumber!<CR><C-l>", keymap_opts)
keymap("n", "<Leader>u", ":setlocal cursorcolumn! cursorline!<CR><C-l>", keymap_opts)
keymap("n", "<Leader>W", ":%s/\\s\\+$//<CR>:let @/=''<CR>", keymap_opts)
keymap("n", "<Leader>w", ":set invwrap wrap?<CR>", keymap_opts)

keymap("n", "<Leader>c", "<Plug>NERDCommenterToggle<C-l>", keymap_opts)
keymap("n", "<Leader>i", "<Plug>NERDCommenterAltDelims<C-l>", keymap_opts)
keymap("n", "<Leader>x", "<Plug>NERDCommenterSexy<C-l>", keymap_opts)
keymap("v", "<Leader>c", "<Plug>NERDCommenterToggle<C-l>", keymap_opts)
keymap("v", "<Leader>x", "<Plug>NERDCommenterSexy<C-l>", keymap_opts)

keymap("n", "<Leader>dt", "O{# Django template #}<Esc>:set ft=htmldjango<CR>", keymap_opts)
keymap("n", "<Leader>vn", "Ovim:ft=notes<Esc>:set ft=notes<CR><C-l>", keymap_opts)

keymap("n", "<Leader>ve", ":tabedit $HOME/src/personal/remote/dotfiles/vimrc<CR>", keymap_opts)
keymap("n", "<Leader>vs", ":source $MYVIMRC<CR>", keymap_opts)

keymap("n", "<Leader>f", ":call FormatFile()<CR>", keymap_opts)

keymap("n", "<Leader>gc", ":Git commit --verbose<CR>", keymap_opts)
keymap("n", "<Leader>gp", ":Git push --verbose<CR>", keymap_opts)
keymap("n", "<Leader>gs", ":Git<CR>", keymap_opts)
keymap("n", "<Leader>gw", ":Gwrite<CR>", keymap_opts)

keymap("n", "<Leader>n", ":NERDTreeToggle<CR>", keymap_opts)

keymap("n", "<Leader>ol", ":GoMetaLinter<CR>", keymap_opts)

keymap("n", "<Leader>p", ":set invpaste paste?<CR>", keymap_opts)
keymap("n", "<Leader>t", ":! git ls-files | ctags<CR>", keymap_opts)

keymap("n", "K", "<Nop>", keymap_opts)

keymap("v", "<Leader>sd", ":sort! n<CR>", keymap_opts)
keymap("v", "<Leader>ss", ":sort iu<CR>", keymap_opts)
