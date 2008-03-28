command! -range CoremoSearchAdd    call <SID>CoremoSearch_execute()
command! -range CoremoSearchAddV   call <SID>CoremoSearch_executeV()
command! -range CoremoSearchDel    call <SID>CoremoSearch_delete()
command! -range CoremoSearchDelV   call <SID>CoremoSearch_deleteV()

nnoremap <C-@> :CoremoSearchAdd<CR>
vnoremap <C-@> :CoremoSearchAddV<CR>
nnoremap <Leader><C-@> :CoremoSearchDel<CR>
vnoremap <Leader><C-@> :CoremoSearchDelV<CR>

function! s:CoremoSearch_executeV()
    let old_a = @a

    execute "normal \<ESC>"
    normal gv"ay

    echo 'Coremo Search: ' . @a
    call s:CoremoSearch__add(@a)

    let @a = old_a
endfunction

function! s:CoremoSearch_execute()
    let old_a = @a

    execute "normal \<ESC>"
    normal viw"ay

    echo 'Coremo Search: ' . @a
    call s:CoremoSearch__add('\<' . @a . '\>')

    let @a = old_a
endfunction

function! s:CoremoSearch_deleteV()
    let old_a = @a

    execute "normal \<ESC>"
    normal gv"ay

    echo 'Forgot: ' . @a
    call s:CoremoSearch__deleteInner(@a)

    let @a = old_a
endfunction

function! s:CoremoSearch_delete()
    let old_a = @a

    execute "normal \<ESC>"
    normal viw"ay

    echo 'Forgot: ' . @a
    call s:CoremoSearch__deleteInner('\<' . @a . '\>')

    let @a = old_a
endfunction

function! s:CoremoSearch__add(expr)
    let all = sort(split(@/, '\\|'))
    if index(all, a:expr) == -1
        call add(all, a:expr)
    endif
    let @/ = join(all, '\|')
endfunction

function! s:CoremoSearch__deleteInner(expr)
    let all = sort(split(@/, '\\|'))
    let idx = index(all, a:expr)
    if idx != -1
        call remove(all, idx)
    endif
    let @/ = join(all, '\|')
endfunction
