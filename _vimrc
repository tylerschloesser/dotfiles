set nocompatible

" load vim-plug if it doesn't exist
if empty(glob("~/.vim/autoload/plug.vim"))
  execute '!curl -fLo ~/.vim/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim'
endif

" load plugins
call plug#begin('~/.vim/plugged')

  Plug 'jparise/vim-graphql'

  " code-completion engine - requires installed component
  " https://github.com/Valloric/YouCompleteMe#installation
  Plug 'Valloric/YouCompleteMe'
  let g:ycm_seed_identifiers_with_syntax = 1
  let g:ycm_collect_identifiers_from_tags_files = 1

  " toggle quickfix list and location-list
  Plug 'Valloric/ListToggle'

  " syntax checking
  " Plug 'scrooloose/syntastic'
  " "set statusline+=%#warningmsg#
  " "set statusline+=%{SyntasticStatuslineFlag()}
  " "set statusline+=%*
  " let g:syntastic_always_populate_loc_list = 1
  " let g:syntastic_auto_loc_list = 1
  " let g:syntastic_check_on_open = 1
  " let g:syntastic_check_on_wq = 0

  " better medium-distance motion
  Plug 'justinmk/vim-sneak'

  " ctrlp
  Plug 'ctrlpvim/ctrlp.vim'
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

  " git wrapper
  Plug 'tpope/vim-fugitive'

  " search/substitute multiple variants of a word
  Plug 'tpope/vim-abolish'

  " insert/delete brackets, parens and quotes in pair
  Plug 'jiangmiao/auto-pairs'

  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  let g:airline#extensions#tabline#enabled = 1
  let g:airline_powerline_fonts = 1
  "let g:airline#extensions#tabline#buffer_idx_mode = 1
  let g:airline#extensions#tabline#buffer_nr_show = 1
  set t_Co=256

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

  " jekyll syntax
  Plug 'https://github.com/PProvost/vim-markdown-jekyll'

  " EditorConfig
  Plug 'editorconfig/editorconfig-vim'

  " Plug 'mtscout6/syntastic-local-eslint.vim'

  Plug 'tpope/vim-jdaddy'

  Plug 'https://github.com/vim-scripts/restore_view.vim'

  Plug 'leafgarland/typescript-vim'
  Plug 'peitalin/vim-jsx-typescript'

call plug#end()

"augroup SyntaxSettings
"    autocmd!
"    autocmd BufNewFile,BufRead *.tsx set filetype=typescript
"augroup END

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

" override vim-markdown-jekyll setting sw and ts to 3
autocmd FileType markdown setlocal shiftwidth=2 tabstop=2
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2

" 4 space tabs for java
"autocmd FileType java setlocal tabstop=4 shiftwidth=4

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

nnoremap <Leader>n :NERDTreeToggle<CR>
let g:NERDTreeWinPos = "right"


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

"let g:EclimLoggingDisabled = 1

" fix slow syntax highlighting in ruby files
set re=1
set ttyfast
set lazyredraw

" highlight matching html elements in JSX
"let g:mta_filetypes['javascript.jsx'] = 1
let g:mta_filetypes = {
        \ 'html' : 1,
        \ 'xhtml' : 1,
        \ 'xml' : 1,
        \ 'jinja' : 1,
        \ 'javascript.jsx' : 1,
        \}

nnoremap <leader>% :MtaJumpToOtherTag<cr>

"hi Tag        ctermfg=04
"hi xmlTag     ctermfg=04
"hi xmlTagName ctermfg=04
"hi xmlEndTag  ctermfg=04

"colorscheme base16-default-dark
"syntax enable
"set background=dark
"let g:solarized_visibility = "high"
"let g:solarized_contrast = "high"
"colorscheme solarized
"let g:solarized_termcolors=16

let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|\.git\|my-first-app\/ios'

"https://github.com/kien/ctrlp.vim/issues/234
let g:ctrlp_max_files=0
let g:ctrlp_max_depth=40

au BufNewFile,BufRead *.ejs set filetype=html

"https://shapeshed.com/vim-netrw/
"
let g:netrw_liststyle = 3
let g:netrw_winsize = 25

nnoremap <Leader>jq :%!jq .<CR>

function! Wipeout()
  " list of *all* buffer numbers
  let l:buffers = range(1, bufnr('$'))

  " what tab page are we in?
  let l:currentTab = tabpagenr()
  try
    " go through all tab pages
    let l:tab = 0
    while l:tab < tabpagenr('$')
      let l:tab += 1

      " go through all windows
      let l:win = 0
      while l:win < winnr('$')
        let l:win += 1
        " whatever buffer is in this window in this tab, remove it from
        " l:buffers list
        let l:thisbuf = winbufnr(l:win)
        call remove(l:buffers, index(l:buffers, l:thisbuf))
      endwhile
    endwhile

    " if there are any buffers left, delete them
    if len(l:buffers)
      execute 'bwipeout' join(l:buffers)
    endif
  finally
    " go back to our original tab page
    execute 'tabnext' l:currentTab
  endtry
endfunction

set pastetoggle=<Leader>p

" allow mouse to resize
" https://vi.stackexchange.com/a/521
" set mouse=n
" set ttymouse=xterm2

nnoremap <leader>a :YcmCompleter GoToDefinition<CR>
" nnoremap <leader>d :YcmCompleter GetDoc<CR>
