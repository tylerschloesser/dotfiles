set nocompatible

" load vim-plug if it doesn't exist
if empty(glob("~/.vim/autoload/plug.vim"))
  execute '!curl -fLo ~/.vim/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim'
endif

" https://github.com/prettier/vim-prettier
let g:prettier#autoformat = 1
let g:prettier#autoformat_require_pragma = 0

let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_collect_identifiers_from_tags_files = 1

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
if exists("g:ctrl_user_command")
  unlet g:ctrlp_user_command
endif
set wildignore+=*/eclipse-bin/*
set wildignore+=*/bin/*
" https://github.com/kien/ctrlp.vim/issues/490
let g:ctrlp_clear_cache_on_exit = 0
"let g:ctrlp_working_path_mode=''

nnoremap <Leader>m :CtrlPMRU<CR>
nnoremap <Leader>b :CtrlPBuffer<CR>


let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1

" only show filename of buffer
let g:airline#extensions#tabline#fnamemod = ':t'

set t_Co=256


" load plugins
call plug#begin('~/.vim/plugged')

  Plug 'neoclide/jsonc.vim'

  Plug 'plasticboy/vim-markdown'

  Plug 'prettier/vim-prettier'
  Plug 'jparise/vim-graphql'

  Plug 'Valloric/YouCompleteMe'

  " toggle quickfix list and location-list
  Plug 'Valloric/ListToggle'

  " better medium-distance motion
  Plug 'justinmk/vim-sneak'

  " ctrlp
  Plug 'ctrlpvim/ctrlp.vim'

  " git wrapper
  Plug 'tpope/vim-fugitive'

  " search/substitute multiple variants of a word
  Plug 'tpope/vim-abolish'

  " insert/delete brackets, parens and quotes in pair
  Plug 'jiangmiao/auto-pairs'

  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'

  " javascript/jsx syntax highlighting
  Plug 'pangloss/vim-javascript'
  Plug 'MaxMEllon/vim-jsx-pretty'

  " highlight matching html/xml tags
  Plug 'Valloric/MatchTagAlways'

  " auto close html tag
  Plug 'alvan/vim-closetag'

  "Plug 'chriskempson/base16-vim'
  Plug 'altercation/vim-colors-solarized'

  " nerdtree
  Plug 'https://github.com/scrooloose/nerdtree.git'

  " EditorConfig
  Plug 'editorconfig/editorconfig-vim'

  " Plug 'mtscout6/syntastic-local-eslint.vim'

  Plug 'tpope/vim-jdaddy'

  Plug 'https://github.com/vim-scripts/restore_view.vim'

  Plug 'leafgarland/typescript-vim'
  Plug 'peitalin/vim-jsx-typescript'

  Plug 'vim-scripts/confirm-quit'

call plug#end()


augroup main
  autocmd!

  autocmd InsertEnter * :set norelativenumber
  autocmd InsertLeave * :set relativenumber

  autocmd BufWritePost $MYVIMRC :source $MYVIMRC

  autocmd WinEnter * set cursorline
  autocmd WinLeave * set nocursorline

  " https://github.com/neoclide/coc-json/issues/11#issuecomment-535262331
  autocmd BufRead,BufNewFile tsconfig.json set filetype=jsonc
augroup END

set viewoptions=cursor,folds,slash,unix
" let g:skipview_files = ['*\.vim']

" backup options
set backup
set backupdir=~/.vim/backup
set directory=~/.vim/tmp

" enable syntax highlighting
syntax on

" backspace behavior
set backspace=indent,eol,start

" tab behavior
set expandtab
set smarttab
set autoindent

" default 2 spaces for tabs
set tabstop=2
set softtabstop=2
set shiftwidth=2

" show command in last line of screen
set showcmd

" show line numbers
set number
set relativenumber

" no line wrapping
"set nowrap

" ignore case for lower case words
set ignorecase
set smartcase

" customize search
set incsearch
set hlsearch

" create newlines while staying in normal mode
nnoremap <silent> zj o<Esc>
nnoremap <silent> zk O<Esc>

" center current result while moving through search results
map N Nzz
map n nzz

" swap ; and :
nnoremap ; :
nnoremap : ;

" ctrl+l removes highlight(s)
nnoremap <silent> <C-l> :nohl<CR><C-l>

" disable relative line numbers in insert mode
set timeoutlen=500
highlight LineNr ctermfg=darkyellow

" don't add multiple spaces after eol punctuation
set nojoinspaces

set foldmethod=manual

function! FileSize()
    let bytes = getfsize(expand("%:p"))
    if bytes <= 0
        return ""
    endif
    if bytes < 1024
        return bytes . "B"
    endif
    let bytes = bytes / 1024
    if bytes < 1024
        return bytes . "KiB"
    endi
    let bytes = bytes / 1024
    return bytes . "MiB"
endfunction

set laststatus=2

set statusline=%f " Path to the file in the buffer, as typed or relative to current directory.
set statusline+=\ [%{strlen(&fenc)?&fenc:'none'}, " file encoding
set statusline+=%{&ff}] " file format
set statusline+=\ %h%m%r " help file, modified, and read only flags
set statusline+=%y " filetype
set statusline+=%{fugitive#statusline()}\  " git branch
set statusline+=%= " left/right separator
set statusline+=0x%B
set statusline+=\ col:%c " cursor column
set statusline+=\ line:%l/%L " cursor line/ total lines
set statusline+=\ %{FileSize()}
set statusline+=\ %P " precent through file

highlight Pmenu ctermbg=grey gui=bold
highlight PmenuSel ctermbg=red gui=bold

set tags=./tags,tags;/

" whitespace
match ErrorMsg '\s\+$'
nnoremap <Leader>rtw :%s/\s\+$//e<CR>

" http://stackoverflow.com/questions/14635295/vim-takes-a-very-long-time-to-start-up
set clipboard=exclude:.*

" Search for selected text, forwards or backwards.
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>

" eclim
filetype plugin indent on

let g:C_Ctrl_j = 'off'

set modeline

" ===========================================================================================
" ===========================================================================================
" KEY BINDINGS
" ===========================================================================================
" ===========================================================================================
"
let mapleader=" "

" double excape saves
map <Esc><Esc> ;w<CR>

" git (fugative.vim)
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gb :Gblame<CR>
nnoremap <leader>gc :Gcommit<CR>
nnoremap <leader>gd :Gdiff<CR>

function! GetVisualSelection()
  " Why is this not a built-in Vim script function?!
  let [lnum1, col1] = getpos("'<")[1:2]
  let [lnum2, col2] = getpos("'>")[1:2]
  let lines = getline(lnum1, lnum2)
  let lines[-1] = lines[-1][: col2 - (&selection == 'inclusive' ? 1 : 2)]
  let lines[0] = lines[0][col1 - 1:]
  return join(lines, "\n")
endfunction

nnoremap <Leader>ev :vs $MYVIMRC<CR>

nnoremap <Leader>n :NERDTreeToggle<CR>
let g:NERDTreeWinPos = "right"

" fix slow syntax highlighting in ruby files
set re=1
set ttyfast
set lazyredraw

" highlight matching html elements in JSX
let g:mta_filetypes = {
        \ 'html' : 1,
        \ 'xhtml' : 1,
        \ 'xml' : 1,
        \ 'jinja' : 1,
        \ 'javascript.jsx' : 1,
        \}

nnoremap <leader>% :MtaJumpToOtherTag<cr>

let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|\.git\|my-first-app\/ios\|bin'

"https://github.com/kien/ctrlp.vim/issues/234
let g:ctrlp_max_files=0
let g:ctrlp_max_depth=40

"https://shapeshed.com/vim-netrw/
"
let g:netrw_liststyle = 3
let g:netrw_winsize = 25

nnoremap <leader>a :YcmCompleter GoToDefinition<CR>
nnoremap <leader>o :YcmCompleter OrganizeImports<CR>
