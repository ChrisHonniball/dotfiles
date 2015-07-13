" Vim color file

set background=dark
highlight clear

if exists("syntax_on")
  syntax reset
endif


" Cursor Settings
set guicursor=a:block-Cursor-blinkon0
"set guicursor+=n:block-nCursor-blinkon0
"set guicursor+=v:block-vCursor-blinkon0
"set guicursor+=i:block-iCursor-blinkon0
"set guicursor+=c:block-cCursor-blinkon0
"set guicursor+=r:block-rCursor-blinkon0


let g:colors_name = "afterglow-custom"

" Cursor Colors based on mode - synced with airline colors.
hi Cursor                         ctermfg=0       ctermbg=7      cterm=NONE           guifg=#000000   guibg=#c0c0c0   gui=NONE
"hi link nCursor Cursor
"hi link cCursor Cursor
"hi iCursor                        ctermbg=0       ctermbg=190    cterm=NONE           guifg=#000000   guibg=#00dfff   gui=NONE
"hi rCursor                        ctermbg=0       ctermbg=124    cterm=NONE           guifg=#000000   guibg=#af0000   gui=NONE
"hi vCursor                        ctermfg=0       ctermbg=214    cterm=NONE           guifg=#000000   guibg=#ffaf00   gui=NONE

" Colors
hi Normal                         ctermfg=251     ctermbg=235    cterm=NONE           guifg=#c6c6c6   guibg=#262626   gui=NONE
hi NonText                        ctermfg=237     ctermbg=235    cterm=NONE           guifg=#3a3a3a   guibg=#262626   gui=NONE
hi SpecialKey                     ctermfg=11      ctermbg=237    cterm=NONE           guifg=#ffff00   guibg=#3a3a3a   gui=NONE

hi TabLine                        ctermfg=245     ctermbg=234    cterm=NONE           guifg=#8a8a8a   guibg=#1c1c1c   gui=NONE
hi TabLineFill                    ctermfg=232     ctermbg=232    cterm=NONE           guifg=#080808   guibg=#080808   gui=NONE
hi TabLineSel                     ctermfg=253     ctermbg=235    cterm=bold           guifg=#dadada   guibg=#262626   gui=bold

hi IndentGuidesOdd                ctermfg=NONE    ctermbg=234    cterm=NONE           guifg=NONE      guibg=#1c1c1c   gui=NONE
hi IndentGuidesEven               ctermfg=NONE    ctermbg=235    cterm=NONE           guifg=NONE      guibg=#262626   gui=NONE

hi SignColumn                     ctermfg=244     ctermbg=NONE   cterm=NONE           guifg=#eeeeee   guibg=NONE      gui=NONE
hi LineNr                         ctermfg=244     ctermbg=NONE   cterm=NONE           guifg=#6f6f6f   guibg=NONE      gui=NONE

hi multiple_cursors_cursor        ctermfg=0       ctermbg=13     cterm=NONE           guifg=#000000   guibg=#ff00ff   gui=NONE
hi multiple_cursors_visual        ctermfg=0       ctermbg=218    cterm=NONE           guifg=#000000   guibg=#ffafdf   gui=NONE

hi CursorLineNr                   ctermfg=190     ctermbg=NONE   cterm=NONE           guifg=#dfff00   guibg=NONE      gui=NONE

" General Styles
hi CursorLine                     ctermfg=NONE    ctermbg=236    cterm=NONE           guifg=NONE      guibg=#303030   gui=NONE
hi CursorColumn                   ctermfg=NONE    ctermbg=236    cterm=NONE           guifg=NONE      guibg=#303030   gui=NONE

" Searches
hi Search                         ctermfg=34      ctermbg=0      cterm=NONE           guifg=#00af00   guibg=#000000   gui=NONE
hi link IncSearch Search
hi link IncSearchCursor Cursor
hi IncSearchOnCursor              ctermfg=34      ctermbg=0      cterm=NONE           guifg=#00af00   guibg=#000000   gui=NONE
hi IncSearchMatch                 ctermfg=34      ctermbg=0      cterm=NONE           guifg=#00af00   guibg=#000000   gui=NONE
hi IncSearchMatchReverse          ctermfg=34      ctermbg=0      cterm=NONE           guifg=#00af00   guibg=#000000   gui=NONE

hi Visual                         ctermfg=15      ctermbg=27     cterm=NONE           guifg=#ffffff   guibg=#005faf   gui=NONE

hi VertSplit                      ctermfg=232     ctermbg=232    cterm=NONE           guifg=#080808   guibg=#080808   gui=NONE

hi MatchParen                     ctermfg=173     ctermbg=NONE   cterm=underline      guifg=#cc7833   guibg=NONE      gui=underline

hi StatusLine                     ctermfg=245     ctermbg=232    cterm=BOLD           guifg=#8a8a8a   guibg=#080808   gui=BOLD
hi StatusLineNC                   ctermfg=240     ctermbg=232    cterm=NONE           guifg=#585858   guibg=#080808   gui=NONE

hi Comment                        ctermfg=241     ctermbg=NONE   cterm=NONE           guifg=#606060   guibg=NONE      gui=NONE
hi Conditional                    ctermfg=208     ctermbg=NONE   cterm=NONE           guifg=#ff8700   guibg=NONE      gui=NONE
hi Function                       ctermfg=166     ctermbg=NONE   cterm=NONE           guifg=#d75f00   guibg=NONE      gui=NONE
hi Type                           ctermfg=68      ctermbg=NONE   cterm=NONE           guifg=#5f87d7   guibg=NONE      gui=NONE
hi String                         ctermfg=149     ctermbg=NONE   cterm=NONE           guifg=#b4c973   guibg=NONE      gui=NONE
hi Statement                      ctermfg=202     ctermbg=NONE   cterm=NONE           guifg=#ff5f00   guibg=NONE      gui=NONE
hi StorageClass                   ctermfg=132     ctermbg=NONE   cterm=NONE           guifg=#a1617a   guibg=NONE      gui=NONE
hi Error                          ctermfg=15      ctermbg=124    cterm=NONE           guifg=#ffffff   guibg=#3f3f3f   gui=NONE
hi Label                          ctermfg=202     ctermbg=NONE   cterm=NONE           guifg=#ff5f00   guibg=NONE      gui=NONE
hi Operator                       ctermfg=NONE    ctermbg=NONE   cterm=NONE           guifg=NONE      guibg=NONE      gui=NONE


" PHP
hi phpStructure                   ctermfg=132     ctermbg=NONE   cterm=NONE           guifg=#af5f87   guibg=NONE      gui=NONE
hi phpIdentifier                  ctermfg=104     ctermbg=NONE   cterm=NONE           guifg=#8787d7   guibg=NONE      gui=NONE
hi phpVarSelector                 ctermfg=104     ctermbg=NONE   cterm=NONE           guifg=#8787d7   guibg=NONE      gui=NONE
hi link phpIntVar phpVarSelector
hi phpMethodsVar                  ctermfg=172     ctermbg=NONE   cterm=NONE           guifg=#d78700   guibg=NONE      gui=NONE
hi phpException                   ctermfg=202     ctermbg=NONE   cterm=NONE           guifg=#ff5f00   guibg=NONE      gui=NONE
hi link phpDefine phpException
hi phpOperator                    ctermfg=NONE    ctermbg=NONE   cterm=NONE           guifg=NONE      guibg=NONE      gui=NONE
hi link phpRelation phpOperator
hi phpSpecialFunction             ctermfg=124     ctermbg=NONE   cterm=NONE           guifg=#af0000   guibg=NONE      gui=NONE
hi phpType                        ctermfg=160     ctermbg=NONE   cterm=NONE           guifg=#df0000   guibg=NONE      gui=NONE

" Javasctipt
hi javaScriptFunction             ctermfg=132     ctermbg=NONE   cterm=NONE           guifg=#a1617a   guibg=NONE      gui=NONE
hi javaScriptRailsFunction        ctermfg=167     ctermbg=NONE   cterm=NONE           guifg=#c45837   guibg=NONE      gui=NONE
hi javaScriptBraces               ctermfg=NONE    ctermbg=NONE   cterm=NONE           guifg=NONE      guibg=NONE      gui=NONE
hi javaScriptReserved             ctermfg=166     ctermbg=NONE   cterm=NONE           guifg=#df5f00   guibg=NONE      gui=NONE
hi link javaScriptNull Type
hi javaScriptReserved             ctermfg=160     ctermbg=NONE   cterm=NONE           guifg=#df0000   guibg=NONE      gui=NONE
hi javaScriptOperator             ctermfg=160     ctermbg=NONE   cterm=NONE           guifg=#df0000   guibg=NONE      gui=NONE


" HTML
hi htmlTag                        ctermfg=179     ctermbg=NONE   cterm=NONE           guifg=#dfaf5f   guibg=NONE      gui=NONE
hi link htmlEndTag htmlTag
hi link htmlTagName htmlTag
hi htmlArg                        ctermfg=172     ctermbg=NONE   cterm=NONE           guifg=#d78700   guibg=NONE      gui=NONE
hi htmlSpecialChar                ctermfg=73      ctermbg=NONE   cterm=NONE           guifg=#6d9cbe   guibg=NONE      gui=NONE
hi htmlBold                       ctermfg=NONE    ctermbg=NONE   cterm=bold           guifg=NONE      guibg=NONE      gui=bold
hi htmlItalic                     ctermfg=NONE    ctermbg=NONE   cterm=italic         guifg=NONE      guibg=NONE      gui=italic
hi htmlBoldItalic                 ctermfg=NONE    ctermbg=NONE   cterm=bold,italic    guifg=NONE      guibg=NONE      gui=bold,italic
hi htmlLink                       ctermfg=NONE    ctermbg=NONE   cterm=NONE           guifg=NONE      guibg=NONE      gui=NONE


" Handlebars
hi hbsConditionals                ctermfg=202     ctermbg=NONE   cterm=NONE           guifg=#ff5f00   guibg=NONE      gui=NONE
hi link hbsHelpers hbsConditionals

hi mustacheHandlebars             ctermfg=213     ctermbg=NONE   cterm=NONE           guifg=#ff87ff   guibg=NONE      gui=NONE
hi mustacheInside                 ctermfg=225     ctermbg=NONE   cterm=NONE           guifg=#ffdfff   guibg=NONE      gui=NONE
hi mustacheSection                ctermfg=225     ctermbg=NONE   cterm=NONE           guifg=#ffdfff   guibg=NONE      gui=NONE


" CSS
hi cssURL                         ctermfg=NONE    ctermbg=NONE   cterm=NONE           guifg=NONE      guibg=NONE      gui=NONE
hi cssFunctionName                ctermfg=167     ctermbg=NONE   cterm=NONE           guifg=#c45837   guibg=NONE      gui=NONE
hi cssColor                       ctermfg=73      ctermbg=NONE   cterm=NONE           guifg=#6d9cbe   guibg=NONE      gui=NONE
hi cssPseudoClassId               ctermfg=173     ctermbg=NONE   cterm=NONE           guifg=#cc7832   guibg=NONE      gui=NONE
hi cssClassName                   ctermfg=173     ctermbg=NONE   cterm=NONE           guifg=#cc7732   guibg=NONE      gui=NONE
hi cssValueLength                 ctermfg=149     ctermbg=NONE   cterm=NONE           guifg=#b4c973   guibg=NONE      gui=NONE
hi cssCommonAttr                  ctermfg=149     ctermbg=NONE   cterm=NONE           guifg=#b4c973   guibg=NONE      gui=NONE
hi cssBraces                      ctermfg=NONE    ctermbg=NONE   cterm=NONE           guifg=NONE      guibg=NONE      gui=NONE


" Markdown
hi markdownBold                   ctermfg=215     ctermbg=NONE   cterm=bold           guifg=#ffaf5f   guibg=NONE      gui=bold
hi markdownItalic                 ctermfg=215     ctermbg=NONE   cterm=italic         guifg=#ffaf5f   guibg=NONE      gui=italic
hi markdownHeadingDelimiter       ctermfg=166     ctermbg=NONE   cterm=NONE           guifg=#d75f00   guibg=NONE      gui=NONE
hi link markdownH1 markdownHeadingDelimiter
hi link markdownH2 markdownHeadingDelimiter
hi link markdownH3 markdownHeadingDelimiter
hi link markdownH4 markdownHeadingDelimiter
hi link markdownH5 markdownHeadingDelimiter
hi link markdownH6 markdownHeadingDelimiter
hi markdownCodeDelimiter          ctermfg=183     ctermbg=NONE   cterm=NONE           guifg=#dfafff   guibg=NONE      gui=NONE
hi link markdownCode markdownCodeDelimiter
hi link markdownCodeBlock markdownCodeDelimiter
hi markdownUrl                    ctermfg=107     ctermbg=NONE   cterm=italic         guifg=#87af5f   guibg=NONE      gui=italic
hi markdownLinkText               ctermfg=107     ctermbg=NONE   cterm=NONE           guifg=#87af5f   guibg=NONE      gui=NONE
hi link markdownLinkTextDelimiter markdownLinkText
hi link markdownLinkDelimiter markdownLinkText
hi markdownLineBreak              ctermfg=238     ctermbg=238    cterm=inverse        guifg=#444444   guibg=#444444   gui=inverse



" Unchanged from converted AfterGlow color scheme.
hi Pmenu                          ctermfg=15      ctermbg=NONE   cterm=NONE           guifg=#ffffff   guibg=NONE      gui=NONE
hi PmenuSel                       ctermfg=NONE    ctermbg=60     cterm=NONE           guifg=NONE      guibg=#5a647e   gui=NONE
hi Directory                      ctermfg=73      ctermbg=NONE   cterm=NONE           guifg=#6d9cbe   guibg=NONE      gui=NONE
hi Folded                         ctermfg=243     ctermbg=236    cterm=NONE           guifg=#797979   guibg=#2e2e2e   gui=NONE
hi Boolean                        ctermfg=67      ctermbg=NONE   cterm=NONE           guifg=#6c99bb   guibg=NONE      gui=NONE
hi Character                      ctermfg=73      ctermbg=NONE   cterm=NONE           guifg=#6d9cbe   guibg=NONE      gui=NONE
hi Constant                       ctermfg=73      ctermbg=NONE   cterm=NONE           guifg=#6d9cbe   guibg=NONE      gui=NONE
hi Define                         ctermfg=173     ctermbg=NONE   cterm=NONE           guifg=#cc7833   guibg=NONE      gui=NONE
hi DiffAdd                        ctermfg=253     ctermbg=64     cterm=bold           guifg=#d6d6d6   guibg=#48840e   gui=bold
hi DiffDelete                     ctermfg=88      ctermbg=NONE   cterm=NONE           guifg=#8c0909   guibg=NONE      gui=NONE
hi DiffChange                     ctermfg=253     ctermbg=23     cterm=NONE           guifg=#d6d6d6   guibg=#273c5b   gui=NONE
hi DiffText                       ctermfg=253     ctermbg=24     cterm=bold           guifg=#d6d6d6   guibg=#204a87   gui=bold
hi ErrorMsg                       ctermfg=15      ctermbg=88     cterm=NONE           guifg=#ffffff   guibg=#990000   gui=NONE
hi WarningMsg                     ctermfg=15      ctermbg=88     cterm=NONE           guifg=#ffffff   guibg=#990000   gui=NONE
hi Float                          ctermfg=149     ctermbg=NONE   cterm=NONE           guifg=#b4c973   guibg=NONE      gui=NONE
hi Identifier                     ctermfg=132     ctermbg=NONE   cterm=NONE           guifg=#a1617a   guibg=NONE      gui=NONE
hi Keyword                        ctermfg=173     ctermbg=NONE   cterm=NONE           guifg=#cc7833   guibg=NONE      gui=NONE
hi Number                         ctermfg=149     ctermbg=NONE   cterm=NONE           guifg=#b4c973   guibg=NONE      gui=NONE
hi PreProc                        ctermfg=173     ctermbg=NONE   cterm=NONE           guifg=#cc7833   guibg=NONE      gui=NONE
hi Special                        ctermfg=253     ctermbg=NONE   cterm=NONE           guifg=#d6d6d6   guibg=NONE      gui=NONE
hi Tag                            ctermfg=179     ctermbg=NONE   cterm=NONE           guifg=#e8bf6a   guibg=NONE      gui=NONE
hi Title                          ctermfg=253     ctermbg=NONE   cterm=bold           guifg=#d6d6d6   guibg=NONE      gui=bold
hi Todo                           ctermfg=243     ctermbg=NONE   cterm=inverse,bold   guifg=#797979   guibg=NONE      gui=inverse,bold
hi Underlined                     ctermfg=NONE    ctermbg=NONE   cterm=underline      guifg=NONE      guibg=NONE      gui=underline



" Cursor(GUI) and line number colors based on mode to match Airline's colors
function! SetCursorColorInsert(mode)
  " Insert mode: blue
  if a:mode == "i"
    hi CursorLineNr               ctermfg=45      ctermbg=NONE   cterm=NONE           guifg=#00dfff   guibg=NONE      gui=NONE
  
  " Replace mode: red
  elseif a:mode == "r"
    " Cursor colors only work in GUI.
    hi CursorLineNr               ctermfg=124     ctermbg=NONE   cterm=NONE           guifg=#af0000   guibg=NONE      gui=NONE
  endif
endfunction

function! SetCursorColorVisual()
  " Cursor colors only work in GUI.
  hi CursorLineNr                 ctermfg=214     ctermbg=NONE   cterm=NONE           guifg=#ffaf00   guibg=NONE      gui=NONE
  return ''
endfunction

function! ResetCursorColor()
  set updatetime=500
  hi CursorLineNr                 ctermfg=190     ctermbg=NONE   cterm=NONE           guifg=#dfff00   guibg=NONE      gui=NONE
  set updatetime=0
endfunction


vnoremap <silent> <expr> <SID>SetCursorColorVisual SetCursorColorVisual()
nnoremap <silent> <script> v v<SID>SetCursorColorVisual<left><right>
nnoremap <silent> <script> V V<SID>SetCursorColorVisual<left><right>
nnoremap <silent> <script> <C-v> <C-v><SID>SetCursorColorVisual<left><right>


augroup CursorLineNrColorSwap
  autocmd!
  autocmd InsertEnter * call SetCursorColorInsert(v:insertmode)
  autocmd InsertLeave * call ResetCursorColor()
  autocmd CursorHold * call ResetCursorColor()
augroup END
