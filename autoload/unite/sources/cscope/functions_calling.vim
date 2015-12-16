let s:save_cpo = &cpo
set cpo&vim

function! unite#sources#cscope#functions_calling#define() "{{{
  return s:source
endfunction "}}}

let s:source = {
\ 'name' : 'cscope/functions_calling',
\ 'description' : 'Find functions calling this function',
\}

function! s:source.gather_candidates(args, context) "{{{
  call unite#print_message('[cscope/functions_calling] ')
  
  return []
endfunction "}}}

function! s:source.change_candidates(args, context)
  let keyword = a:context.input
  let data = cscope#functions_calling(keyword)

  return map(data, '{
\   "word": v:val.line,
\   "source": s:source.name,
\   "kind": "jump_list",
\   "action__path": v:val.file_name,
\   "action__line": v:val.line_number
\  }')
endfunction

" context getter {{{
function! s:get_SID()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_')
endfunction
let s:SID = s:get_SID()
delfunction s:get_SID

function! unite#sources#cscope#functions_calling#__context__()
  return { 'sid': s:SID, 'scope': s: }
endfunction
"}}}

let &cpo = s:save_cpo
unlet s:save_cpo
" __END__
