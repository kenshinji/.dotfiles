scriptencoding utf-8
set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()

Plugin 'gmarik/vundle'
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'kchmck/vim-coffee-script'
Plugin 'bling/vim-airline'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-jdaddy'
Plugin 'Valloric/YouCompleteMe'
Plugin 'mileszs/ack.vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'elixir-lang/vim-elixir'
call vundle#end()            " required
filetype plugin indent on

set spell
let spell_auto_type="all"

au BufRead,BufNewFile *.hamlc set ft=haml
autocmd FileType elixir set nospell

se t_Co=256
syntax enable
"set colorcolumn=80
let g:NERDTreeDirArrows=0

set background=light
colorscheme solarized

"
" MISC SETTINGS
"
set hlsearch
set smartcase
set ttyfast
set lazyredraw
" allow unsaved background buffers and remember marks/undo for them
set hidden
"set cursorline
set laststatus=2
set mouse=a
set winwidth=80
" no junk in filesystem
set nobackup
set nowritebackup
set noswapfile
" always show tabs
"set showtabline=2
set autoindent
set tabstop=2
" number of spaces to autoindent
set shiftwidth=2
" convert tabs to spaces
set expandtab
" show trailing whitespace
set list listchars=trail:-,tab:>-
set backspace=2

let ctrlp_filter_greps = "".
    \ "egrep -iv '\\.(" .
    \ "jar|class|swp|swo|log|so|o|pyc|jpe?g|png|gif|mo|po" .
    \ ")$' | " .
    \ "egrep -v '^(\\./)?(" .
    \ ".git/|.hg/|.svn/" .
    \ ")'"

let my_ctrlp_git_command = "" .
    \ "cd %s && git ls-files | " .
    \ ctrlp_filter_greps

if has("unix")
    let my_ctrlp_user_command = "" .
    \ "find %s '(' -type f -or -type l ')' -maxdepth 15 -not -path '*/\\.*/*' | " .
    \ ctrlp_filter_greps
endif

let g:ctrlp_user_command = ['.git/', my_ctrlp_git_command, my_ctrlp_user_command]

" Jump to last cursor position unless it's invalid or in an event handler
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal g`\"" |
  \ endif

" Delete trailing whitespace on save
autocmd BufWritePre * :%s/\s\+$//e

"
" SHORTCUTS
"
let mapleader=","
nnoremap <leader>v :vsp<cr>
nnoremap <leader>h :sp<cr>
nnoremap <Tab> :tabnext<cr>

" Run hotkeys
function RunWith (command)
  execute "w"
  execute "!clear;time " . a:command . " " . expand("%")
endfunction

function! RSpecCurrent()
  execute("!clear && bundle exec rspec " . expand("%p") . ":" . line(".") . " --color")
endfunction

autocmd FileType coffee   nmap <f5> :call RunWith("coffee")<cr>
autocmd FileType ruby     nmap <f5> :call RunWith("ruby")<cr>
autocmd FileType clojure  nmap <f5> :call RunWith("clj")<cr>
autocmd BufRead *.js      nmap <f6> :w\|!clear && jslint %<cr>
autocmd BufRead *_spec.rb nmap <f6> :w\|!clear && bundle exec rspec % --format documentation --color<cr>
autocmd BufRead *_spec.rb nmap <f7> :call RSpecCurrent()<CR>

" do not press shift to enter command
map ; :
" swap words
nnoremap <silent> gw "_yiw:s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR><c-o><c-l>
map <c-c> <esc>
map <c-f> :Ack <C-R><C-W> --%:e
nnoremap <cr> :nohlsearch<cr>
map <C-t> :NERDTreeToggle<cr>
:command W w
:command Te tabedit

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RENAME CURRENT FILE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction
map <leader>n :call RenameFile()<cr>
