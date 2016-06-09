" filetype plugin on
call plug#begin('~/.vim/neoplugged')

Plug 'editorconfig/editorconfig-vim'
Plug 'tomtom/tcomment_vim'
Plug 'alisnic/vim-open-alternate'
Plug 'godlygeek/tabular'
Plug 'tpope/vim-endwise'
Plug 'haya14busa/incsearch.vim'
Plug 'rhysd/devdocs.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'qpkorr/vim-bufkill'
Plug 'tpope/vim-fugitive'

Plug 'xiaogaozi/easy-gitlab.vim'
  let g:easy_gitlab_url = 'https://git.saltedge.com'

Plug 'scrooloose/nerdtree'
  autocmd FileType nerdtree nmap <buffer> <left> x
  autocmd FileType nerdtree nmap <buffer> <right> <cr>
  let NERDTreeShowHidden=1

Plug 'terryma/vim-expand-region'
  let g:expand_region_text_objects = {
        \ 't.'  :1,
        \ 'iw'  :0,
        \ 'iW'  :0,
        \ 'i"'  :0,
        \ 'i''' :0,
        \ 'i]'  :1,
        \ 'ib'  :1,
        \ 'iB'  :1,
        \ 'il'  :0,
        \ 'ip'  :0,
        \ 'ie'  :0,
        \ }

" Lang support
Plug 'vim-ruby/vim-ruby'
Plug 'elixir-lang/vim-elixir'
Plug 'tpope/vim-haml'
Plug 'kchmck/vim-coffee-script'
Plug 'pangloss/vim-javascript'
Plug 'elzr/vim-json'
  let g:vim_json_syntax_conceal = 0

Plug 'FelikZ/ctrlp-py-matcher'
Plug 'kien/ctrlp.vim'
  let g:ctrlp_show_hidden = 1
  let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }
  let g:ctrlp_prompt_mappings = {
        \ 'AcceptSelection("e")': ['<c-t>'],
        \ 'AcceptSelection("t")': ['<cr>', '<2-LeftMouse>'],
        \ }

  let g:ctrlp_clear_cache_on_exit=1
  if executable('ag')
    let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
  endif

Plug 'ternjs/tern_for_vim', { 'do': 'npm install' }
Plug 'Valloric/YouCompleteMe', {'do': 'python install.py --tern-completer'}
  let g:ycm_collect_identifiers_from_tags_files = 1
  let g:ycm_min_num_of_chars_for_completion = 3
  let g:ycm_collect_identifiers_from_comments_and_strings = 1
  let g:ycm_seed_identifiers_with_syntax = 1

Plug 'mileszs/ack.vim'
  let g:ackpreview = 1
  if executable('ag')
    let g:ackprg = 'ag --vimgrep'
  endif

Plug 'altercation/vim-colors-solarized'
Plug 'sickill/vim-monokai'
call plug#end()

" Delete trailing spaces on save
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
  \| exe "normal! g'\"" | endif
autocmd BufWritePre * :%s/\s\+$//e

" se t_Co=256
syntax enable
filetype plugin indent on
set background=light
colorscheme solarized

set mouse=a
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
set list listchars=trail:-,tab:>-
set tags=.git/tags
set backspace=indent,eol,start
set enc=utf-8
set clipboard+=unnamedplus
set cul
set completeopt-=preview
set shell=bash

" Filesystem
set nobackup
set nowritebackup
set noswapfile

" Indent
set tabstop=2
set expandtab
set shiftwidth=2

" Search
set hlsearch
set incsearch
set ignorecase
set smartcase

" Per-project vimrcs
set exrc   " enable per-directory .vimrc files
set secure " disable unsafe commands in local .vimrc files
set colorcolumn=80

" Status line
set noshowmode
set noruler
set noshowcmd
set laststatus=0

" Undo
set undofile
set undodir=$HOME/.vim/undo

let mapleader = "\<Space>"
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

cabbrev te tabedit
cabbrev qq tabclose
cabbrev help tab help
cabbrev doc DevDocs
cabbrev qt tabclose

map <esc><esc> :nohlsearch<cr>
map <C-t> :NERDTreeToggle<cr>
map / <Plug>(incsearch-forward)
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)
" I don't use macros
nmap q b
nmap ; :
nmap § ``
nmap <Tab> gt
nmap <S-Tab> gT
nnoremap <S-UP> <NOP>
nnoremap <S-Down> <NOP>
vnoremap <S-UP> <NOP>
vnoremap <S-Down> <NOP>
nnoremap <BS> :e#<cr>
tnoremap <space> <C-\><C-n>:BW<cr>

" map paste, yank and delete to named register so the content
" will not be overwritten
nnoremap d "xd
vnoremap d "xd
nnoremap D "xD
vnoremap D "xD
nnoremap y "xy
vnoremap y "xy
nnoremap p "xp
vnoremap p "xp
nnoremap P "xP
vnoremap P "xP

nmap <leader>t :CtrlP<cr>
nmap <leader>a ggVG<cr>
nmap <leader>d <C-w><C-]><C-w>T
vmap <leader>d <C-w><C-]><C-w>T
nmap <leader>D g]
vmap <leader>D g]
nmap <leader>/ :TComment<cr>
vmap <leader>/ gc
nmap <leader>r :NERDTreeFind<cr>
nmap <leader>u :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <leader>ln :setlocal nu!<cr>

function! s:MagicSplit()
  let l:width=winwidth(0)
  if (l:width > 160)
    :exec "botright vsplit " . GetAlternatePath()
  else
    :exec "tab drop " . GetAlternatePath()
  endif
endfunction
command! SplitAlternate call s:MagicSplit()
nnoremap <leader><leader> :SplitAlternate<cr>

function! GetSpecPath()
  if match(expand("%"), "spec") != -1
    return expand("%")
  else
    return GetAlternatePath()
  endif
endfunction

function! SearchInFiles()
  let query = input('Search in files: ')
  if len(query) == 0
    return
  endif
  exec ":tabedit | Ack " . query
endfunction
nmap <leader>s :call SearchInFiles()<cr>