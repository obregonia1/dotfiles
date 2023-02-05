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
syntax on
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
" gitgutterを常に表示
set signcolumn=yes
set updatetime=100
set history=10000
set viminfo='1000

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
nnoremap <Leader>q :q<CR>
" スペース + v でvimrcを開く
nnoremap <Leader>v :new $MYVIMRC<CR>
" スペース + d でdein.tomlを開く
nnoremap <Leader>d :new ~/.config/nvim/dein.toml<CR>
" スペース + r でvimrcを開く
nnoremap <Leader>r :source ~/.config/nvim/init.vim<CR>
nnoremap <silent> <leader>j :bprev<CR>
nnoremap <silent> <leader>k :bnext<CR>
nnoremap <leader>gg :G<CR>
nnoremap <leader>u :UndotreeToggle<CR>
" xはレジスタ入れない
nnoremap x "_x
" カレントバッファの相対パスをクリップボードにコピー
nnoremap <Leader>cp :let @* = expand('%')<CR>

" ヴィジュアル
vnoremap L $
vnoremap x "_x

" コマンドライン
cnoremap <c-f> <Right>
cnoremap <c-b> <Left>
cnoremap <c-A> <Home>

" fzf-preview
nmap <Leader>f [fzf-p]
xmap <Leader>f [fzf-p]
nnoremap <silent> [fzf-p]f     :<C-u>CocCommand fzf-preview.FromResources project_mru git<CR>
nnoremap <silent> [fzf-p]gs    :<C-u>CocCommand fzf-preview.GitStatus<CR>
nnoremap <silent> [fzf-p]ga    :<C-u>CocCommand fzf-preview.GitActions<CR>
nnoremap <silent> [fzf-p]b     :<C-u>CocCommand fzf-preview.Buffers<CR>
nnoremap <silent> [fzf-p]B     :<C-u>CocCommand fzf-preview.AllBuffers<CR>
nnoremap <silent> [fzf-p]o     :<C-u>CocCommand fzf-preview.FromResources buffer project_mru<CR>
nnoremap <silent> [fzf-p]<C-o> :<C-u>CocCommand fzf-preview.Jumps<CR>
nnoremap <silent> [fzf-p]g;    :<C-u>CocCommand fzf-preview.Changes<CR>
nnoremap <silent> [fzf-p]/     :<C-u>CocCommand fzf-preview.Lines --add-fzf-arg=--no-sort --add-fzf-arg=--query="'"<CR>
nnoremap <silent> [fzf-p]*     :<C-u>CocCommand fzf-preview.Lines --add-fzf-arg=--no-sort --add-fzf-arg=--query="'<C-r>=expand('<cword>')<CR>"<CR>
nnoremap          [fzf-p]gr    :<C-u>CocCommand fzf-preview.ProjectGrep<Space>
xnoremap          [fzf-p]gr    "sy:CocCommand   fzf-preview.ProjectGrep<Space>-F<Space>"<C-r>=substitute(substitute(@s, '\n', '', 'g'), '/', '\\/', 'g')<CR>"
nnoremap <silent> [fzf-p]t     :<C-u>CocCommand fzf-preview.BufferTags<CR>
nnoremap <silent> [fzf-p]q     :<C-u>CocCommand fzf-preview.QuickFix<CR>
nnoremap <silent> [fzf-p]l     :<C-u>CocCommand fzf-preview.LocationList<CR>

let g:fzf_preview_command = 'bat --color=always --plain {-1}'

autocmd BufRead * normal zR
" 保存時末尾の空白削除
autocmd BufWritePre * :%s/\s\+$//e
nmap <Esc> :nohl<CR>
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

let g:coc_global_extensions = ['coc-solargraph']

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:ale_fixers = {
\   'javascript': ['eslint'],
\   'ruby': ['rubocop'],
\}
let g:ale_fix_on_save = 1
let g:loaded_perl_provider = 0
