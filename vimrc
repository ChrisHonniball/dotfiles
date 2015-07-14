runtime bundle/pathogen/autoload/pathogen.vim

" Execute Pathogen-installed plugins
execute pathogen#infect()
Helptags

" set <leader> to , (comma)
let mapleader=","

set viminfo='0,<0,s10,h

set timeoutlen=250 ttimeoutlen=0

filetype plugin on

" enable syntax highlighting
syntax on

" theme settings
set background=dark
colorscheme afterglow-custom
set t_Co=256
set guifont=Liberation\ Mono\ for\ Powerline:h16

set clipboard=unnamed

set mouse=a

" KEY MAPPINGS

" yank/cut/delete alterations
nnoremap <leader>d "_dd
vnoremap <leader>d "_d

" select last paste
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'

" Gundo
nnoremap <c-u> :GundoToggle<CR>

" EasyMotion
map <Leader> <Plug>(easymotion-prefix)

" prevent lines from removing indent
inoremap <Return> <Return>x<BS>
inoremap <CR> <CR>x<BS>
nnoremap o ox<BS>
nnoremap O Ox<BS>
nnoremap cc ccx<BS>
vnoremap c cx<BS>

" Add alternate ways to get out of insert mode
inoremap jj <Esc>
inoremap kk <Esc>
inoremap :w <Esc>:w
inoremap :W <Esc>:w
inoremap :q <Esc>:q

" Closing HTML tags
inoremap <leader>/ </<C-x><C-o>

" Add mistyped commands
ca W w
ca Wq wq
ca WQ wq
ca Q q
ca ag Ag
ca AG Ag

if has('mac')
  ca gz cd /www/html/gozooga
  ca purls cd /www/html/gozooga-purls
  ca wiki cd /www/html/gozooga-wiki
  ca addons cd ~/Projects/GitHub/ChrisHonniball/ember-addons
elseif has('unix')
  ca gz cd /var/www/html/gozooga
  ca purls cd /var/www/html/gozooga-purls
endif

" movement without exiting insert mode
inoremap <C-h> <Esc>ha
inoremap <C-j> <Esc>gja
inoremap <C-k> <Esc>gka
inoremap <C-l> <Esc>la

" insert lines without entering INSERT mode
nnoremap <C-k> Ox<BS><Esc>
nnoremap <C-j> ox<BS><Esc>

" folding maps
nnoremap <Space> za
vnoremap <Space> za
nnoremap <leader><Space> zA
vnoremap <leader><Space> zA

inoremap <leader>y <C-y>,

" Easier retab
nnoremap <leader><tab> :retab<cr>

" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>

" Reveal in finder
nmap <leader><leader>f :Reveal<cr>

" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬

" set splits to open on left or bottom
set splitbelow
set splitright

" set backspace to work like most apps
set backspace=2

" enhance cli completion
set wildmenu

" turn on ruler
set ruler

" highlight current line
set cursorline
set cursorcolumn

" turn on auto indentation
set autoindent

" set backups directory
set swapfile
set dir=~/.vim/swp

" add line numbers
set number
set relativenumber

" always display status (useful for vim-airline)
set laststatus=2

" hide abandoned buffers
set hid

" show matching brackets
set showmatch
set mat=2

" highlight search results
set hlsearch
nnoremap <leader>/ :noh<cr>

" incsearch
let g:incsearch#auto_nohlsearch = 0
let g:incsearch#separate_highlight = 1
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#) <Plug>(incsearch-stay)

" use tabs, indent two (not four)
set expandtab
set tabstop=2
set shiftwidth=2
set smarttab

" set tabs for specific filetypes
autocmd Filetype snippet setlocal ts=4 sts=4 sw=4
autocmd Filetype snippets setlocal ts=4 sts=4 sw=4
autocmd Filetype markdown setlocal ts=4 sts=4 sw=4

" add syntaxes
au BufReadPost,BufWritePost *.md set filetype=markdown syntax=markdown
au BufReadPost,BufWritePost *.hbs set filetype=html.mustache syntax=html.mustache
au BufNewFile,BufRead *.json set ft=javascript

" turn on wrapping
set wrap

" make wrapping not break words
set linebreak

" fold by indentation
set foldmethod=indent

" set deepest fold to 10 levels
set foldnestmax=10

" don't fold code by default
set nofoldenable

" set fold level to 1
set foldlevel=1

" treat all numbers as decimal
set nrformats=

" hide the mode in favor of airline
set noshowmode

" indent-guides settings
let g:indent_guides_auto_colors=0
let g:indent_guides_start_level=1
let g:indent_guides_guide_size=2
let g:indent_guides_enable_on_vim_startup=1

" not sure what this line does...
filetype plugin on

" autoclose
au filetype markdown
  \ let b:AutoClosePairs = AutoClose#DefaultPairsModified("", "`")

" git gutter
let g:gitgutter_max_signs = 5000

" ctrlp settings
let g:ctrlp_tabpage_position = 'al'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_map = '<C-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_match_window = 'bottom,order:ttb,min:1,max:20'
let g:ctrlp_switch_buffer = 'et'
let g:ctrlp_tabpage_position = 'al'
let g:ctrlp_max_files = 0
let g:ctrlp_max_depth = 100
let g:ctrlp_show_hidden = 1
let g:ctrlp_follow_symlinks = 1
let g:ctrlp_prompt_mappings = {
  \ 'AcceptSelection("e")': ['<c-t>'],
  \ 'AcceptSelection("t")': ['<cr>', '<2-LeftMouse>'],
  \ }
let g:ctrlp_extensions = ['line']
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.git|\.hg|\.svn|bower_components|node_modules|composer_packages|tmp|dist|bundle)$',
  \ 'file': '\v(.exe|.so|.dll|.DS_Store|.gitkeep)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }
nnoremap <silent> <C-b> :CtrlPBuffer<cr>
nnoremap <silent> <C-l> :CtrlPLine<cr>

" Multiple Cursors
let g:multi_cursor_exit_from_visual_mode=0
let g:multi_cursor_exit_from_insert_mode=0
let g:multi_cursor_prev_key='<C-b>'
let g:multi_cursor_next_key='<C-n>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'

ca MF MultipleCursorsFind
" Called once right before you start selecting multiple cursors
function! Multiple_cursors_before()
  call youcompleteme#DisableCursorMovedAutocommands()
  set cursorcolumn!
endfunction

" Called once only when the multiple selection is canceled (default <Esc>)
function! Multiple_cursors_after()
  call youcompleteme#EnableCursorMovedAutocommands()
  set cursorcolumn
endfunction

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsEditSplit="horizontal"
let g:UltiSnipsListSnippets="<c-tab>"
let g:UltiSnipsNoPythonWarning = 1

" helper commands for snippets
imap {{# hbs-element<c-r>=UltiSnips#ExpandSnippet()<cr>

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" YouCompleteMe
let g:ycm_key_list_select_completion = ['<c-n>']
let g:ycm_key_list_previous_completion = ['<c-b>']

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = ''
let g:airline_right_sep = '«'
let g:airline_right_sep = ''
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = 'ln:'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'
let g:airline#extensions#whitespace#enabled = 0

" custom folding function
" http://dhruvasagar.com/2013/03/28/vim-better-foldtext
function! NeatFoldText()
  let line = ' ' . substitute(getline(v:foldstart), '^\s*"\?\s*\|\s*"\?\s*{{' . '{\d*\s*', '', 'g') . ' '
  let lines_count = v:foldend - v:foldstart + 1
  let lines_count_text = '| ' . printf("%10s", lines_count . ' lines') . ' |'
  let foldchar = matchstr(&fillchars, 'fold:\zs.')
  let foldtextstart = strpart('+' . repeat(foldchar, v:foldlevel*2) . line, 0, (winwidth(0)*2)/3)
  let foldtextend = lines_count_text . repeat(foldchar, 8)
  let foldtextlength = strlen(substitute(foldtextstart . foldtextend, '.', 'x', 'g')) + &foldcolumn
  return foldtextstart . repeat(foldchar, winwidth(0)-foldtextlength) . foldtextend
endfunction
set foldtext=NeatFoldText()

function! s:RevealInFinder()
  if filereadable(expand("%"))
    let l:command = "open -R %"
  elseif getftype(expand("%:p:h")) == "dir"
    let l:command = "open %:p:h"
  else
    let l:command = "open ."
  endif
  execute ":silent! !" . l:command
  redraw!
endfunction
command! Reveal call <SID>RevealInFinder()

com! FormatJSON %!python -m json.tool

function! ClearRegisters()
  let regs='abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/-="*+'
  let i=0
  while (i<strlen(regs))
    exec 'let @'.regs[i].'=""'
    let i=i+1
  endwhile
endfunction
 
command! ClearRegisters call ClearRegisters()

" Color Scheme Stuff

" Show syntax highlighting groups for word under cursor with <F6> key.
nmap <F6> :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
