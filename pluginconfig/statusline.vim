set laststatus=2
let s:BranchName = ''

hi NormalColor guifg=Black guibg=Blue ctermbg=151 ctermfg=0
hi InsertColor guifg=Black guibg=Orange ctermbg=173 ctermfg=0
hi ReplaceColor guifg=Black guibg=Purple ctermbg=176 ctermfg=0
hi VisualColor guifg=Black guibg=Cyan ctermbg=38 ctermfg=0
hi BranchColor guifg=Black guibg=Cyan ctermbg=145 ctermfg=0
hi StatusLineColor guifg=Black guibg=Black ctermbg=0 ctermfg=255
hi PercentColor guifg=Black guibg=Black ctermbg=0 ctermfg=255

" Update branch name when we enter or leave a buffer
au BufEnter,BufLeave * call <sid>UpdateBranch()

" Update Branch Name in the status line
function! s:UpdateBranch()
	let s:BranchName = system('git -C '. expand('%:p:h') .' rev-parse --abbrev-ref HEAD 2>/dev/null | '."tr -d '\n'")
endfunction

" Get the file type
function! s:StatuslineFt()
	return &ft != '' ? &ft.' | ' : ''
endfunction

" Get string with the color
" opt_mode: '' means it applies to ever mode color unless a:color is populated
" color: Color of the status, if a:opt_mode is not given
function s:StatusColor(str, opt_mode, color)
	if a:color != ''
		return '%#'.a:color.'#'.a:str
	elseif mode() == 'n' && (a:opt_mode == 'n' || a:opt_mode=='')
		return '%#NormalColor#'.a:str
	elseif mode() == 'i' && (a:opt_mode == 'i' || a:opt_mode=='')
		echom 'got here'
		return '%#InsertColor#'.a:str
	elseif mode() == 'R' && (a:opt_mode == 'R' || a:opt_mode=='')
		return '%#ReplaceColor#'.a:str
	elseif mode() == 'v' && (a:opt_mode == 'v' || a:opt_mode=='')
		echom a:str
		return '%#VisualColor#'.a:str
	endif
	return ''
endfunction

" Get the File encoding
function s:GetEncoding()
	if &fileencoding
		return &fileendcoding
	else
		return &encoding
	endif
endfunction

function! MyStatusLine() abort
	let l:stl=''
	let l:stl=l:stl.<sid>StatusColor(' --NORMAL--  ', 'n', '')
	let l:stl=l:stl.<sid>StatusColor(' --INSERT--  ', 'i', '')
	let l:stl=l:stl.<sid>StatusColor(' --REPLACE-- ', 'R', '')
	let l:stl=l:stl.<sid>StatusColor(' --VISUAL--  ', 'v', '')
	let l:stl=l:stl.<sid>StatusColor(s:BranchName, '', 'BranchColor')
	let l:stl=l:stl.<sid>StatusColor(' %f ', '', 'StatusLine')
	let l:stl=l:stl.<sid>StatusColor('%m', '', 'StatusLineColor')
	let l:stl=l:stl.'%='
	let l:stl=l:stl.<sid>StatuslineFt()
	let l:stl=l:stl.<sid>GetEncoding()
	let l:stl=l:stl.' | '
	let l:stl=l:stl.&fileformat.' '
	let l:stl=l:stl.<sid>StatusColor(' %3p%% ', '', 'StatusLine')
	let l:stl=l:stl.<sid>StatusColor('%4l:%-4c', '', '')
	return l:stl
endfunction

set statusline=%!MyStatusLine()
