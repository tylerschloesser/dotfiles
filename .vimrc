set nocompatible              " be iMproved, required
filetype off                  " required

" load vim-plug
if empty(glob("~/.vim/autoload/plug.vim"))
    execute '!curl -fLo ~/.vim/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim'
endif

call plug#begin('~/.vim/plugged')
  Plug 'Valloric/YouCompleteMe'
call plug#end()


" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

"Bundle 'Valloric/YouCompleteMe'
Bundle 'Valloric/ListToggle'
Bundle 'scrooloose/syntastic'

Bundle 'scrooloose/nerdtree'
Bundle 'Xuyuanp/nerdtree-git-plugin'

" https://github.com/justinmk/vim-sneak
Plugin 'justinmk/vim-sneak'

Plugin 'https://github.com/kien/ctrlp.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-git'
Plugin 'tpope/vim-abolish'

" https://github.com/jiangmiao/auto-pairs
Plugin 'jiangmiao/auto-pairs'

"" plugin from http://vim-scripts.org/vim/scripts.html
"Plugin 'L9'
"" Git plugin not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_collect_identifiers_from_tags_files = 1

set background=dark

" if has("gui_running")
"
"     " set default window size
"     set lines=50
"     set columns=100
"
"     if has("gui_gtk2")
"         set guifont=Inconsolata\ 12
"     elseif has("gui_win32")
"         set guifont=Consolas:h11:cANSI
"     endif
"
"     colorscheme solarized
"
"     " gvim remove menu bar, toolbar, and scroll bar
"     set guioptions-=m
"     set guioptions-=T
"     set guioptions-=r
"
"    set guiheadroom=0
" endif

" keep temp and backup files in one place
if has("unix")
    set backup
    set backupdir=~/.vim/backup
    set directory=~/.vim/tmp
elseif hostname() == "TYLER-PC"
    set backup
    set backupdir=D:\Tyler\.vim\backup
    set directory=D:\Tyler\.vim\tmp
endif

syntax enable
set bs=2

" replace tabs with spaces
set expandtab
set smarttab
set tabstop=4
set shiftwidth=4

autocmd Filetype ruby setlocal ts=2 sts=2 sw=2

set autoindent



" This shows what you are typing as a command
set showcmd

" show the cursors current position with line+column and percentage of buffer
" better than having to use CTRL+G
set ruler

" disable those annoying beeps....
set noerrorbells visualbell t_vb=
au GUIEnter * set visualbell t_vb=

set backspace=2

" show line numbers
set number
set relativenumber

" ignore case for lower case words
set ignorecase
set smartcase

set incsearch
set hlsearch

"set autochdir

" Mappings
" Next Tab
nnoremap <silent> <C-Right> :tabnext<CR>
" Previous Tab
nnoremap <silent> <C-Left> :tabprevious<CR>
" New Tab
nnoremap <silent> <C-t> :tabnew<CR>

nnoremap <silent> <A-h> :tabprevious<CR>
nnoremap <silent> <A-l> :tabnext<CR>

" move down one visual line, rather than actual line (for wrapping)
"nnoremap <silent> k gk
"nnoremap <silent> j gj

" Create Blank Newlines and stay in Normal mode
nnoremap <silent> zj o<Esc>
nnoremap <silent> zk O<Esc>

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
map N Nzz
map n nzz

" Swap ; and :
nnoremap ; :
nnoremap : ;

" Insert empty line.
nmap <A-o> o<ESC>k
nmap <A-O> O<ESC>j

" Control l unhighlights
nnoremap <silent> <C-l> :nohl<CR><C-l>

" on entering insert mode, disable relative line numbers
set timeoutlen=1000 ttimeoutlen=-1
highlight LineNr ctermfg=darkyellow
set noesckeys


if has("unix")
    "let s:user = substitute(system("whoami"), '\n', '', '')
"if hostname() == "TYLER-UBUNTU" || s:user == "schlo161"
    " fix for VM and school computers
    autocmd InsertEnter * :set nornu | set nu
    autocmd InsertLeave * :set nu | set rnu
else
    autocmd InsertEnter * :set nornu
    autocmd InsertLeave * :set rnu
endif

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
