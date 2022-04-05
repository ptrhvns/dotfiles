vim.g.solarized_termcolors = 256
vim.g.solarized_termtrans = 1

vim.cmd [[
  try
      if &t_Co > 15
          colorscheme solarized
      endif
  catch /^Vim\%((\a\+)\)\=:E185/
      colorscheme default
  endtry

  highlight! NonText ctermfg=235

  " Only highlight absolute line number inside relative numbers.
  highlight LineNr ctermfg=166 ctermbg=Black
  highlight LineNrAbove ctermfg=239 ctermbg=Black
  highlight LineNrBelow ctermfg=239 ctermbg=Black

  highlight WinSeparator guibg=None
]]

vim.cmd [[
    filetype indent on
    filetype plugin on
]]
