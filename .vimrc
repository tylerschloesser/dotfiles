" disable vi compatibility
set nocompatible

" load vim-plug if it doesn't exist
if empty(glob("~/.vim/autoload/plug.vim"))
  execute '!curl -fLo ~/.vim/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim'
endif

" load plugins
call plug#begin('~/.vim/plugged')

  " code-completion engine - requires installed component
  " https://github.com/Valloric/YouCompleteMe#installation
  Plug 'Valloric/YouCompleteMe'
  let g:ycm_seed_identifiers_with_syntax = 1
  let g:ycm_collect_identifiers_from_tags_files = 1

  " toggle quickfix list and location-list
  Plug 'Valloric/ListToggle'

  " syntax checking
  Plug 'scrooloose/syntastic'
  set statusline+=%#warningmsg#
  set statusline+=%{SyntasticStatuslineFlag()}
  set statusline+=%*
  let g:syntastic_always_populate_loc_list = 1
  let g:syntastic_auto_loc_list = 1
  let g:syntastic_check_on_open = 1
  let g:syntastic_check_on_wq = 0

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

call plug#end()

" backup options
set backup
set backupdir=~/.vim/backup

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
set nowrap

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

autocmd InsertEnter * :set nornu
autocmd InsertLeave * :set rnu

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

autocmd BufRead,BufNewFile *.js.jspf set filetype=javascript
autocmd BufRead,BufNewFile *.js.jsp set filetype=javascript

" CtrlP stuff
set runtimepath^=~/.vim/bundle/ctrlp.vim
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
if exists("g:ctrl_user_command")
    unlet g:ctrlp_user_command
endif
set wildignore+=*/eclipse-bin/*
set wildignore+=*/bin/*

let g:SuperTabDefaultCompletionType = "<c-n>"

highlight Pmenu ctermbg=grey gui=bold
highlight PmenuSel ctermbg=red gui=bold

let g:acp_enableAtStartup = 0
let g:neocomplete#enable_at_startup = 1

" https://github.com/kien/ctrlp.vim/issues/490
let g:ctrlp_clear_cache_on_exit = 0

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

"function! SetJavaTagFile()
"    let root = system('git rev-parse --show-toplevel')[:-2]
"    echom 'heyroot=' . root
"    echom v:shell_error
"    if !v:shell_error
"        let tagfile = root . '/.tags'
"        echom tagfile
"        if (filereadable(tagfile))
"        endif
"    endif
"endfunction
"
"augroup javatags
"    autocmd! BufEnter *.java :call SetJavaTagFile()
"augroup END
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

" http://eclim.org/vim/java/index.html
" ftplugin is not working ...... :/
"
" Import the class under the cursor with <leader>i (:h mapleader):
"nnoremap <silent> <buffer> <leader>ic :JavaImport<cr>
"" Search for the javadocs of the element under the cursor with <leader>d.
"nnoremap <silent> <buffer> <leader>d :JavaDocSearch -x declarations<cr>
"" Perform a context sensitive search of the element under the cursor with <enter>.
"nnoremap <silent> <buffer> <cr> :JavaSearchContext<cr>
"
"nnoremap <silent> <buffer> <leader>ia :JavaImportOrganize<cr>


let g:EclimCompletionMethod = 'omnifunc'

" load nerdtree on startup
" autocmd vimenter * NERDTree

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

let g:C_Ctrl_j = 'off'
"nnoremap <C-j>I :JavaImportOrganize<CR>
"nnoremap <C-j>i :JavaImport<CR>
"nnoremap <C-j>c :JavaCorrect<CR>
"nnoremap <C-j>d :JavaDocPreview<CR>

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
nnoremap <leader>gb :Glbame<CR>
nnoremap <leader>gc :Gcommit<CR>
nnoremap <leader>gd :Gdiff<CR>

let g:NERDTreeWinSize = 40
nnoremap <leader>nf :NERDTreeFind<cr>
nnoremap <leader>nt :NERDTreeToggle<cr>
"nnoremap <c-n> :NERDTreeToggle<CR>


function! GetVisualSelection()
  " Why is this not a built-in Vim script function?!
  let [lnum1, col1] = getpos("'<")[1:2]
  let [lnum2, col2] = getpos("'>")[1:2]
  let lines = getline(lnum1, lnum2)
  let lines[-1] = lines[-1][: col2 - (&selection == 'inclusive' ? 1 : 2)]
  let lines[0] = lines[0][col1 - 1:]
  return join(lines, "\n")
endfunction

"function! Get

nnoremap <leader>jo :JavaImportOrganize<CR>
nnoremap <leader>ji :JavaImport<CR>
nnoremap <leader>jc :JavaCorrect<CR>
nnoremap <leader>jd :JavaDocPreview<CR>
nnoremap <leader>jnc :JavaNew class
nnoremap <leader>jr :JavaRename
nnoremap <leader>jm :JavaMove
" http://eclim.org/vim/java/search.html#element-search
nnoremap <leader>jsc :JavaSearchContext -a vsplit<cr>
nnoremap <leader>juc :JUnit %<cr>

vnoremap <leader>jr :<c-u>JavaRename <c-r>=GetVisualSelection()<cr>

vnoremap <leader>jsc :JavaSearchContext<CR>

nnoremap <Leader>ev :tabnew<CR>:e $MYVIMRC<CR>

if has ('autocmd') " Remain compatible with earlier versions
 augroup vimrc     " Source vim configuration upon save
    autocmd! BufWritePost $MYVIMRC source % | echom "Reloaded " . $MYVIMRC | redraw
    autocmd! BufWritePost $MYGVIMRC if has('gui_running') | so % | echom "Reloaded " . $MYGVIMRC | endif | redraw
  augroup END
endif " has autocmd


augroup BgHighlight
    autocmd!
    autocmd WinEnter * set cul
    autocmd WinLeave * set nocul
augroup END

let g:EclimLoggingDisabled = 1

" fix slow syntax highlighting in ruby files
set re=1
set ttyfast
set lazyredraw
