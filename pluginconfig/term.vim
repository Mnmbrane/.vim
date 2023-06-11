"let s:hidden = 1

function! s:TermOpen(cmd) abort
	let l:list=term_list()
	if empty(l:list)
		call ModBuffer(a:cmd)
		set nobuflisted
		let s:hidden=0
	" TODO: Hide terminal instead of removing it
	"else
		"let l:bufN=l:list[0]
		"echom 'Testing '.l:bufN
		"if s:hidden==0
			"let l:exe='b! '.l:bufN
			"" Terminal is open, then hide it
			"echom 'calling b! '.l:bufN
			"exe l:exe
			"hide
			"let s:hidden=1
		"else
			"" Terminal is hidden, then unhide it
			"exe 'unhide '.l:bufN
			"let s:hidden=0
		"endif
	endif
endfunction

function! s:TermForceClose(a,b) abort
	let tList=term_list()
	if !empty(tList)
		let bufN=tList[0]
		exe 'bdel! '.bufN
	endif
endfunction

nnoremap <silent> <leader>t :call <sid>TermOpen("below call term_start(&shell, { 'exit_cb': '<sid>TermForceClose', 'term_name': '__bash__', 'term_rows':15, 'term_kill':'kill'})")<cr>
command Z w | qa
cabbrev wqa Z
