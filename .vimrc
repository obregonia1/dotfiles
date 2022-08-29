set number
set ruler
set hlsearch
set ignorecase
set smartcase
set tabstop=2
set expandtab
set shiftwidth=2
set backspace=2
set autoindent
set clipboard=unnamed
set cursorline
set incsearch
set smartindent
set title
set laststatus=2
set wildmenu
syntax on
inoremap <silent> jj <ESC>
inoremap <silent> っj <ESC>
inoremap <C-d> <Del>
imap [ []<left>
imap ( ()<left>
imap { {}<left>
nnoremap あ a
nnoremap い i
nnoremap う u
nnoremap お o
filetype plugin indent on

"save undo history
if has('persistent_undo')
	let undo_path = expand('~/.vim/undo')
	exe 'set undodir=' .. undo_path
	set undofile
end

if has('vim_starting')
    " 挿入モード時に非点滅の縦棒タイプのカーソル
    let &t_SI .= "\e[6 q"
    " ノーマルモード時に非点滅のブロックタイプのカーソル
    let &t_EI .= "\e[2 q"
    " 置換モード時に非点滅の下線タイプのカーソル
    let &t_SR .= "\e[4 q"
end
