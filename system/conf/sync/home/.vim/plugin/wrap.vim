function Wrap()
  let view = winsaveview()
  %s/\s\+$//e
  %s/\n\{2,}\%$/\r/e
  %s/\([^\n]\)\%$/\1\r/e
  if &mod == 1
    update
  else
    echo strftime('%a %d %b %Y %H:%M:%S %Z', getftime(expand('%')))
  endif
  call winrestview(view)
endfunction
nnoremap <F4> :quit <CR>
nnoremap <F5> :call Wrap() <CR>
