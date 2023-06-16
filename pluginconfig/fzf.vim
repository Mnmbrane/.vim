" Preview window is hidden by default. You can toggle it with ctrl-/.
" It will show on the right with 50% width, but if the width is smaller
" than 70 columns, it will show above the candidate list
let g:fzf_preview_window = ['hidden,right,50%,<70(up,40%)', 'ctrl-/']
"nnoremap <silent> <C-p> :Files<cr>

let g:fzf_buffers_jump = 1

" Map CTRL+P to FZF
nnoremap <silent><leader>f :call ModBuffer(':FZF')<CR>
nnoremap <silent><leader>g :call ModBuffer(':Ag')<CR>
