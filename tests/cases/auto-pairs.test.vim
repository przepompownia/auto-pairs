function! SetUp()
  below 1new
endfunction

function! TearDown()
  silent! bw! %
endfunction

function! s:appendLineText(lineNumber, lineText)
  call cursor(a:lineNumber, 0)
  execute "normal o".a:lineText."\<Esc>l"
endfunction

function! s:insertInlineText(lineNumber, columnNumber, inlineText)
  call cursor(a:lineNumber, a:columnNumber)
  execute "normal i".a:inlineText."\<Esc>l"
endfunction

function! Test_insert_quote_in_an_empty_line()
  call <SID>insertInlineText(1, 1, '"')
  call assert_equal('""', getline("."))
endfunction

function! Test_fast_wrap()
  call <SID>insertInlineText(1, 1, '"wrapMe"')
  " TODO Replace by 'g:AutoPairsShortcutFastWrap' correctly
  call <SID>insertInlineText(1, 1, "(\<M-e>")
  call assert_equal('("wrapMe")', getline("."))
endfunction

function! Test_fast_wrap_with_disabled_pairing_before_nonspace()
  let g:AutoPairsDisableBeforeNonSpace = 1
  call <SID>insertInlineText(1, 1, '"wrapMe"')
  " TODO Replace by 'g:AutoPairsShortcutFastWrap' correctly
  call <SID>insertInlineText(1, 1, "(\<M-e>")
  call assert_equal('("wrapMe")', getline("."))
endfunction
