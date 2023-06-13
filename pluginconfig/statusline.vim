set laststatus=2
let s:BranchName = ''
let s:modeStr = ' --NORMAL-- '
let s:RC = '' 

hi NormalColor guifg=Black guibg=Blue ctermbg=151 ctermfg=0
hi InsertColor guifg=Black guibg=Orange ctermbg=173 ctermfg=0
hi ReplaceColor guifg=Black guibg=Purple ctermbg=176 ctermfg=0
hi VisualColor guifg=Black guibg=Cyan ctermbg=38 ctermfg=0
hi BranchColor guifg=Black guibg=Cyan ctermbg=145 ctermfg=0
hi StatusLineColor guifg=Black guibg=Black ctermbg=0 ctermfg=255
hi PercentColor guifg=Black guibg=Black ctermbg=0 ctermfg=255

" Update branch name when we enter or leave a buffer
au BufEnter * call <sid>UpdateBranch()

" Update Branch Name in the status line
function! s:UpdateBranch()
	let s:BranchName = system('git -C '. expand('%:p:h') .' rev-parse --abbrev-ref HEAD 2>/dev/null | '."tr -d '\n'")
	let s:BranchName = (s:BranchName != '') ? '%#BranchColor# '.s:BranchName.' ' : ''
endfunction

" Get the file type
function! s:StatuslineFt()
	return &ft != '' ? &ft.' | ' : ''
endfunction

function! s:GetEncoding()
" Get the File encoding
	return &fileencoding ? &fileencoding : &encoding
endfunction

function! s:UpdateStatusLineStr()
	let l:mode = mode()
	if l:mode == 'n' " Normal
		let s:modeStr= '%#NormalColor# --NORMAL--  '
		let s:RC= '%#NormalColor#%4l:%-4c'
	elseif l:mode == 'i' " Insert
		let s:modeStr = '%#InsertColor# --INSERT--  '
		let s:RC= '%#InsertColor#%4l:%-4c'
	elseif l:mode == 'R' " Replace
		let s:modeStr = '%#ReplaceColor# --REPLACE-- '
		let s:RC= '%#ReplaceColor#%4l:%-4c'
	else " Visual
		let s:modeStr = '%#VisualColor# --VISUAL--  '
		let s:RC= '%#VisualColor#%4l:%-4c'
	endif
endfunction

function! MyStatusLine() abort
	call <sid>UpdateStatusLineStr()
	return s:modeStr.s:BranchName.'%#StatusLine# %f '.'%#StatusLineColor#%m'.'%='.<sid>StatuslineFt().<sid>GetEncoding().' | '.&fileformat.' '.'%#StatusLine# %3p%% '.s:RC
endfunction

set statusline=%!MyStatusLine()
