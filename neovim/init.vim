" ------------------------------------------------------------
"
"   Dein
"
" ------------------------------------------------------------
" プラグインが実際にインストールされるディレクトリ
let s:dein_dir = expand('~/.config/nvim/dein')
" dein.vim 本体
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
" dein.vim がなければ github から落としてくる
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif
" 設定開始
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " 管理するプラグインを記述したファイル
  let s:toml        = '~/.config/nvim/dein.toml'
  let s:lazy_toml   = '~/.config/nvim/dein_lazy.toml'
  call dein#load_toml(s:toml, {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  call dein#end()
  call dein#save_state()
endif

" もし、未インストールものものがあったらインストール
if dein#check_install()
  call dein#install()
endif

" ------------------------------------------------------------
"
"   settings
"
" ------------------------------------------------------------
" vi互換モードにならないようにする
set nocompatible
" 構文により色をつける
syntax on
" filetypeの自動検出
filetype on
" filetype別のプラグインをonにする
filetype plugin on
" filetype別のインデント設定をonにする
filetype indent on
" マクロなどの途中描画をしない
set lazyredraw
"encoding setting
scriptencoding utf-8
set encoding=utf-8
"フォント
set guifont=Ricty:h16
"F12を押すとペーストモードに
set pastetoggle=<F12>
" 256色ターミナルに対応
set t_Co=256
"タブやインデントの設定
" タブ入力を空白文字に置き換え
set expandtab
" タブ文字の幅
set tabstop=4
" 自動インデントの幅
set shiftwidth=4
" 連続空白に対してタブキーやバックスペースキーでカーソルが動く幅
set softtabstop=4
" 改行時に前の行のインデントを継続
set autoindent
" 改行時に入力された行の末尾に合わせて次の行のインデントを決める
set smartindent
" 行番号の表示
set number
" 行番号部分の文字色
autocmd ColorScheme * highlight LineNr ctermfg=242
" カーソル行の背景色を変える
set cursorline
" カーソル列の背景色を変える
" set cursorcolumn
" ステータスラインを常に表示
set laststatus=2
" メッセージ表示欄を2行確保
set cmdheight=2
" 常にタブラインを表示
set showtabline=2
" 対応する括弧を強調表示
set showmatch
" ヘルプを画面いっぱいに開く
set helpheight=999
" 不可視文字を表示
set list
" 表示する不可視文字を指定
set listchars=trail:_,extends:>,precedes:<,nbsp:%,eol:↲,tab:▸\
"ファイル関係
" 終了時に未保存のファイルがあるときに保存確認
set confirm
" 未保存ファイルがあるときでも別ファイルを開ける
set hidden
" 外部でファイルが変更されたときに読み直す
set autoread
" ファイル保存時にバックアップファイルを作らない
set nobackup
" ファイル編集中にスワップファイルを作らない
set noswapfile
" INSERTモードでバックスペースキーで文字の消去ができるように設定
set backspace=indent,eol,start
" 検索文字列をハイライト
set hlsearch
" インクリメンタルサーチ
set incsearch
" 大文字と小文字を区別しない
set ignorecase
" 大文字と小文字が混在した状態で検索したときに限り大文字と小文字を区別
set smartcase
" 最後尾まで検索し終わったら先頭から検索し直す
set wrapscan
" 置換のgオプションをデフォルトで有効にする
set gdefault
"コマンドラインモードでTABキーによるファイル名補完を有効にする
set wildmenu wildmode=list:longest,full
" コマンドラインの履歴を10000件保存する
set history=10000
" :vsのとき新しいウインドウを右側に開く
set splitright
" :spのとき新しいウインドウを下側に開く
set splitbelow
" カラースキーム
set background=dark " or light
colorscheme iceberg

" ------------------------------------------------------------
"
"   lightline config
"
" ------------------------------------------------------------
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'mode_map': { 'c': 'NORMAL' },
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ]
      \ },
      \ 'component_function': {
      \   'modified': 'LightLineModified',
      \   'readonly': 'LightLineReadonly',
      \   'fugitive': 'LightLineFugitive',
      \   'filename': 'LightLineFilename',
      \   'fileformat': 'LightLineFileformat',
      \   'filetype': 'LightLineFiletype',
      \   'fileencoding': 'LightLineFileencoding',
      \   'mode': 'LightLineMode',
      \ },
      \ 'separator': { 'left': '⮀', 'right': '⮂' },
      \ 'subseparator': { 'left': '⮁', 'right': '⮃' }
      \ }

function! LightLineModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightLineReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? '⭤' : ''
endfunction

function! LightLineFilename()
  return ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
        \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
        \  &ft == 'unite' ? unite#get_status_string() :
        \  &ft == 'vimshell' ? vimshell#get_status_string() :
        \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
        \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
endfunction

function! LightLineFugitive()
  if &ft !~? 'vimfiler\|gundo' && exists("*fugitive#head")
    let _ = fugitive#head()
    return strlen(_) ? '⭠ '._ : ''
  endif
  return ''
endfunction

function! LightLineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightLineFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! LightLineFileencoding()
  return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! LightLineMode()
  return winwidth(0) > 60 ? lightline#mode() : ''
endfunction

" ------------------------------------------------------------
"
"   保存時に行末の空白を除去する
"
" ------------------------------------------------------------
autocmd BufWritePre * :%s/\s\+$//ge

" ------------------------------------------------------------
"
"   insertモードでカーソルの形を変える
"
" ------------------------------------------------------------
if !has('gui_running')
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

" ------------------------------------------------------------
"
"   入力モード時、ステータスラインのカラーを変更
"
" ------------------------------------------------------------
augroup InsertHook
autocmd!
autocmd InsertEnter * highlight StatusLine guifg=#ccdc90 guibg=#2E4340
autocmd InsertLeave * highlight StatusLine guifg=#2E4340 guibg=#ccdc90
augroup END

" ------------------------------------------------------------
"
"   全角スペースを視覚化
"
" ------------------------------------------------------------
highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=#666666
au BufNewFile,BufRead * match ZenkakuSpace /　/

" ------------------------------------------------------------
"
"   ペーストしたときに自動インデントを無効にする
"
" ------------------------------------------------------------
if &term =~ "xterm"
    let &t_ti .= "\e[?2004h"
    let &t_te .= "\e[?2004l"
    let &pastetoggle = "\e[201~"

    function XTermPasteBegin(ret)
        set paste
        return a:ret
    endfunction

    noremap <special> <expr> <Esc>[200~ XTermPasteBegin("0i")
    inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
    cnoremap <special> <Esc>[200~ <nop>
    cnoremap <special> <Esc>[201~ <nop>
endif

" ------------------------------------------------------------
"
"   template
"
" ------------------------------------------------------------
" テンプレートのパス
autocmd FileType * execute 'TemplateLoad /' . &l:filetype
" テンプレート中に含まれる特定文字列を置き換える
autocmd User plugin-template-loaded call s:template_keywords()
function! s:template_keywords()
    silent! %s/<+DATE+>/\=strftime('%Y-%m-%d')/g
    silent! %s/<+FILENAME+>/\=expand('%:r')/g
endfunction
" テンプレート中に含まれる'<+CURSOR+>'にカーソルを移動
autocmd User plugin-template-loaded
    \   if search('<+CURSOR+>')
    \ |   silent! execute 'normal! "_da>'
    \ | endif

" ------------------------------------------------------------
"
"   deoplete
"
" ------------------------------------------------------------
let g:deoplete#enable_at_startup = 1

" ------------------------------------------------------------
"
"   Unite
"
" ------------------------------------------------------------
let g:unite_source_file_mru_limit = 50

" ------------------------------------------------------------
"
"   file_mruの表示フォーマット
"
" ------------------------------------------------------------
let g:unite_source_file_mru_filename_format = ''

" ------------------------------------------------------------
"
"   vim-indent-guides
"
" ------------------------------------------------------------
let g:indent_guides_enable_on_vim_startup = 1

" ------------------------------------------------------------
"
"   vim-quickrun
"
" ------------------------------------------------------------
let g:quickrun_config={'_': {'split': 'vertical'}}

" ------------------------------------------------------------
"
"   gitgutter
"
" ------------------------------------------------------------
let g:gitgutter_sign_added = '✚'
let g:gitgutter_sign_modified = '➜'
let g:gitgutter_sign_removed = '✘'

" ------------------------------------------------------------
"
"   committia
"
" ------------------------------------------------------------
let g:committia_hooks = {}
" single columnになるwindowの幅の境界
let g:committia_min_window_width = 120
function! g:committia_hooks.edit_open(info)
    " Additional settings
    setlocal spell
    " If no commit message, start with insert mode
    if a:info.vcs ==# 'git' && getline(1) ==# ''
        startinsert
    end
    " Scroll the diff window from insert mode
    " Map <C-n> and <C-p>
    imap <buffer><C-n> <Plug>(committia-scroll-diff-down-half)
    imap <buffer><C-p> <Plug>(committia-scroll-diff-up-half)
endfunction

" ------------------------------------------------------------
"
"   keymap
"
" ------------------------------------------------------------
" ###############
"  NORMAL mode
" ###############
noremap <Nul> :VimFilerExplorer<CR>
" The prefix key.
nnoremap    [Tag]   <Nop>
nmap    t [Tag]
" Tab jump
" t1 で1番左のタブ、t2 で1番左から2番目のタブにジャンプ
for n in range(1, 9)
  execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'
endfor
" tc 新しいタブを一番右に作る
map <silent> [Tag]c :tablast <bar> tabnew<CR>
" tx タブを閉じる
map <silent> [Tag]x :tabclose<CR>
" tn 次のタブ
map <silent> [Tag]n :tabnext<CR>
" tp 前のタブ
map <silent> [Tag]p :tabprevious<CR>
" Ecs2回押すとハイライト解除
nmap <silent> <Esc><Esc> :nohlsearch<CR>
"" unite.vim {{{
" The prefix key.
nnoremap    [unite]   <Nop>
nmap    <Space>f [unite]
" unite.vim keymap
" https://github.com/alwei/dotfiles/blob/3760650625663f3b08f24bc75762ec843ca7e112/.vimrc
nnoremap [unite]u  :<C-u>Unite -no-split<Space>
nnoremap <silent> [unite]f :<C-u>Unite<Space>buffer<CR>
nnoremap <silent> [unite]b :<C-u>Unite<Space>bookmark<CR>
"ブックマークに追加
nnoremap <silent> [unite]a :<C-u>UniteBookmarkAdd<CR>
nnoremap <silent> [unite]m :<C-u>Unite<Space>file_mru<CR>
nnoremap <silent> [unite]r :<C-u>UniteWithBufferDir file<CR>
nnoremap <silent> ,vr :UniteResume<CR>
" unite-build map
nnoremap <silent> ,vb :Unite build<CR>
nnoremap <silent> ,vcb :Unite build:!<CR>
nnoremap <silent> ,vch :UniteBuildClearHighlight<CR>
"" }}}
" コメントアウト
noremap <C-c><C-c> :TComment<CR>
" Tagbar
nmap <F8> :TagbarToggle<CR>
" Vaffle
nmap <F7> :Vaffle<CR>
" Markdown
noremap <C-m> :PrevimOpen<CR>
" Gita status
noremap <C-g><C-s> :Gita status<CR>
" Gita diff
noremap <C-g><C-d> :Gita diff-ls HEAD<CR>

" ###############
"  INSERT mode
" ###############
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" キー移動
inoremap <c-a> <home>
inoremap <c-e> <end>
inoremap <c-j> <down>
inoremap <c-k> <up>
inoremap <c-h> <left>
inoremap <c-l> <right>
inoremap <silent> <C-f> <S-Right>
inoremap <silent> <C-b> <S-Left>
inoremap <silent> <c-d> <c-g>u<Del>
inoremap <silent> <c-g> <c-g>u<BS>
inoremap <silent> jj <Esc>
" コメントアウト
inoremap <C-c><C-c> <Esc>:TComment<CR><Insert>


" ###############
"  VISUAL mode
" ###############

