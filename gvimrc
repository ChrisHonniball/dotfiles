
" remove print mapping
if has("gui_macvim")
  macmenu &File.Print key=<nop>
  map <D-p> :CtrlP<cr>
endif

