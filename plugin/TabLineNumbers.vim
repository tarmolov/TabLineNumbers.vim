" ============================================================================
" File: TabLineNumbers.vim
" Description: vim global plugin that provides a numbers for tabs
" Maintainer: Konishchev Dmitry
" Last Change: 17 July, 2008
" Web Page: http://konishchevdmitry.blogspot.com/2008/07/vim.html
" License: This program is free software. It comes without any warranty,
" to the extent permitted by applicable law. You can redistribute
" it and/or modify it under the terms of the Do What The Fuck You
" Want To Public License, Version 2, as published by Sam Hocevar.
" See http://sam.zoy.org/wtfpl/COPYING for more details.
" ============================================================================

" Задаем собственные функции для назначения имен заголовкам табов -->
function! MyTabLine()
    let tabline = ''

    " Формируем tabline для каждой вкладки -->
    for i in range(tabpagenr('$'))
        " Подсвечиваем заголовок выбранной в данный момент вкладки.
        if i + 1 == tabpagenr()
            let tabline .= '%#TabLineSel#'
        else
            let tabline .= '%#TabLine#'
        endif

        " Устанавливаем номер вкладки
        let tabline .= '%' . (i + 1) . 'T'

        " Получаем имя вкладки
        let tabline .= ' %{MyTabLabel(' . (i + 1) . ')} |'
    endfor
    " Формируем tabline для каждой вкладки <--

    " Заполняем лишнее пространство
    let tabline .= '%#TabLineFill#%T'

    " Выровненная по правому краю кнопка закрытия вкладки
    if tabpagenr('$') > 1
        let tabline .= '%=%#TabLine#%999XX'
    endif

    return tabline
endfunction

function! MyTabLabel(n)
    let label = ''
    let buflist = tabpagebuflist(a:n)

    " Имя файла и номер вкладки -->
    let label = substitute(bufname(buflist[tabpagewinnr(a:n) - 1]), '.*/', '', '')

    if label == ''
        let label = '[No Name]'
    endif

    let label .= ' (' . a:n . ')'
    " Имя файла и номер вкладки <--

    " Определяем, есть ли во вкладке хотя бы один
    " модифицированный буфер.
    " -->
    for i in range(len(buflist))
        if getbufvar(buflist[i], "&modified")
            let label = '[+] ' . label
            break
        endif
    endfor
    " <--

    return label
endfunction

set tabline=%!MyTabLine()
