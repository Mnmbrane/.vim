#!/bin/bash

bash_str='[ -f ~/.vim/vim.bash ] && source ~/.vim/vim.bash'
grep_str='\[\s\-f\s~/.vim/vim.bash\s]\s&&\ssource\s~/.vim/vim.bash'

if ! grep -q $grep_str ~/.bashrc; then
	echo $bash_str >> ~/.bashrc
fi

vim_str='source ~/.vim/rc.vim'
grep_str='source\s~/.vim/rc.vim'
> ~/.vimrc
if ! grep -q $grep_str ~/.vimrc; then
	echo $vim_str >> ~/.vimrc
fi
