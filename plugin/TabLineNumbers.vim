" ============================================================================
" File: TabLineNumbers.vim
" Description: vim global plugin that provides a numbers for tabs
" Maintainer: Konishchev Dmitry
" Contributor: Alexander Tarmolov
" Last Change: 17 July, 2008
" Web Page: http://konishchevdmitry.blogspot.com/2008/07/vim.html
" License: This program is free software. It comes without any warranty,
" to the extent permitted by applicable law. You can redistribute
" it and/or modify it under the terms of the Do What The Fuck You
" Want To Public License, Version 2, as published by Sam Hocevar.
" See http://sam.zoy.org/wtfpl/COPYING for more details.
" ============================================================================

function! MyTabLine()
    let tabline = ''

    " create the tabline for each tab
    for i in range(tabpagenr('$'))
        " highlight current tab title
        if i + 1 == tabpagenr()
            let tabline .= '%#TabLineSel#'
        else
            let tabline .= '%#TabLine#'
        endif

        " set tab number
        let tabline .= '%' . (i + 1) . 'T'

        " get tab name
        let tabline .= ' %{MyTabLabel(' . (i + 1) . ')} |'
    endfor

    " fill other space
    let tabline .= '%#TabLineFill#%T'

    " Allign close button to right side
    if tabpagenr('$') > 1
        let tabline .= '%=%#TabLine#%999XX'
    endif

    return tabline
endfunction

function! MyTabLabel(n)
    let label = ''
    let buflist = tabpagebuflist(a:n)

    " Filename and tab number
    let label = substitute(bufname(buflist[tabpagewinnr(a:n) - 1]), '.*/', '', '')

    if label == ''
        let label = '[No Name]'
    endif

    let label .= ' (' . a:n . ')'

    " detect modified buffers
    for i in range(len(buflist))
        if getbufvar(buflist[i], "&modified")
            let label = '[+] ' . label
            break
        endif
    endfor

    return label
endfunction

set tabline=%!MyTabLine()
