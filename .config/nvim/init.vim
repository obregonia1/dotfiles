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
" set foldmethod=syntax
set termguicolors
set scrolloff=5
" gitgutterを常に表示
set signcolumn=yes
set updatetime=100
set history=10000
set viminfo+=!
set autoread
set noswapfile

filetype plugin indent on
let g:mapleader = "\<Space>"

" インサート
inoremap <silent> jj <ESC>
inoremap <silent> っj <ESC>
inoremap <C-a> <Home>
inoremap <C-d> <Del>
inoremap <C-f> <Right>
inoremap <C-b> <Left>
" coc.vim
inoremap <silent><expr> <Enter> coc#pum#visible() ? coc#pum#confirm() : "\<Enter>"

" ノーマル
nnoremap <c-h> <c-w><c-h>
nnoremap <c-j> <c-w><c-j>
nnoremap <c-k> <c-w><c-k>
nnoremap <c-l> <c-w><c-l>
nnoremap L $
nnoremap <Leader>e :Fern . -reveal=%<CR>
nnoremap <Leader>ve :Fern . -reveal=% -opener=vsplit<CR>
nnoremap <Leader>se :Fern . -reveal=% -opener=split<CR>
nnoremap <Leader>sp :sp<CR>
nnoremap <Leader>vs :vs<CR>
" スペース + wでファイル保存
nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :q<CR>
" スペース + v でvimrcを開く
" nnoremap <Leader>v :new $MYVIMRC<CR>
" スペース + d でdein.tomlを開く
" nnoremap <Leader>d :new ~/.config/nvim/dein.toml<CR>
" スペース + r でvimrcを開く
nnoremap <Leader>r :source ~/.config/nvim/init.vim<CR>
nnoremap <silent> <leader>k :bprev<CR>
nnoremap <silent> <leader>j :bnext<CR>
nnoremap <leader>gg :G<CR>
nnoremap <leader>gs :G status<CR>
nnoremap <leader>gb :G blame<CR>
nnoremap <leader>gl :G log<CR>
" xはレジスタ入れない
nnoremap x "_x
" カレントバッファの相対パスをクリップボードにコピー
nnoremap <Leader>cp :let @* = expand('%')<CR>
nnoremap j gj
nnoremap k gk
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
" trouble.nvim
nnoremap <leader>xx <cmd>TroubleToggle<cr>
nnoremap <leader>xw <cmd>TroubleToggle workspace_diagnostics<cr>
nnoremap <leader>xd <cmd>TroubleToggle document_diagnostics<cr>
nnoremap <leader>xq <cmd>TroubleToggle quickfix<cr>
nnoremap <leader>xl <cmd>TroubleToggle loclist<cr>
nnoremap gR <cmd>TroubleToggle lsp_references<cr>
" ウィンドウ幅調整を大きく
nnoremap <C-w>+ 4<C-w>+
nnoremap <C-w>- 4<C-w>-
nnoremap <C-w>> 4<C-w>>
nnoremap <C-w>< 4<C-w><
" 水平分割してしたにターミナルを開く
nnoremap <leader>t <cmd>40split \| wincmd j \| terminal<cr>
nnoremap <leader>b <cmd>BuffergatorOpen<cr>

" ヴィジュアル
vnoremap L $
vnoremap x "_x

" コマンドライン
cnoremap <c-f> <Right>
cnoremap <c-b> <Left>
cnoremap <c-A> <Home>
function! RemoveCharAfterCursor()
    let cmdline = getcmdline()
    let pos = getcmdpos() - 1
    if pos == 0
        return cmdline[1:]
    endif
    return cmdline[:pos - 1] . cmdline[pos + 1:]
endfunction
cnoremap <C-d> <C-\>eRemoveCharAfterCursor()<CR>
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

" fzf-preview
" nmap <Leader>f [fzf-p]
" xmap <Leader>f [fzf-p]
" nnoremap <silent> [fzf-p]f     :<C-u>CocCommand fzf-preview.FromResources project_mru git<CR>
" nnoremap <silent> [fzf-p]gs    :<C-u>CocCommand fzf-preview.GitStatus<CR>
" nnoremap <silent> [fzf-p]ga    :<C-u>CocCommand fzf-preview.GitActions<CR>
" nnoremap <silent> [fzf-p]b     :<C-u>CocCommand fzf-preview.Buffers<CR>
" nnoremap <silent> [fzf-p]B     :<C-u>CocCommand fzf-preview.AllBuffers<CR>
" nnoremap <silent> [fzf-p]o     :<C-u>CocCommand fzf-preview.FromResources buffer project_mru<CR>
" nnoremap <silent> [fzf-p]<C-o> :<C-u>CocCommand fzf-preview.Jumps<CR>
" nnoremap <silent> [fzf-p]g;    :<C-u>CocCommand fzf-preview.Changes<CR>
" nnoremap <silent> [fzf-p]/     :<C-u>CocCommand fzf-preview.Lines --add-fzf-arg=--no-sort --add-fzf-arg=--query="'"<CR>
" nnoremap <silent> [fzf-p]*     :<C-u>CocCommand fzf-preview.Lines --add-fzf-arg=--no-sort --add-fzf-arg=--query="'<C-r>=expand('<cword>')<CR>"<CR>
" nnoremap          [fzf-p]gr    :<C-u>CocCommand fzf-preview.ProjectGrep<Space>
" xnoremap          [fzf-p]gr    "sy:CocCommand   fzf-preview.ProjectGrep<Space>-F<Space>"<C-r>=substitute(substitute(@s, '\n', '', 'g'), '/', '\\/', 'g')<CR>"
" nnoremap <silent> [fzf-p]t     :<C-u>CocCommand fzf-preview.BufferTags<CR>
" nnoremap <silent> [fzf-p]q     :<C-u>CocCommand fzf-preview.QuickFix<CR>
" nnoremap <silent> [fzf-p]l     :<C-u>CocCommand fzf-preview.LocationList<CR>
" nnoremap <silent> [fzf-p]p     :<C-u>CocCommand fzf-preview.BlamePR<CR>

" let g:fzf_preview_command = 'bat --color=always --plain {-1}'

" coc
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" ターミナル
tnoremap <leader>n <C-\><C-n>
tnoremap <C-f> <Right>
tnoremap <C-b> <Left>

" すべての折りたたみを開く
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

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

" autocomplete
inoremap <silent><expr> <C-j> coc#pum#visible() ? coc#pum#next(1) : "\<C-j>"
inoremap <silent><expr> <C-k> coc#pum#visible() ? coc#pum#prev(1) : "\<C-k>"
inoremap <silent><expr> <Enter> coc#pum#visible() ? coc#pum#confirm() : "\<Enter>"
inoremap <silent><expr> <Esc> coc#pum#visible() ? coc#pum#cancel() : "\<Esc>"
inoremap <silent><expr> <C-h> coc#pum#visible() ? coc#pum#cancel() : "\<C-h>"

" <Tab>で次、<S+Tab>で前
inoremap <silent><expr> <TAB>
  \ coc#pum#visible() ? coc#pum#next(1):
  \ <SID>check_back_space() ? "\<C-n>" :
  \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-p>" " "\<C-h>"
inoremap <silent><expr> <c-space> coc#refresh()

let g:ale_fixers = {
\   'javascript': ['eslint'],
\   'ruby': ['rubocop'],
\}
let g:ale_fix_on_save = 1
let g:loaded_perl_provider = 0

" indent color
" Vim 起動時 vim-indent-guides を自動起動
let g:indent_guides_enable_on_vim_startup=1
" ガイドをスタートするインデントの量
let g:indent_guides_start_level=2
" 自動カラー無効
let g:indent_guides_auto_colors=0
" 奇数番目のインデントの色
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#444433 ctermbg=black
" 偶数番目のインデントの色
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#333344 ctermbg=darkgray
" ガイドの幅
let g:indent_guides_guide_size = 1

" neovim-ruby-host を動的に設定する
let ruby_path = system('which ruby')
let ruby_path = substitute(ruby_path, '\n\+$', '', '')
let g:ruby_host_prog = substitute(ruby_path, 'bin/ruby$', 'bin/neovim-ruby-host', '')

highlight GitGutterAdd    guifg=#009900 ctermfg=2
highlight GitGutterChange guifg=#bbbb00 ctermfg=3
highlight GitGutterDelete guifg=#ff2222 ctermfg=1

" skkeleton
call skkeleton#config({ 'globalDictionaries': ['~/.skk/SKK-JISYO.L'] })
imap <C-j> <Plug>(skkeleton-enable)
cmap <C-j> <Plug>(skkeleton-enable)

" Terminalを開くとデフォルトでインサートにする
autocmd TermOpen * startinsert

" github の pr を開く openpr
" gitconfig に設定してある openpr が前提
function! s:openpre_open() abort
  let line = line('.')
  let fname = expand('%')
  let cmd = printf('git blame -L %d,%d %s | cut -d " " -f 1', line, line, fname)
  let sha1 = system(cmd)
  let cmd = printf('gh pr list --state all -w --search %s', sha1)
  echo system(cmd)
endfunction
nnoremap <leader>gpr :call <SID>openpre_open()<CR>

" コメントアウト行で新しい行を追加すると自動でコメントアウトされるのを防ぐ
augroup turn_off_auto_commenting
  autocmd!
  autocmd FileType * setlocal formatoptions-=cro
augroup END

highlight LineNr guifg=#9a9a9a
autocmd VimEnter,SourcePost * :highlight! ALEError guifg=#C30500 guibg=#151515
autocmd VimEnter,SourcePost * :highlight! ALEWarning  guifg=#ffd300 guibg=#333333
cnoreabbrev <expr> s getcmdtype() .. getcmdline() ==# ':s' ? [getchar(), ''][1] .. "%s///g<Left><Left>" : 's'
highlight Comment ctermfg=1 guifg=#676fa9 cterm=italic

" Vue でコメントアウトする用
let g:ft = ''
function! NERDCommenter_before()
  if &ft == 'vue'
    let g:ft = 'vue'
    let stack = synstack(line('.'), col('.'))
    if len(stack) > 0
      let syn = synIDattr((stack)[0], 'name')
      if len(syn) > 0
        exe 'setf ' . substitute(tolower(syn), '^vue_', '', '')
      endif
    endif
  endif
endfunction
function! NERDCommenter_after()
  if g:ft == 'vue'
    setf vue
    let g:ft = ''
  endif
endfunction

" 無ければ自動インストール
let g:coc_global_extensions = [
  \ 'coc-eslint',
  \ 'coc-json',
  \ 'coc-prettier',
  \ 'coc-snippets',
  \ 'coc-solargraph',
  \ 'coc-tsserver',
  \ 'coc-vetur',
\]
