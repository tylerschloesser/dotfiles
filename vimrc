set nocompatible

" load vim-plug if it doesn't exist
if empty(glob("~/.vim/autoload/plug.vim"))
  execute '!curl -fLo ~/.vim/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim'
endif


let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
if exists("g:ctrl_user_command")
  unlet g:ctrlp_user_command
endif

set t_Co=256


" load plugins
call plug#begin('~/.vim/plugged')

  Plug 'neoclide/jsonc.vim'

  Plug 'plasticboy/vim-markdown'

  " Plug 'prettier/vim-prettier'
  Plug 'jparise/vim-graphql'

  Plug 'neoclide/coc.nvim', {'branch': 'release'}

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


  " highlight matching html/xml tags
  " TODO should I install python for this?
  " Plug 'Valloric/MatchTagAlways'

  " auto close html tag
  Plug 'alvan/vim-closetag'

  " nerdtree
  " Plug 'https://github.com/scrooloose/nerdtree.git'

  " EditorConfig
  Plug 'editorconfig/editorconfig-vim'

  " Plug 'mtscout6/syntastic-local-eslint.vim'

  Plug 'tpope/vim-jdaddy'

  Plug 'https://github.com/vim-scripts/restore_view.vim'

  Plug 'pangloss/vim-javascript'
  Plug 'leafgarland/typescript-vim'
  Plug 'peitalin/vim-jsx-typescript'
  Plug 'styled-components/vim-styled-components', { 'branch': 'main'  }

  Plug 'vim-scripts/confirm-quit'

  Plug 'elixir-editors/vim-elixir'

  Plug 'kshenoy/vim-signature'
  Plug 'pantharshit00/vim-prisma'
  Plug 'tpope/vim-vinegar'
  Plug 'tikhomirov/vim-glsl'

	Plug 'othree/html5.vim'
	Plug 'pangloss/vim-javascript'
	Plug 'evanleck/vim-svelte', {'branch': 'main'}

  Plug 'easymotion/vim-easymotion'
call plug#end()

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
" https://github.com/bibstha/dotfiles-thoughtbot/blob/a31f24e8ef459c54fe94b3b99d017dd552ce9d09/vimrc#L73
"
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

let g:coc_global_extensions = [ 'coc-tsserver', 'coc-prettier', 'coc-json', 'coc-java' ]

autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescriptreact

let g:vim_markdown_folding_disabled = 1

" https://thoughtbot.com/blog/modern-typescript-and-react-development-in-vim#highlighting-for-large-files
autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear

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
nnoremap <leader>gs :Git status<CR>
nnoremap <leader>gb :Git blame<CR>
nnoremap <leader>gc :Git commit -v -a<CR>
nnoremap <leader>gd :Git diff<CR>

function! GetVisualSelection()
  " Why is this not a built-in Vim script function?!
  let [lnum1, col1] = getpos("'<")[1:2]
  let [lnum2, col2] = getpos("'>")[1:2]
  let lines = getline(lnum1, lnum2)
  let lines[-1] = lines[-1][: col2 - (&selection == 'inclusive' ? 1 : 2)]
  let lines[0] = lines[0][col1 - 1:]
  return join(lines, "\n")
endfunction

" TODO remove this? conflicts with coc
" nnoremap <Leader>ev :vs $MYVIMRC<CR>

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

" ignore .gitignore
" https://github.com/kien/ctrlp.vim/issues/174#issuecomment-215829892
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']

"https://github.com/kien/ctrlp.vim/issues/234
let g:ctrlp_max_files=0
let g:ctrlp_max_depth=40

let g:ctrlp_root_markers = ['package.json']

"https://shapeshed.com/vim-netrw/
"
let g:netrw_liststyle = 3
let g:netrw_winsize = 25

" https://github.com/neoclide/coc.nvim/issues/1775#issuecomment-757764053
let g:coc_disable_transparent_cursor = 1

" Set internal encoding of vim, not needed on neovim, since coc.nvim using some
" unicode characters in the file autoload/float.vim
set encoding=utf-8

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>


nnoremap <Leader>m :CtrlPMRU<CR>
nnoremap <Leader>b :CtrlPBuffer<CR>

let g:svelte_preprocessor_tags = [
  \ { 'name': 'ts', 'tag': 'script', 'as': 'typescript' }
  \ ]
let g:svelte_preprocessors = ['ts']
