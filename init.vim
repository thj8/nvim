let mapleader = ","

set nocompatible
set background=dark
syntax on
filetype off
set autochdir
set cursorline
set linespace=0
set number
set showmatch
set incsearch
set hlsearch
set ignorecase
set smartcase
set autoindent
set shiftwidth=2
set expandtab
set tabstop=2
set softtabstop=2
set cindent
set smartindent
set relativenumber


call plug#begin()
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npx --yes yarn install' }
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tomtom/tcomment_vim'        " comment
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'kdheepak/lazygit.nvim'
call plug#end()

let g:coc_global_extensions = [
  \ 'coc-explorer',
  \ 'coc-json',
  \ 'coc-go',
  \ 'coc-git',
  \ 'coc-rust-analyzer',
  \ 'coc-marketplace',
  \ 'coc-translator',
  \ 'coc-pyright', ]

" edit & source vimrc
nnoremap <leader>s :source $MYVIMRC<cr>
nnoremap <leader>ev :edit $MYVIMRC<cr>
nnoremap <leader>l :edit<cr>

set encoding=utf-8
set nobackup
set nowritebackup
set updatetime=300
set signcolumn=yes
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-@> to trigger completion
inoremap <silent><expr> <c-@> coc#refresh()

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
" nnoremap <silent> K :call ShowDocumentation()<CR>
nnoremap <C-k> :call CocAction('doHover')<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code
" xmap <leader>f  <Plug>(coc-format-selected)
" nmap <leader>f  <Plug>(coc-format-selected)
nnoremap <silent> <leader>f :call CocAction('format')<CR>
xnoremap <silent> <leader>f :<C-u>call CocAction('formatSelected')<CR>
autocmd BufWritePre *.go,*.rs,*.py call CocAction('format')



" Configuration custom vim mapping
nmap ee :CocCommand explorer<CR>

" Save & quit
noremap Q :q<CR>
noremap <C-q> :qa<CR>
noremap <C-s> :w<CR>

"==={<CR>}
inoremap {{ {<CR>}<UP><ESC>o

"===========buffers===========
nnoremap <silent> bl :ls<CR>
nnoremap <silent> bu :enew<CR>
nnoremap <silent> bn :bnext<CR>
nnoremap <silent> bp :bprevious<CR>
nnoremap <silent> bd :bdelete<CR>

" ==================== tcomment_vim ====================
nnoremap ci cl
let g:tcomment_textobject_inlinecomment = ''
nmap <LEADER>cn g>c
vmap <LEADER>cn g>
nmap <LEADER>cu g<c
vmap <LEADER>cu g<

"================= coc-translator ================
nmap <leader>t <Plug>(coc-translator-p)
vmap <leader>t <Plug>(coc-translator-pv)
nmap <leader>e <Plug>(coc-translator-e)
vmap <leader>e <Plug>(coc-translator-ev)

"================= yank ====================
vnoremap Y "+y

"================= python ====================
nmap <leader>ai <Plug>(coc-codeaction-cursor)
nmap <leader>al <Plug>(coc-codeaction-line)
nmap <leader>oi :CocCommand pyright.organizeimports<CR>


"================ fzf =====================
let g:fzf_preview_window = 'right:40%'
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'
let g:fzf_layout = { 'window': { 'width': 0.85, 'height': 0.85 } }
noremap <C-p> :FZF<CR>
noremap <C-l> :Buffers<CR>
noremap <C-f> :Ag<CR>

command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, {'options': ['--layout=reverse', '--info=inline', '--preview', 'bat {}']}, <bang>0)

"=============== colortheme================
colorscheme catppuccin
highlight Comment gui=NONE cterm=NONE


"================ terminal =================
nnoremap <leader>te :terminal<CR>i
nnoremap <leader>th :split<CR>:terminal<CR>i
nnoremap <leader>tv :vsplit<CR>:terminal<CR>i
tnoremap <Esc> <C-\><C-n>

"==================== lazygit.nvim ====================
noremap <c-g> :LazyGit<CR>
let g:lazygit_floating_window_winblend = 0 " transparency of floating window
let g:lazygit_floating_window_scaling_factor = 1.0 " scaling factor for floating window

"================= markdown =========================
" let g:mkdp_browser = '/Applications/Google Chrome.app/Contents/MacOS/Google Chrome'
autocmd FileType markdown nnoremap <buffer> <leader>m :MarkdownPreview<CR>
