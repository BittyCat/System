function Wrap()
  " Save current cursor position.
  let view = winsaveview()
  " Remove trailing whitespaces.
  %s/\s\+$//e
  " Remove trailing newlines except one.
  %s/\n\{2,}\%$/\r/e
  " Ensure file ends with a newline.
  %s/\([^\n]\)\%$/\1\r/e
  " Check if modified.
  if &mod == 1
    " Update file.
    update
  else
    " Print modification datetime.
    echo strftime('%a %d %b %Y %H:%M:%S %Z', getftime(expand('%')))
  endif
  " Restore cursor position.
  call winrestview(view)
endfunction
nnoremap <F4> :quit <CR>
nnoremap <F5> :call Wrap() <CR>
