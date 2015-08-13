set nocompatible
filetype off

" ======
" VUNDLE
" ======
" 
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/vundle/
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
" call vundle#begin('~/some/path/here')
"
" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" other plugins
Plugin 'scrooloose/nerdcommenter'
Plugin 'plasticboy/vim-markdown'
Plugin 'airblade/vim-gitgutter'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'tpope/vim-surround'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'godlygeek/tabular'
Plugin 'ChrisHonniball/xterm-color-table.vim'
Plugin 'scrooloose/syntastic'
Plugin 'Townk/vim-autoclose'
Plugin 'nelstrom/vim-markdown-folding'
Plugin 'mustache/vim-mustache-handlebars'
Plugin 'SirVer/ultisnips'
Plugin 'bling/vim-airline'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'mattn/emmet-vim'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'edsono/vim-matchit'
Plugin 'tpope/vim-repeat'
Plugin 'sjl/gundo.vim'
Plugin 'haya14busa/incsearch.vim'
Plugin 'rking/ag.vim'
Plugin 'StanAngeloff/php.vim'
Plugin 'mkitt/tabline.vim'
Plugin 'vim-scripts/BufOnly.vim'
Plugin 'ChrisHonniball/vim-task'

" All of your Plugins must be added before the following line
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
call vundle#end()

" set <leader> to , (comma)
let mapleader=","
set viminfo='0,<0,s10,h
set timeoutlen=300 ttimeoutlen=0
set clipboard=unnamed
set mouse=a
filetype plugin on

" Use the same symbols as TextMate for tabstops and EOLs
set list
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

" use tabs, indent two (not four)
set expandtab
set tabstop=2
set shiftwidth=2
set smarttab

" turn on wrapping
set wrap

" make wrapping not break words
set linebreak

" set deepest fold to 10 levels
set foldnestmax=10

" fold by indentation
set foldmethod=indent

" don't fold code by default
set nofoldenable

" set fold level to 1
set foldlevel=1

" treat all numbers as decimal
set nrformats=

" hide the mode in favor of airline
set noshowmode

" enable syntax highlighting
syntax on

" theme settings
set background=dark
colorscheme afterglow-custom
set t_Co=256
set guifont=Liberation\ Mono\ for\ Powerline:h16

" set tabs for specific filetypes
autocmd Filetype snippet setlocal ts=4 sts=4 sw=4
autocmd Filetype snippets setlocal ts=4 sts=4 sw=4
autocmd Filetype markdown setlocal ts=4 sts=4 sw=4

" add syntaxes
au BufReadPost,BufWritePost *.md set filetype=markdown syntax=markdown
au BufReadPost,BufWritePost *.hbs set filetype=html.mustache syntax=html.mustache
au BufNewFile,BufRead *.json set ft=javascript


" ====================
" COMMAND ALTERNATIVES
" ====================
ca config e $MYVIMRC
ca tconfig tabe $MYVIMRC
ca rconfig so $MYVIMRC

" mistyped commands
ca W w
ca Wq wq
ca WQ wq
ca Q q
ca ag Ag
ca AG Ag


" ============
" KEY MAPPINGS
" ============

" markdown TODOs
inoremap ,- - [ ] 

" yank/cut/delete alterations
nnoremap <leader>d "_dd
vnoremap <leader>d "_d

" select last paste
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'

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

" Line Movement
nnoremap j gj
nnoremap k gk

" Split movement
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

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
nmap gf :Reveal<cr>

nnoremap <leader>/ :noh<cr>

" ===============
" PLUGIN SETTINGS
" ===============

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

" indent-guides settings
let g:indent_guides_auto_colors=0
let g:indent_guides_start_level=1
let g:indent_guides_guide_size=2
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_exclude_filetypes = ['markdown', 'html.mustache', 'help']

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
let g:ctrlp_max_files = 0
let g:ctrlp_max_depth = 100
let g:ctrlp_show_hidden = 1
let g:ctrlp_follow_symlinks = 1
let g:ctrlp_open_new_file = 'r'
" let g:ctrlp_open_multiple_files = '1i'
let g:ctrlp_prompt_mappings = {
  \ 'AcceptSelection("e")': ['<c-t>'],
  \ 'AcceptSelection("t")': ['<cr>', '<2-LeftMouse>'],
  \ }
let g:ctrlp_extensions = ['line']
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.git|\.hg|\.svn|bower_components|node_modules|composer_packages|tmp|dist|bundle|vendor|Mandrill)$',
  \ 'file': '\v(.exe|.so|.dll|.DS_Store|.gitkeep|mandrill.php)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }
nnoremap <silent> <C-b> :CtrlPBuffer<cr>

" Ag
let g:ag_working_path_mode="r"

" Multiple Cursors
let g:multi_cursor_exit_from_visual_mode=0
let g:multi_cursor_exit_from_insert_mode=0
let g:multi_cursor_prev_key='<C-b>'
let g:multi_cursor_next_key='<C-n>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'

ca mf MultipleCursorsFind
" Called once right before you start selecting multiple cursors
function! Multiple_cursors_before()
  set cursorcolumn!
endfunction

" Called once only when the multiple selection is canceled (default <Esc>)
function! Multiple_cursors_after()
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

" AirLine
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

" Vim Task
noremap <leader><CR> :call Toggle_task_status()<CR>

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

" Reveal in finder
function! s:RevealInFinder()
  if filereadable(expand("%"))
    let l:command = "open -R %"
  elseif getftype(expand("%:p:h")) == "dir"
    let l:command = "open %:p:h"
  else
    let l:command = "open ."
  endif
  execute "silent! !" . l:command
  redraw!
endfunction
command! Reveal call <SID>RevealInFinder()

" Format JSON
com! FormatJSON %!python -m json.tool

" Register clearing
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

" Enable quickfix file migration with command
command! -nargs=0 -bar Qargs execute 'args' QuickfixFilenames()
function! QuickfixFilenames()
  " Building a hash ensures we get each buffer only once
  let buffer_numbers = {}
  for quickfix_item in getqflist()
    let buffer_numbers[quickfix_item['bufnr']] = bufname(quickfix_item['bufnr'])
  endfor
  return join(map(values(buffer_numbers), 'fnameescape(v:val)'))
endfunction

" Custom quickfix commands
function! QuickfixTodos()
  " Build a list of TODOs into the quickfix list
  execute "vimgrep /TODO/%"
  execute "copen"
endfunction
command! Qtodos call QuickfixTodos()

function! QuickfixFunctions()
  " Build a list of TODOs into the quickfix list
  execute "vimgrep /function/%"
  execute "copen"
endfunction
command! Qfunc call QuickfixFunctions()
