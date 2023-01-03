" dein.vim settings {{{
" install dir {{{
let s:dein_dir = expand('~/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
" }}}

" dein installation check {{{
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . s:dein_repo_dir
endif
" }}}

" begin settings {{{
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " .toml filu
  let s:rc_dir = expand('~/.config/nvim')
  if !isdirectory(s:rc_dir)
    call mkdir(s:rc_dir, 'p')
  endif
  let s:toml = s:rc_dir . '/dein.toml'
  let s:lazy_toml = s:rc_dir . '/dein_lazy.toml'

  " read toml and cache
  call dein#load_toml(s:toml, {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  " end settings
  call dein#end()
  call dein#save_state()
endif
" }}}

" plugin installation check {{{
if dein#check_install()
  call dein#install()
endif
" }}}

" plugin remove check {{{
let s:removed_plugins = dein#check_clean()
if len(s:removed_plugins) > 0
  call map(s:removed_plugins, "delete(v:val, 'rf')")
  call dein#recache_runtimepath()
endif
" }}}

language en_US.UTF-8
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
set foldmethod=syntax
set termguicolors
set scrolloff=5
filetype plugin indent on
let g:mapleader = "\<Space>"

" インサート
inoremap <silent> jj <ESC>
inoremap <silent> っj <ESC>
inoremap <C-a> <Home>
inoremap <C-d> <Del>
inoremap <C-f> <Right>
inoremap <C-b> <Left>
inoremap ' ''<esc>i
inoremap " ""<esc>i
inoremap [ []<left>
inoremap ( ()<left>
inoremap { {}<left>

" ノーマル
nnoremap <c-h> <c-w><c-h>
nnoremap <c-j> <c-w><c-j>
nnoremap <c-k> <c-w><c-k>
nnoremap <c-l> <c-w><c-l>
nnoremap L $
" スペース + wでファイル保存
nnoremap <Leader>w :w<CR>
" スペース + v でvimrcを開く
nnoremap <Leader>v :new $MYVIMRC<CR>
" スペース + d でdein.tomlを開く
nnoremap <Leader>d :new ~/.config/nvim/dein.toml<CR>
" スペース + r でvimrcを
nnoremap <Leader>r :source $MYVIMRC<CR>

" ヴィジュアル
vnoremap L $

" コマンドライン
cnoremap <c-f> <Right>
cnoremap <c-b> <Left>
cnoremap <c-A> <Home>

autocmd BufRead * normal zR
" 保存時末尾の空白削除
autocmd BufWritePre * :%s/\s\+$//e
nmap <Esc><Esc> :nohl<CR>
map s <Plug>(easymotion-prefix)

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

packloadall
silent! helptags ALL
set laststatus=2
set showcmd

" スペースや改行を可視化
set listchars=tab:>-,trail:_,eol:↲
set list
" スペースや改行の色
" hi NonText ctermfg=8
" hi SpecialKey ctermfg=8
colorscheme onedark
" 全角スペースをハイライト表示
function! ZenkakuSpace()
    highlight ZenkakuSpace cterm=reverse ctermfg=DarkMagenta gui=reverse guifg=DarkMagenta
endfunction
augroup ZenkakuSpace
    autocmd!
    autocmd ColorScheme       * call ZenkakuSpace()
    autocmd VimEnter,WinEnter * match ZenkakuSpace /　/
augroup END
call ZenkakuSpace()

" shellのaliasを使えるようにする
set shellcmdflag=-ic
" インデントを自動で可視化
let g:indent_guides_enable_on_vim_startup = 1
