let s:save_cpo = &cpo
set cpo&vim

function! cscope#process_data(query)
  let data = cscope#execute_command(a:query)

  let results = []

  for i in split(data, '\n')
    call add(results, cscope#line_parse(i))
  endfor

  return results
endfunction

function! cscope#find_this_symbol(keyword)
  return "cscope -d -L0 " . shellescape(a:keyword)
endfunction

function! cscope#global_definition(keyword)
  return "cscope -d -L1 " . shellescape(a:keyword)
endfunction

function! cscope#functions_called_by(keyword)
  return "cscope -d -L2 " . shellescape(a:keyword)
endfunction

function! cscope#functions_calling(keyword)
  return "cscope -d -L3 " . shellescape(a:keyword)
endfunction

function! cscope#text_string(keyword)
  return "cscope -d -L4 " . shellescape(a:keyword)
endfunction

function! cscope#egrep_pattern(keyword)
  return "cscope -d -L6 " . shellescape(a:keyword)
endfunction

function! cscope#find_file(keyword)
  return "cscope -d -L7 " . shellescape(a:keyword)
endfunction

function! cscope#including_this_file(keyword)
  return "cscope -d -L8 " . shellescape(a:keyword)
endfunction

function! cscope#assignments_to_symbol(keyword)
  return "cscope -d -L9 " . shellescape(a:keyword)
endfunction

function! cscope#line_parse(line)
  let details = split(a:line)
  return {
\    "line": a:line,
\    "file_name": details[0],
\    "function_name": details[1],
\    "line_number": str2nr(details[2], 10),
\    "code_line": join(details[3:])
\  }
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
