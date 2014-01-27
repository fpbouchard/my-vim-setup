" Font family and font size.
set antialias                     " MacVim: smooth fonts.
set guioptions-=T                 " Hide toolbar.

if has("gui_macvim")

  " Fullscreen takes up entire screen
  set fuoptions=maxhorz,maxvert

  " Toggle fullscreen with cmd-enter
  map <D-CR> :set invfu<CR>

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

  " Map command-[ and command-] to indenting or outdenting
  " while keeping the original selection in visual mode
  vmap <D-]> >gv
  vmap <D-[> <gv

  nmap <D-]> >>
  nmap <D-[> <<

  omap <D-]> >>
  omap <D-[> <<

  imap <D-]> <Esc>>>i
  imap <D-[> <Esc><<i

endif

if has("gui_running")
  if has("autocmd")
    " Automatically resize splits when resizing MacVim window
    autocmd VimResized * wincmd =
  endif
endif
