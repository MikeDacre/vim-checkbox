" ****************************************************************************
" File:             checkbox.vim
" Author:           Jonas Kramer, modified by Mike Dacre
" Version:          0.2
" Last Modified:    2018-04-08
" Copyright:        Copyright (C) 2010 by Jonas Kramer. Published under the
"                   terms of the Artistic License 2.0.
" ****************************************************************************
" Installation: Copy this script into your plugin folder.
" Usage: Press "<leader>tt" to toggle the (first) checkbox on the current
" line, if any. That means, "[ ]" will be replaced with "[x]" and "[x]" with
" "[ ]".
" ****************************************************************************

""""""""""""
"  Config  "
""""""""""""

let s:unchecked_regex = "\\[\[ _\]\\] "

let s:line_start = '^\W*'

if exists("g:checkbox_checked_char")
  let s:checked = '[' . g:checkbox_checked_char . '] '
  let s:any_cb_regex = "\\[[ _" . g:checkbox_checked_char . "]\\] "
  let s:checked_regex = "\\[[" . g:checkbox_checked_char . "]\\] "
else
  let s:checked = '[x] '
  let s:any_cb_regex = "\\[\[ _xX\]\\] "
  let s:checked_regex = "\\[\[xX\]\\] "
endif

if exists("g:checkbox_unchecked_underline")
  let s:unchecked = '[_] '
else
  let s:unchecked = '[ ] '
endif

" Get mappings
if exists("g:checkbox_toggle_command")
  let s:checkbox_toggle = g:checkbox_toggle_command
else
  let s:checkbox_toggle = '<leader>tt'
endif
if exists("g:checkbox_insert_remove_command")
  let s:checkbox_insert = g:checkbox_insert_remove_command
else
  let s:checkbox_insert = '<leader>cb'
endif

"""""""""""""""
"  Functions  "
"""""""""""""""

" Toggle checkbox on/off
fu! checkbox#ToggleCB()
	let line = getline('.')

	if match(line, s:unchecked_regex) != -1
		let line = substitute(line, s:unchecked_regex, s:checked, "")
	elseif match(line, s:checked_regex) != -1
		let line = substitute(line, s:checked_regex, s:unchecked, "")
	endif

	call setline('.', line)
endf
command! ToggleCB call checkbox#ToggleCB()

" Add/Remove checkbox from current line, maintaining cursor positon
fun! checkbox#InsertRemoveCB()
  let pos  = getpos('.')
	let line = getline('.')

  if match(line, s:any_cb_regex) != -1
    let line = substitute(line, s:any_cb_regex, "", "")
    let pos[2] -= 4
  else
    let line = substitute(line, "^", s:unchecked, "")
    let pos[2] += 4
  endif

	call setline('.', line)
  call setpos('.', pos)
endf
command! InsertRemoveCB call checkbox#InsertRemoveCB()

""""""""""""""
"  Mappings  "
""""""""""""""

execute "nmap <silent> " . s:checkbox_toggle . " :ToggleCB<CR>"
execute "imap <silent> " . s:checkbox_toggle . " <ESC>:ToggleCB<CR>a"
execute "nmap <silent> " . s:checkbox_insert . " :InsertRemoveCB<CR>"
execute "imap <silent> " . s:checkbox_insert . " <ESC>:InsertRemoveCB<CR>i"
