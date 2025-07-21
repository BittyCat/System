set background=dark
hi clear
if exists("syntax_on")
  syntax reset
endif
let g:colors_name = "thistle"
hi LineNr ctermfg=darkgrey
hi Comment ctermfg=7          " Silver (SYSTEM) #C0C0C0
hi Constant ctermfg=14        " Aqua (SYSTEM)   #00FFFF
hi Normal ctermfg=15          " White (SYSTEM)  #FFFFFF
hi Type ctermfg=48            " SpringGreen1    #00FF87
hi Statement ctermfg=117      " SkyBlue1        #87D7FF
hi Identifier ctermfg=225     " Thistle1        #FFD7FF
hi! link PreProc Comment
hi! link Special Normal
hi! link Ignore Normal
hi! link Error Normal
hi! link Todo Normal
hi! clear FoldColumn
hi! NonText ctermfg=black
