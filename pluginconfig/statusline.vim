setlocal laststatus=2
let s:BranchName = ''
let s:ft = ''
let s:fe = ''

hi NormalColor guifg=Black guibg=Blue ctermbg=151 ctermfg=0
hi InsertColor guifg=Black guibg=Orange ctermbg=173 ctermfg=0
hi ReplaceColor guifg=Black guibg=Purple ctermbg=176 ctermfg=0
hi VisualColor guifg=Black guibg=Cyan ctermbg=38 ctermfg=0
hi BranchColor guifg=Black guibg=Cyan ctermbg=145 ctermfg=0
hi StatusLineColor guifg=Black guibg=Black ctermbg=0 ctermfg=255

" Update branch name when we enter or leave a buffer
au BufEnter * let s:BranchName = system('git -C '. expand('%:p:h') .' rev-parse --abbrev-ref HEAD 2>/dev/null | '."tr -d '\n'") | let s:BranchName = (s:BranchName != '') ? '%#BranchColor# '.s:BranchName.' ' : '' |  let s:ft = &ft != '' ? &ft.' | ' : '' | let s:fe = &fileencoding ? &fileencoding : &encoding

function! MyStatusLine() abort
	let l:modeStr= '%#NormalColor# --NORMAL--  '
	let l:RC= '%#NormalColor#%4l:%-4c'
	let l:mode = mode()

	if l:mode[0] != 'n' && l:mode[0] != 't'
		if l:mode == 'v' || l:mode == "\<C-V>"
			let l:modeStr = '%#VisualColor# --VISUAL--  '
			let l:RC= '%#VisualColor#%4l:%-4c'
		elseif l:mode[0] == 'i' " Insert
			let l:modeStr = '%#InsertColor# --INSERT--  '
			let l:RC= '%#InsertColor#%4l:%-4c'
		elseif l:mode[0] == 'R' " Replace
			let l:modeStr = '%#ReplaceColor# --REPLACE-- '
			let l:RC= '%#ReplaceColor#%4l:%-4c'
		endif
	endif

	return l:modeStr.s:BranchName.'%#StatusLine# %f '.'%#StatusLineColor#%m'.'%='.s:ft.s:fe.' | '.&fileformat.' '.'%#StatusLine# %3p%% '.l:RC

endfunction

set statusline=%!MyStatusLine()
