" Copyright (c) 2020 Jongwook Choi
"
" MIT License
"
let s:cpo_save = &cpo
set cpo&vim
" ------------------------------------------------------------------

function! s:rg_star_to_cword(args, ...) abort
  let l:add_boundary = get(a:, 1, '\b')

  if a:args == '*'   " * is designated to word under cursor
    return l:add_boundary . expand("<cword>") . l:add_boundary   " \b for word boundaries
  else
    return a:args
    " return a:1
  endif
endfunction

function! s:rg_options(flg_fullscreen, ...) abort

    let dic_options = {'path':'./', 'fullscreen':a:flg_fullscreen}
    " let root_path = a:0 > 2 ? a:3 : './'
    let root_path = a:0 > 1 ? a:2 : './'

    let dic_options.path = root_path

    return  dic_options
endfunction


" :RgFzf (ripgrep + fzf)
command! -bang -nargs=* RgFzf      call fzf#vim#ripgrep#rg_fzf(s:rg_star_to_cword(<q-args>), {'fullscreen' : <bang>0})

" :Rg (ripgrep interactive)
" command! -nargs=* -bang Rg         call fzf#vim#ripgrep#rg(s:rg_star_to_cword(<q-args>), {'fullscreen' : <bang>0})
command! -nargs=* -bang Rg         call fzf#vim#ripgrep#rg(s:rg_star_to_cword(<f-args>), s:rg_options(<bang>0, <f-args>))

" :Def, Rgdef -- Easily find definition/declaration (requires ripgrep)
" e.g. :Def class, :Def def, :Def myfunc, :Def class MyClass
command! -bang -nargs=* RgDefFzf   call fzf#vim#ripgrep#rgdef_fzf(s:rg_star_to_cword(<q-args>), {'fullscreen': <bang>0})

" ------------------------------------------------------------------
let &cpo = s:cpo_save
unlet s:cpo_save

