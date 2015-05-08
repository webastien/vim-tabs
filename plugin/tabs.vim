set tabline=%!MyTabLine()

function MyTabLine()
  let line = ''

  for i in range(tabpagenr('$'))
    let line .= (i + 1 == tabpagenr()? '%#TabLineSel#': '%#TabLine#') .'%{MyTabLabel('. (i + 1) .')}'
  endfor

  return line .'%#TabLineFill#'
endfunction

function MyTabLabel(n)
  let buflist = tabpagebuflist(a:n)
  let index   = 0
  let tabname = []

  while index < len(buflist)
    let bindx = buflist[index]
    let index = index + 1
    let bname = bufname(bindx)
    let bname = (bname != '')? fnamemodify(bname, ':t'): 'new'
    let bname = getbufvar(bindx, "&mod")? '+'. bname .'+': bname

    if bname != '__Tagbar__' && !count(tabname, bname)
      let win = bufwinnr(bindx)

      if win == -1 || !getwinvar(win, '&previewwindow')
        call add(tabname, bname)
      endif
    endif
  endwhile

  if len(tabname) == 0
    return ''
  endif

  return "[ ". join(tabname, ' | ') ." ]"
endfunction

