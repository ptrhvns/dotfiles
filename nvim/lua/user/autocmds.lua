local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local custom_group = augroup("CustomGroup", { clear = true })

autocmd("BufNewFile,BufRead", {
  command = "setlocal filetype=json",
  group = custom_group,
  pattern = ".babelrc"
})

autocmd("BufNewFile,BufRead", {
  command = "setlocal filetype=dosini",
  group = custom_group,
  pattern = "supervisord.conf"
})

autocmd("BufReadPost", {
  command = "setlocal bufhidden=delete",
  group = custom_group,
  pattern = "fugitive://*"
})

autocmd("FileType", {
  command = "setlocal softtabstop=2 tabstop=2",
  group = custom_group,
  pattern = "css"
})

autocmd("FileType", {
  command = "EmmetInstall",
  group = custom_group,
  pattern = "css,html,htmldjango,javascript,sass,scss"
})

autocmd("FileType", {
  command = "setlocal nolist",
  group = custom_group,
  pattern = "gitcommit"
})

autocmd("FileType", {
    command = "setlocal noexpandtab nolist softtabstop=4 tabstop=4",
    group = custom_group,
    pattern = "go,gomod"
})

autocmd("FileType", {
    command = "setlocal softtabstop=2 tabstop=2",
    group = custom_group,
    pattern = "html"
  })

autocmd("FileType", {
  command = "setlocal softtabstop=2 tabstop=2",
  group = custom_group,
  pattern = "htmldjango"
})

autocmd("FileType", {
  command = "setlocal softtabstop=2 tabstop=2",
  group = custom_group,
  pattern = "javascript"
})

autocmd("FileType", {
  command = "setlocal softtabstop=2 tabstop=2",
  group = custom_group,
  pattern = "markdown"
})

autocmd("FileType", {
  command = "setlocal textwidth=80",
  group = custom_group,
  pattern = "notes"
})

autocmd("FileType", {
  command = "setlocal softtabstop=4 tabstop=4",
  group = custom_group,
  pattern = "python"
})

autocmd("FileType", {
  command = "setlocal iskeyword+=- iskeyword+=@-@ softtabstop=2 tabstop=2",
  group = custom_group,
  pattern = "scss"
})

autocmd("FileType", {
  command = "setlocal softtabstop=4",
  group = custom_group,
  pattern = "sh"
})

autocmd("FileType", {
  command = "setlocal textwidth=80",
  group = custom_group,
  pattern = "text"
})

autocmd("FileType", {
  command = "setlocal expandtab",
  group = custom_group,
  pattern = "yaml"
})

autocmd("InsertLeave", {
  command = "setlocal nopaste",
  group = custom_group,
  pattern = "*"
})
