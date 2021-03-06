function! MyTabLine()
  let s = ''
  for i in range(tabpagenr('$'))
    " select the highlighting
    if i + 1 == tabpagenr()
      let s .= '%#TabLineSel#'
    else
      let s .= '%#TabLine#'
    endif

    " set the tab page number (for mouse clicks)
    let s .= '%' . (i + 1) . 'T'

    " the label is made by MyTabLabel()
    let s .= ' %{MyTabLabel(' . (i + 1) . ')} '
  endfor

  " after the last tab fill with TabLineFill and reset tab page nr
  let s .= '%#TabLineFill#%T'

  " right-align the label to close the current tab page
  if tabpagenr('$') > 1
    let s .= '%=%#TabLine#%999Xclose'
  endif

  return s
endfunction

function! MyTabLabel(n)
  let buflist = tabpagebuflist(a:n)
  let winnr = tabpagewinnr(a:n)
  let bname = bufname(buflist[winnr - 1])
  let lastSlash = strridx(bname, '/')
  return strpart(bname, lastSlash + 1, strlen(bname))
endfunction

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
   let l:currentBufNum = bufnr("%")
   let l:alternateBufNum = bufnr("#")

   if buflisted(l:alternateBufNum)
     buffer #
   else
     bnext
   endif

   if bufnr("%") == l:currentBufNum
     new
   endif

   if buflisted(l:currentBufNum)
     execute("bdelete! ".l:currentBufNum)
   endif
endfunction

command! TermModeToggle call <SID>TermModeToggleIt()
function! <SID>TermModeToggleIt()
   if exists("b:mytermmode")
      unlet b:mytermmode
      echo "startinsert ENABLED when entering term buffer"
   else
      let b:mytermmode = 1
      echo "startinsert DISABLED when entering term buffer"
   endif
endfunction

if has('nvim')
   augroup nvimterm_mode
      au!
      autocmd BufEnter term://* call <SID>TermModeRestoreIt()
   augroup END
endif

function! <SID>TermModeRestoreIt()
   if exists("b:mytermmode")
      return
   endif

   startinsert
endfunction
