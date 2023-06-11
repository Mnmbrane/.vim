" Preview window is hidden by default. You can toggle it with ctrl-/.
" It will show on the right with 50% width, but if the width is smaller
" than 70 columns, it will show above the candidate list
let g:fzf_preview_window = ['hidden,right,50%,<70(up,40%)', 'ctrl-/']
"nnoremap <silent> <C-p> :Files<cr>

let g:fzf_buffers_jump = 1

let $FZF_DEFAULT_COMMAND = 'rg --files --hidden'

" Map CTRL+P to FZF
nnoremap <leader>p :call ModBuffer(':FZF')<CR>
nnoremap <leader>f :call ModBuffer(':Rg')<CR>
