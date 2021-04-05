" disable menus, toolbar & scrollbars in gui
set guioptions-=m
set guioptions-=T
set guioptions-=r
set guioptions-=R
set guioptions-=l
set guioptions-=L

" fonts and text size
if has("unix")
  if system('uname')=~'Darwin'
    set guifont=DejaVuSansMono\ NF:h13
  else
    set guifont=DejaVuSansMono\ NF\ 12
  endif
endif    

" tab labels
set guitablabel=%t%m
set showtabline=1

" to display at least 50 lines when starting
set lines=50 columns=100
