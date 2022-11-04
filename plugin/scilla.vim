if exists('g:loaded_scilla') | finish | endif

let s:save_cpo = &cpo " save user coptions
set cpo&vim           " reset them to defaults

command! ScillaFmt lua require'scilla.scilla'.scilla_fmt()

let &cpo = s:save_cpo " and restore after
unlet s:save_cpo

let g:loaded_scilla = 1
