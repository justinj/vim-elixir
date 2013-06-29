" Vim indent file
" Language: Elixir
" Maintainer: Carlos Galdino <carloshsgaldino@gmail.com>
" Last Change: 2013 Apr 24

if exists("b:did_indent")
  finish
endif
let b:did_indent = 1

setlocal nosmartindent

setlocal indentexpr=GetElixirIndent(v:lnum)
setlocal indentkeys+==end,=else:,=match:,=elsif:,=catch:,=after:,=rescue:

if exists("*GetElixirIndent")
  finish
endif

let s:elixir_clauses = '\(else\|match\|elsif\|catch\|after\|rescue\)'
let s:elixir_indent_keywords = '\(do\|fn\|->\|'.s:elixir_clauses.'\)\s*$'
let s:elixir_deindent_keywords = '^\s*\(end\|'.s:elixir_clauses.'\)'

function! GetElixirIndent(line_num)
  " don't indent if it's the first line of the file
  if a:line_num == 1
    return 0
  endif

  let this_line = getline(a:line_num)

  if s:LineIsDeindenter(a:line_num)
    let level = 1
    let line_num = a:line_num
    while level > 0 && line_num > 0
      let line_num -= 1
      let line = getline(line_num)
      if s:LineIsIndenter(line_num)
        let level -= 1
      endif
      if s:LineIsDeindenter(line_num)
        let level += 1
      endif
    endwhile
    return indent(line_num)
  endif

  let plnum = a:line_num - 1
  let prev_nonblank_line = prevnonblank(plnum)
  let previous_line = getline(prev_nonblank_line)

  if s:LineIsIndenter(prev_nonblank_line)
    return indent(prev_nonblank_line) + &sw
  endif

  " blank lines are indented based on the previous not blank line"
  if previous_line =~ '^\s*$'
    let nonblank = prevnonblank(a:line_num)
    return indent(nonblank)
  endif

  return indent(plnum)
endfunction

function! s:LineIsIndenter(lnum)
  if s:LineIsInString(a:lnum)
    return 0
  endif
  return getline(a:lnum) =~ s:elixir_indent_keywords
endfunction

function! s:LineIsDeindenter(lnum)
  if s:LineIsInString(a:lnum)
    return 0
  endif
  return getline(a:lnum) =~ s:elixir_deindent_keywords
endfunction

function! s:LineIsInString(lnum)
  return synIDattr(synID(a:lnum, indent(a:lnum) + 1, 1), 'name') =~ '\(elixirDocString\|elixirString\)'
endfunction
