" Font family and font size.
set antialias                     " MacVim: smooth fonts.
set guioptions-=T                 " Hide toolbar.

if has("gui_macvim")

  " Fullscreen takes up entire screen
  set fuoptions=maxhorz,maxvert

  " <D-T> and <D-B> are remapped
  macmenu &File.New\ Tab key=<nop>
  macmenu &Tools.Make key=<nop>

  " Command-Shift-F for Ack
  macmenu Window.Toggle\ Full\ Screen\ Mode key=<nop>
  map <D-F> :Ack!<space>
  imap <D-F> <ESC>:Ack!<space>

  " Command-/ to toggle comments
  map <D-/> <plug>NERDCommenterToggle<CR>

  " Command-Shift-T toggles NERDTree
  macmenu &File.Open\ Tab\.\.\. key=<nop>

endif
