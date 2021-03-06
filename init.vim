let mapleader = ","      " 定义<leader>键
set nocompatible         " 设置不兼容原始vi模式
filetype on              " 设置开启文件类型侦测
filetype plugin on       " 设置加载对应文件类型的插件
set noeb                 " 关闭错误的提示
syntax enable            " 开启语法高亮功能
syntax on                " 自动语法高亮
set t_Co=256             " 开启256色支持
set cmdheight=1          " 设置命令行的高度
set showcmd              " select模式下显示选中的行数
set ruler                " 总是显示光标位置
set laststatus=2         " 总是显示状态栏
set number               " 开启行号显示
set cursorline           " 高亮显示当前行
set whichwrap+=<,>,h,l   " 设置光标键跨行
set ttimeoutlen=0        " 设置<ESC>键响应时间
set virtualedit=block,onemore   " 允许光标出现在最后一个字符的后面
set relativenumber       " 设置相对行号
set tabstop=2            " 设置制表符为2个空格
set shiftwidth=2
set softtabstop=-1
set expandtab
colorscheme desert
set clipboard^=unnamed,unnamedplus

call plug#begin('~/.vim/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}

" ranger
Plug 'kevinhwang91/rnvimr'

" go支持
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }

" 快速注释
Plug 'tomtom/tcomment_vim'

" fzf模糊查找
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim', { 'do': { -> fzf#install() } }
Plug 'yuki-yano/fzf-preview.vim', { 'branch': 'release/rpc' }

" markdown
Plug 'instant-markdown/vim-instant-markdown', {'for': 'markdown'}

call plug#end()



" 复制当前选中到系统剪切板
vmap <leader><leader>y "+y

" 将系统剪切板内容粘贴到vim
nnoremap <leader><leader>p "+p

" 编辑vimrc相关配置文件
nnoremap <leader>e :edit $MYVIMRC<cr>

" 重新加载vimrc文件
nnoremap <leader>s :source $MYVIMRC<cr>

" ===
" === Insert Mode Cursor Movement
" ===
inoremap <C-a> <ESC>A



"=============coc==============
let g:coc_global_extensions = [
  \ 'coc-diagnostic',
  \ 'coc-explorer',
  \ 'coc-json',
  \ 'coc-lists',
  \ 'coc-marketplace',
  \ 'coc-pyright',
  \ 'coc-syntax',
  \ 'coc-highlight',
  \ 'coc-yank',
  \ 'coc-go', ]




set hidden
set updatetime=100
set shortmess+=c

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
"inoremap <silent><expr> <TAB>
"      \ pumvisible() ? "\<C-n>" :
"      \ <SID>check_back_space() ? "\<TAB>" :
"      \ coc#refresh()
"inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-@> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `<leader>-` and `<leader>=` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> <leader>- <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>= <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use <leader>h to show documentation in preview window.
nnoremap <silent> <leader>h :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)


" Configuration custom vim mapping
nmap ee :CocCommand explorer<CR>

"==============end coc===========


"===========buffers===========
nnoremap <silent> bl :ls<CR>
nnoremap <silent> bu :enew<CR>
nnoremap <silent> bn :bnext<CR>
nnoremap <silent> bp :bprevious<CR>
nnoremap <silent> bd :bdelete<CR>

"===========end buffers

" Save & quit
noremap Q :q<CR>
noremap <C-q> :qa<CR>
noremap <C-s> :w<CR>

"==={<CR>}
inoremap {{ {<CR>}<UP><ESC>o

" ===
" === rnvimr
" ===
"highlight link RnvimrNormal CursorLine
nnoremap <silent> R :RnvimrToggle<CR><C-\><C-n>:RnvimrResize 0<CR>
let g:rnvimr_action = {
            \ '<C-t>': 'NvimEdit tabedit',
            \ '<C-x>': 'NvimEdit split',
            \ '<C-v>': 'NvimEdit vsplit',
            \ 'gw': 'JumpNvimCwd',
            \ 'yw': 'EmitRangerCwd'
            \ }

"=======vim-go=============
let g:go_fmt_command = "goimports"
nnoremap <leader>g :GoImports<CR>
let g:go_debug_mappings = {
   \ '(go-debug-continue)':   {'key': '<F5>'},
   \ '(go-debug-print)':      {'key': '<F6>'},
   \ '(go-debug-breakpoint)': {'key': '<F9>'},
   \ '(go-debug-next)':       {'key': '<F10>'},
   \ '(go-debug-step)':       {'key': '<F11>'},
   \ '(go-debug-halt)':       {'key': '<F8>'},
\ }
nnoremap <silent> <F9> :GoDebugBreakpoint<CR>


" ===
" === tcomment_vim
" ===
nnoremap ci cl
let g:tcomment_textobject_inlinecomment = ''
nmap <LEADER>cn g>c
vmap <LEADER>cn g>
nmap <LEADER>cu g<c
vmap <LEADER>cu g<

" ===
" === FZF
" ===
set rtp+=/usr/local/bin/fzf
set rtp+=/Users/sugar/.fzf/bin/fzf
noremap <silent> <C-p> :Files<CR>
noremap <silent> <C-f> :Rg<CR>
noremap <silent> <C-h> :History<CR>
noremap <silent> <C-b> :Buffers<CR>
noremap <leader>; :History:<CR>

let g:fzf_preview_window = 'right:60%'
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

function! s:list_buffers()
  redir => list
  silent ls
  redir END
  return split(list, "\n")
endfunction

function! s:delete_buffers(lines)
  execute 'bwipeout' join(map(a:lines, {_, line -> split(line)[0]}))
endfunction


let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.8 } }

" ===
" === vim-instant-markdown
" ===
let g:instant_markdown_slow = 0
let g:instant_markdown_autostart = 0
" let g:instant_markdown_open_to_the_world = 1
" let g:instant_markdown_allow_unsafe_content = 1
" let g:instant_markdown_allow_external_content = 0
" let g:instant_markdown_mathjax = 1
let g:instant_markdown_autoscroll = 1

nnoremap <leader>mm :InstantMarkdownPreview<cr>
nnoremap <leader>mc :InstantMarkdownStop<cr>
