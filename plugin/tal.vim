" Vim syntax file
" Language: TAL
" Version: 1.0
" Last Change:2007/07/24 
" Maintainer: Ajay Kidave <ajayvk@gmail.com>
" Contributors: 

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif


syn case ignore
syn sync lines=250

setlocal iskeyword+=^

syn keyword talBoolean		true false
syn keyword talConditional	if else then and or not of by endif ifnot
syn keyword talLabel		case goto label return
syn keyword talRepeat		do for do while until
syn keyword talStatement	proc subproc
syn keyword talStatement	callable forward external main resident extensible
syn keyword talStatement	define literal
syn keyword talStatement	page section source nolist list
syn keyword talStatement	begin end const assert call scan rscan
syn keyword talType		integer int string real struct ext .ext fixed



" String
if !exists("tal_one_line_string")
  syn region  talString matchgroup=talString start=+'+ end=+'+ contains=talStringEscape
  if exists("tal_gpc")
    syn region  talString matchgroup=talString start=+"+ end=+"+ contains=talStringEscapeGPC
  else
    syn region  talStringError matchgroup=talStringError start=+"+ end=+"+ contains=talStringEscape
  endif
else
  "wrong strings
  syn region  talStringError matchgroup=talStringError start=+'+ end=+'+ end=+$+ contains=talStringEscape
  if exists("tal_gpc")
    syn region  talStringError matchgroup=talStringError start=+"+ end=+"+ end=+$+ contains=talStringEscapeGPC
  else
    syn region  talStringError matchgroup=talStringError start=+"+ end=+"+ end=+$+ contains=talStringEscape
  endif

  "right strings
  syn region  talString matchgroup=talString start=+'+ end=+'+ oneline contains=talStringEscape
  " To see the start and end of strings:
  " syn region  talString matchgroup=talStringError start=+'+ end=+'+ oneline contains=talStringEscape
  if exists("tal_gpc")
    syn region  talString matchgroup=talString start=+"+ end=+"+ oneline contains=talStringEscapeGPC
  else
    syn region  talStringError matchgroup=talStringError start=+"+ end=+"+ oneline contains=talStringEscape
  endif
end
syn match   talStringEscape		contained "''"
syn match   talStringEscapeGPC	contained '""'


" syn match   talIdentifier		"\<[a-zA-Z_][a-zA-Z0-9_]*\>"


if exists("tal_symbol_operator")
  syn match   talSymbolOperator      "[+\-/*=]"
  syn match   talSymbolOperator      "[<>]=\="
  syn match   talSymbolOperator      "<>"
  syn match   talSymbolOperator      ":="
  syn match   talSymbolOperator      "[()]"
  syn match   talSymbolOperator      "\.\."
  syn match   talSymbolOperator       "[\^.]"
  syn match   talMatrixDelimiter	"[][]"
  "if you prefer you can highlight the range
  "syn match  talMatrixDelimiter	"[\d\+\.\.\d\+]"
endif

syn match  talNumber		"-\=\<\d\+\>"
syn match  talFloat		"-\=\<\d\+\.\d\+\>"
syn match  talFloat		"-\=\<\d\+\.\d\+[eE]-\=\d\+\>"
syn match  talHexNumber	"\$[0-9a-fA-F]\+\>"

if exists("tal_no_tabs")
  syn match talShowTab "\t"
endif

syn region talComment	start="--"  end="\n" contains=talTodo
syn region talComment	start="!"  end="[!\n]" contains=talTodo
syn region talComment	start="?IF[ \t]*[0-9][^`]*\n?IFNOT[ \t][0-9]"  end="?ENDIF[ \t][0-9]" contains=talTodo
syn region talComment	start="?IF[ \t]*[0-9][0-9][^`]*\n?IFNOT[ \t][0-9][0-9]"  end="?ENDIF[ \t][0-9][0-9]" contains=talTodo


if !exists("tal_no_functions")
  "syn keyword talPredefined	Input Output

  if exists("tal_traditional")
    " These functions do not seem to be defined in Turbo Pascal
    "syn keyword talFunction	Get Page Put
  endif
endif


" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_tal_syn_inits")
  if version < 508
    let did_tal_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink talAcces		talStatement
  HiLink talBoolean		Boolean
  HiLink talComment		Comment
  HiLink talConditional	Conditional
  HiLink talConstant		Constant
  HiLink talDelimiter	Identifier
  HiLink talDirective	talStatement
  HiLink talException	Exception
  HiLink talFloat		Float
  HiLink talFunction		Function
  HiLink talLabel		Label
  HiLink talMatrixDelimiter	Identifier
  HiLink talModifier		Type
  HiLink talNumber		Number
  HiLink talOperator		Operator
  HiLink talPredefined	talStatement
  HiLink talPreProc		PreProc
  HiLink talRepeat		Repeat
  HiLink talStatement	Statement
  HiLink talString		String
  HiLink talStringEscape	Special
  HiLink talStringEscapeGPC	Special
  HiLink talStringError	Error
  HiLink talStruct		talStatement
  HiLink talSymbolOperator	talOperator
  HiLink talTodo		Todo
  HiLink talType		Type
  HiLink talUnclassified	talStatement
  "  HiLink talAsm		Assembler
  HiLink talError		Error
  HiLink talShowTab		Error

  delcommand HiLink
endif


function! MatchBE()
  let lnum = line(".")
  let fname = expand("%:p")
  let cmd = 'c:\ttags\taljump.exe ' . fname . ' ' . lnum
  let output =system(escape(cmd, '\'))
  execute ':' . output
endfunction


let b:current_syntax = "tal"

" vim: ts=8 sw=2
"
set ic
set nowrap
set expandtab
"map <C-M> $*:noh<CR>0:<Esc>:call histdel("search", -1)<CR>:let @/ = histget("search", -1)<CR>:set hls<CR>
map <C-M> :call MatchBE()<CR>
map <C-W> bve<C-C>
map [[ ?[ b\n\r]proc [^(; ]*[ \t\n\r]*[;(]<CR>:noh<CR>0:<Esc>:call histdel("search", -1)<CR>:let @/ = histget("search", -1)<CR>:set hls<CR>
map ]] j/[ b\n\r]proc [^(; ]*[ \t\n\r]*[;(]<CR>:noh<CR>0:<Esc>:call histdel("search", -1)<CR>:let @/ = histget("search", -1)<CR>:set hls<CR>

syntax sync minlines=300 
set tags=./tags
