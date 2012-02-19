" Automatisation layer for vim session mamagment
" Author: Carlo Baldassi <carlobaldassi@gmail.com>
" Notes: This plugin is in rudimentary stage, review the code
"        before usage

let g:session_dir = $HOME . "/ViM_sessions/"

function! SessionName()
	if ! isdirectory(g:session_dir)
		if exists("*mkdir")
			call mkdir(g:session_dir, "p")
		endif
	endif
	if ! isdirectory(g:session_dir)
		echohl WarningMsg | echo "Couldn't find nor create session directory" | echohl None
		return 1
	endif
	echohl MoreMsg | let v:this_session = g:session_dir . inputdialog("Choose a name for this session: ") | echohl None
endfunction

function! SaveSession() abort
	if (v:this_session == "") || (v:this_session == g:session_dir)
		call SessionName()
	endif
	if v:this_session!=""
		wa
		"silent exe "!ctags -R"
		exe "mksession! " . v:this_session
		echohl MoreMsg | echom "Session saved in file: " . v:this_session | echohl None
		return 1
	else
		echohl WarningMsg | echom "No current session found" | echohl None
		return 0
	endif
endfunction

function! SaveSessionAndQuit() abort
	if SaveSession()
		:qa
	endif
endfunction	

" Mappings
nmap <F2> :call SaveSession()<CR>
nmap <S-F2> :call SaveSessionAndQuit()<CR>
