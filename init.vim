if !exists('g:vscode')
    set runtimepath^=~/.vim runtimepath+=~/.vim/after
    let &packpath = &runtimepath
    source ~/.vimrc
end

lua <<EOF

require'nvim-treesitter.configs'.setup {
    highlight = {
      enable = true,
    },
}

EOF
