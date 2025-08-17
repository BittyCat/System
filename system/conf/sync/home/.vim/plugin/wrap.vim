function Wrap()
  let view = winsaveview() " save cursor position
  %s/\s\+$//e " remove trailing whitespace
  %s/\n\{2,}\%$/\r/e " remove trailing newlines except one
  %s/\([^\n]\)\%$/\1\r/e " ensure one trailing newline
  if &mod == 1 " modified
    update " save the file
  else " show last modified time
    echo strftime('%a %d %b %Y %H:%M:%S %Z', getftime(expand('%')))
  endif
  call winrestview(view) " restore cursor position
endfunction
nnoremap <F4> :quit <CR>
nnoremap <F5> :call Wrap() <CR>
