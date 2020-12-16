" Vim filetype plugin file
" Language:	Notes
" Maintainer:	Peter Havens <peter.havens@gmail.com>

if exists("b:did_ftplugin")
  finish
endif

let b:did_ftplugin = 1

let b:undo_ftplugin = "setlocal sw< sts< et< tw< fo< flp<"

setlocal autoindent
setlocal sw=2
setlocal sts=2
setlocal et
setlocal tw=80
setlocal fo=tn
setlocal flp=^\\s*[\\d\\*]\\+[\\]:.)}\\t\ ]\\s*

" Set the comment string format.
let &commentstring="// %s"

" Append lower case date as a title, blank line above and below.
nmap <Leader>d 0o# <C-r>=strftime("%a %b %d, %Y")<CR><Esc>o<Esc>
