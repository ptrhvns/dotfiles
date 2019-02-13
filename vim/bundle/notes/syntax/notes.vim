" Vim syntax file
" Language: Document containing bulleted tasks, text, code literals, etc.

" Quit when a (custom) syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

syntax clear
syntax case match
syntax sync minlines=10

syntax keyword pTodo TODO FIXME XXX NOTE Note WARNING Warning WARN
highlight link pTodo Todo

syntax match pBullet /^\s*[-*!]\s/
highlight link pBullet Label

" syntax match pTitle /^\s*#.*/
syntax match pTitle /^#.*/
highlight link pTitle Title

syntax match pComment #//\s#
highlight link pComment SpecialComment

syntax match pTag /\(\s\|^\|\W\)\@<=@\(-\|\w\|_\)\+/
highlight link pTag SpecialComment

" syntax region pInlineLiteral start=/`/ end=/[^\\]`/
" highlight link pInlineLiteral Identifier

" syntax region pIndentedLiteral start=/^\n\s\+[^-*+ \t]/ end=/\(^\s*$\)\@=/
" highlight link pIndentedLiteral Identifier

" syntax region pEmphasize start=/__/ end=/__/
" highlight link pEmphasize SpecialComment

" syntax region pDoubleQuote start=+"+ skip=+\\"+ end=+"+
" highlight link pDoubleQuote Structure

" syntax region pCallout start=+\[+ skip=+\\\]+ end=+\]+
" highlight link pCallout Structure

let b:current_syntax = "notes"
