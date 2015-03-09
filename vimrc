" My personal vimrc file.
"
" Maintainer:	Andrea Riciputi <andrea.riciputi@gmail.com>
"

set nocompatible        " Vim is more than Vi
filetype off " Required to prevent possible incompatibilities

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Keep Plugin commands between vundle#begin/end.

Plugin 'vim-scripts/IndexedSearch'     " Display #/N matches when searching
Plugin 'scrooloose/nerdtree'           " Directory tree
Plugin 'mrrech/ag.vim'                 " SilverSearcher (a.k.a faster grep)
Plugin 'jlanzarotta/bufexplorer'       " BufferExplorer
Plugin 'chrisbra/csv.vim'              " CSV plugin
Plugin 'kien/ctrlp.vim'                " Ctrl-p fuzzy matcher
Plugin 'rizzatti/dash.vim'             " Dash - Vim integration
Plugin 'jmcantrell/vim-diffchanges'    " Shows changes since the last save
Plugin 'pangloss/vim-javascript'       " Better Javascript syntax and indent
Plugin 'nanotech/jellybeans.vim'       " Jellybeans color scheme
Plugin 'jpythonfold.vim'               " Better folding for Python
Plugin 'scrooloose/nerdcommenter'      " Make comment/uncomment easy
Plugin 'indentpython.vim'              " Better Python indentation
Plugin 'hdima/python-syntax'           " Better Python syntax highlighting
Plugin 'luochen1990/rainbow'           " Rainbow parenthesis
Plugin 'msanders/snipmate.vim'         " Snippets
Plugin 'ervandew/supertab'             " SuperTab
Plugin 'scrooloose/syntastic'          " Syntax checking
Plugin 'tpope/vim-capslock'            " Capslock without capslock key
Plugin 'milkypostman/vim-togglelist'   " Open/close quicklist/locallist
Plugin 'tpope/vim-surround'            " Make changing surround chars easier


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

"
" Platform recognition settings
"
let s:uname=''
if has('unix')
    let s:uname = system('uname | tr -d "\n"') " Get platform name (stripping the trailing newline)
endif

"
" Common option settings
"

set backspace=indent,eol,start       " allow backspacing over everything in insert mode

set hidden              " hide buffers instead of closing
set nobackup		" do not keep a backup file
set history=1000	" keep 1000 lines of command line history
set ruler		" show the cursor position all the time
set cursorline          " show the cursor line
set showcmd		" display incomplete commands
set tildeop             " set tilde as operator
set encoding=utf-8      " set character enconding to utf-8
set scrolloff=2         " keep always 2 lines of context when scrolling
set textwidth=0         " disable automatic line wrap
set viminfo='100,<50,:100,s10,h " things to remember (see :he viminfo)
set formatoptions+=j    " remove comment chars when joining two comment lines

" Set status bar options
set laststatus=2        " show the status line always

" Set up tab stop machinery
"set tabstop=8           " this is the default, i set it anyway just for documentation
set shiftwidth=4        " set indetation to 4 characters
set expandtab           " expand <TAB> char to spaces

set autoindent          " set autoindent on
set copyindent          " copy the previous indentation on autoindenting

" Set searching options
set ignorecase          " foo matches foo, Foo and FOO
set smartcase           " Foo matches Foo only
set incsearch           " highlight search pattern while typing
set hlsearch            " when done keep highlighting

" Set statusline
set statusline=%<%n\ %f\ %m\ %h%r%=\[%b,\0\x%B\]\ \[%{&ff}\]\ %-12.(%l,%c%V%)\ %P

" Syntax highlighting settings
if &t_Co > 2 || has("gui_running")
  syntax on
endif

" Set color scheme
let g:jellybeans_overrides = {
            \ 'Normal': { '256ctermbg': 232 },
            \ 'MatchParen': { '256ctermfg': 162, '256ctermbg': 234, 'attr': 'bold' },
            \ 'Folded': { '256ctermbg': 232 },
            \ 'ColorColumn': { '256ctermbg': 234 },
            \ 'Structure': { '256ctermfg': 111 },
            \ 'DiffChange': { '256ctermbg': 233 },
            \ 'DiffText': { '256ctermfg': 232, '256ctermbg': 32 },
            \ 'Search': { '256ctermfg': 196, 'attr': 'bold' },
\}
colorscheme jellybeans

" Search highlight shortcut
nnoremap <silent> <Leader>hh :set hlsearch! hlsearch?<CR> " Toggle highlighting
nnoremap <Leader>hw :let @/='\<<C-R>=expand("<cword>")<CR>\>'<CR>:set hls<CR> " Highlight current word

" Folding settings
set foldlevelstart=1    " Folding root level open

" Invisible characters settings
set listchars=tab:>-,eol:¬,trail:~
nnoremap <silent> <Leader>hi :set list! list?<CR>

" Set complete option
set complete-=i " DO NOT scan included files when searching for completion
set completeopt=longest " the colors of the menu make it hard to read and almost useless

" SuperTab options
let g:SuperTabLongestEnhanced=1 " (default value: 0)

" Wildmenu settings
set wildmenu
set wildmode=longest,full
set wildignore=*.pyc,*.obj
set wildignorecase

" Tags settings
set tags+=tags;$HOME
noremap <F12> :!ctags -R -o $(hg root)/tags --languages=python $(hg root)<CR>


"
" Settings that require autocommands
"
if has("autocmd")
    " Put these in an autocmd group, so that we can delete them easily.
    augroup CursorLine   " Toggle cursorline on/off
        au!
        autocmd WinEnter,InsertLeave * set cursorline
        autocmd WinLeave,InsertEnter * set nocursorline
    augroup END

    augroup SyntaxHighlighting   " Syntax highlighting settings
        au!
        if &t_Co > 2 || has("gui_running")
          au BufEnter * syn sync fromstart
        endif
    augroup END

    augroup FileTypeSettings " File type settings
        " shiftwidth == sw, softtabstop == sts, expandtab == et
        " formatoptions == fo, iskeyword == isk, textwidth == tw
        au!
        autocmd FileType python setlocal tw=80 sw=4 sts=4 et fo-=t cc=99
        autocmd FileType javascript setlocal tw=80 ts=4 sw=4 sts=4 et fo-=t isk+="-,"
        autocmd FileType css setlocal tw=80 sw=4 sts=4 et fo-=t
        autocmd FileType html setlocal tw=80 sw=2 sts=2 et fo-=t
        autocmd FileType sql setlocal tw=80 et fo-=t
        autocmd FileType rst setlocal tw=70 sw=2 sts=2 et fo+=t
        autocmd FileType tcl setlocal tw=80 sw=4 sts=4 et fo-=t
        autocmd FileType markdown setlocal tw=80 sw=2 sts=2 et fo+=t
    augroup END

    augroup OnQuit
        au!
        " Close Vim if the last window is quickfix
        autocmd BufEnter *
                    \ if &buftype=="quickfix" && winbufnr(2) == -1 |
                    \   quit! |
                    \ endif
    augroup END

    augroup TrailingSpaces " Remove any trailing whitespace
        au!
        autocmd BufRead,BufWrite * if !&bin | silent! %s/\s\+$//ge | endif
    augroup END

endif " has("autocmd")

"
" Settings enabled only when vim is started from with pgsql
"
if match(getcwd(), "/pgsql") >=0 ||  match(getcwd(), "/postgresql") >= 0

  set cinoptions=(0
  set tabstop=4
  set shiftwidth=4
  set noexpandtab

endif

"
" Mappings and convinience commands/functions
"

" Space is a better leader
map <Space> <Leader>

" Remap CTRL-I and CTRL-O
" (since CTRL-I is <Tab> and the latter is taken by SuperTab plugin)
nnoremap <Leader>i <C-I>
nnoremap <Leader>o <C-O>

" Make mapping timeout a little bit longer
set timeout timeoutlen=1100

" Don't use Ex mode, use Q for formatting
noremap Q gq

" Avoid to completely lose text when typing C-u or C-w while in insert mode
inoremap <C-u> <C-g>u<C-u>
inoremap <C-w> <C-g>u<C-w>

" Toggle relative line numbers
nnoremap <silent> <Leader>rr :set relativenumber! relativenumber?<CR>

" Re-select the text block just pasted
nnoremap <Leader>vv V`]

" Quickly open the ~/.vimrc file
nnoremap <Leader>ev <C-w><C-v><C-l>:e $MYVIMRC<CR>

" Set paste/nopaste mapping
nnoremap <C-p><C-p> :set invpaste paste?<CR>
set pastetoggle=<C-p><C-p>

" Create Blank Newlines and stay in Normal mode
nnoremap <silent> <Leader>la m`o<Esc>``
nnoremap <silent> <Leader>lA m`O<Esc>``

" Map window management shortcut
nnoremap <silent> <Leader>wh <C-w>h
nnoremap <silent> <Leader>wj <C-w>j
nnoremap <silent> <Leader>wk <C-w>k
nnoremap <silent> <Leader>wl <C-w>l
nnoremap <silent> <Leader>ww <C-w>w

nnoremap <silent> <Leader>w= <C-w>=
nnoremap <silent> <Leader>w_ <C-w>_
nnoremap <silent> <Leader>ws <C-w>s
nnoremap <silent> <Leader>wv <C-w>v
nnoremap <silent> <Leader>wo <C-w>o
nnoremap <silent> <Leader>wc <C-w>c

nnoremap <silent> <TAB> <C-w>w
nnoremap <silent> [Z <C-w>W

" Close localfix and quickfix buffers
nnoremap <silent> <Leader>lc :lclose<CR>
nnoremap <silent> <Leader>lo :lopen<CR>
nnoremap <silent> <Leader>qc :cclose<CR>
nnoremap <silent> <Leader>qo :copen<CR>

" Close buffer
nnoremap <silent> <Leader>bc :bdelete<CR>
nnoremap <silent> <Leader>bn :bnext<CR>
nnoremap <silent> <Leader>bN :bNext<CR>
nnoremap <silent> <Leader>bp :bprevious<CR>

" Readline-like movements on the command line
cnoremap <C-a> <Home>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <C-d> <Delete>
cnoremap <M-b> <S-Left>
cnoremap <M-f> <S-Right>
cnoremap <M-d> <S-Right><Delete>
cnoremap <Esc>b <S-Left>
cnoremap <Esc>f <S-Right>
cnoremap <Esc>d <S-Right><Delete>
cnoremap <C-g> <C-c>

"
" Copy/Paste/Cut
"
if has('unnamedplus')
      set clipboard=unnamed,unnamedplus
endif
noremap <Leader>yy "+yy<CR>
noremap <Leader>x "+x<CR>
noremap <Leader>p "+p<CR>

" Open files shortcuts
noremap <leader>ee :e <C-R>=expand("%:h") . "/" <CR>
noremap <leader>ew :new %:p:h<CR>

"
" Abbreviations
"
cnoreabbrev W! w!
cnoreabbrev W w
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev Wqa wqa
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qa qall
cnoreabbrev Qall qall

"
" Plugin settings
"

" BufExplorer settings
let g:bufExplorerShowRelativePath=1  " Show relative paths.

" NERDTree settings
let NERDTreeIgnore=['\.pyc$', '\.pyo$', '\~$']
let NERDTreeQuitOnOpen=1
nnoremap <silent> <Leader>nn :NERDTreeToggle<CR>

" Ag.vim settings
let g:ag_default_options="--column --smart-case"
let g:aghighlight = 1
nnoremap <leader>aa :Ag! <cword> -w <CR>
nnoremap <leader>at :AgFileType! <cword> -w <CR>

" Rainbow settings
let g:rainbow_active = 1
"let g:rainbow_ctermfgs = [196, 'blue', 'magenta', 'cyan', 'green'] "parens custom colors

" Python Enhanced Syntax Highlighting
let python_highlight_builtin_objs = 1
let python_highlight_builtin_funcs = 1
let python_highlight_exceptions = 1
let python_highlight_string_formatting = 1
let python_slow_sync = 1

" Syntastic settings
let g:syntastic_check_on_open=1
let g:syntastic_auto_loc_list=2 " Open only when errors are detected
let g:syntastic_mode_map = { 'mode': 'active',
                           \ 'active_filetypes': [],
                           \ 'passive_filetypes': ['tcl'] }
let g:syntastic_stl_format = '[%E{E: %e}%B{, }%W{W: %w}]'
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_python_checkers = ['pyflakes']
"let g:syntastic_debug = 3 " Enable debugging mode
set statusline+=\ %{SyntasticStatuslineFlag()} " Append Syntastic status

" Session settings
set sessionoptions=buffers,curdir,folds
let g:session_autoload='no'

"
" GUI specific settings
"
if has("gui_running")
    "set go-=T
    "set go-=L
    "set go-=r
    "set go-=m
    "set go-=b
endif

"
" Platform specific settings
"
if s:uname == "Darwin"  " Mac specific stuff
    " Copy and Paste settings
    nnoremap <F6> :.w !pbcopy<CR><CR>
    vnoremap <F6> :w !pbcopy<CR><CR>
    nnoremap <F7> :r !pbpaste<CR>
    inoremap <F7> <ESC>:r !pbpaste<CR>A

elseif s:uname == "linux" " Linux specific stuff
else " Unkwon platform
endif

if &diff
    if has("autocmd")
        " Avoid trailing spaces removal when merging
        autocmd! TrailingSpaces
    endif

    set diffopt+=foldcolumn:0
    nnoremap <Leader>dp :diffput<CR>
    vnoremap <Leader>dp :diffput<CR>
else
    " DiffChanges settings
    nnoremap <silent> <Leader>df :DiffChanges<CR>
    nnoremap <silent> <Leader>dt :DiffChangesDiffToggle<CR>
    nnoremap <silent> <Leader>dp :DiffChangesPatchToggle<CR>
endif
