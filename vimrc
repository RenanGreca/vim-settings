" .vimrc, http://github.com/euclio/vim-settings
" by Andy Russell (andy@acrussell.com)
"
" =============================================================================
" Setup
" =============================================================================
" viMproved!
set nocompatible

" Make $VIMHOME point to .vimrc location independent of OS
if has('win32') || has('win64')
  let $VIMHOME=$HOME . '/vimfiles'

  " Fix the path of vimrc and gvimrc for Windows
  let $MYVIMRC=$VIMHOME . '/vimrc'
  let $MYGVIMRC=$VIMHOME . '/gvimrc'
else
  let $VIMHOME=$HOME . '/.vim'
endif

" Change leader to comma
let mapleader=","
" This could cause filetype plugins to have mappings that conflict with other
" plugins, but as I have encountered few filetype plugins that add additional
" mappings there is little concern.
let maplocalleader=mapleader

" Ensure that vim uses the correct shell
if has('win32') || has('win64')
    set shell=cmd.exe
else
    set shell=/bin/bash
endif

" Enable NeoBundle and plugins
source $VIMHOME/plugins.vim

" Set filetype specific indentation
filetype plugin indent on

" Ensure all plugins are installed
NeoBundleCheck

" =============================================================================
" File settings
" =============================================================================
" Set default encodings and file formats
set encoding=utf8
set fileformats=unix,dos,mac

" Set column width to 79 characters, and display a line at the limit
" set textwidth=79 colorcolumn=+1

" Don't wrap lines
set nowrap

" Enable syntax highlighting
syntax enable

" Make tabs into spaces and indent with 4 spaces
set expandtab tabstop=4 shiftwidth=4 softtabstop=4

" Store undo history across sessions
if v:version >= 703
  let &undodir=$VIMHOME . '/undodir'
  if !isdirectory(&undodir)
    call mkdir(&undodir)
  endif
  set undofile
endif

" Autoformat comments into paragraphs when modifying text
set formatoptions=cqr

" Assume that .tex files are LaTeX
let g:tex_flavor='latex'

" Use one space between sentences
set nojoinspaces

" =============================================================================
" Editing Window Improvements
" =============================================================================
" Allow mouse usage(?)
set mouse=a

" Show line numbers
set number "relativenumber

" When leaving buffer, hide it instead of closing it
set hidden

" Statusline settings
set laststatus=2 noshowmode showcmd cmdheight=2

" Ensure that the cursor is at least 5 lines above bottom
set scrolloff=5

" Show arrows when there are long lines, and show · for trailing space
set list listchars=tab:»·,trail:·,precedes:←,extends:→

" Enable autocomplete menu
set wildmenu

" On first tab, complete the longest common command. On second tab, cycle menu
set wildmode=longest,full

" Files to ignore in autocompletion
set wildignore=*.o,*.pyc,*.class,*.bak,*~

" =============================================================================
" Motions
" =============================================================================

" Backspace works as expected (across lines)
set backspace=indent,eol,start

" Searching behaves like a web browser
set incsearch ignorecase smartcase hlsearch

" =============================================================================
" New Commands
" =============================================================================
" F9 opens .vimrc in a new window
map <f9> :sp $MYVIMRC<cr>

" <leader><leader> clears previous search highlighting
map <silent> <leader><leader> :nohlsearch<cr>

" w!! saves file with superuser permissions
if has('unix') || has('macunix')
  cabbrev w!! w !sudo tee > /dev/null %
endif

" <leader>d deletes without filling the yank buffer
nmap <silent> <leader>d "_d
vmap <silent> <leader>d "_d

" <leader>/ opens current search in Quickfix window
map <silent> <leader>/ :execute 'vimgrep /'.@/.'/g %'<cr>:copen<cr>

" <leader>df toggles diff mode for the current buffer
nnoremap <silent> <leader>df :call DiffToggle()<CR>
function! DiffToggle()
    if &diff
        diffoff
    else
        diffthis
    endif
endfunction

" =============================================================================
" Fix Annoyances
" =============================================================================
" Disable visual and audio bell
set noerrorbells visualbell t_vb=

" Don't make backups or swaps
set nobackup noswapfile

" Make regex a little easier
set magic

" Custom Terminal title
let &titlestring=hostname() . ' : %F %r: VIM %m'
set title

" Make sure that vim has a tmp directory to use
set directory=,~/tmp,$TMP

" Let vim reload files after shelling out
set autoread

" Don't show the scratch buffer during completions
set completeopt-=preview

" Show mode changes faster
set ttimeoutlen=50

" Paste from other apps works
set paste

" Jump to the last known cursor position when opening a file
autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \     execute "normal! g`\"" |
    \ endif

" =============================================================================
" Colorscheme
" =============================================================================
" Use a dark colorscheme
set background=dark
if &t_Co >= 88
  silent! colorscheme nocturne
else
  colorscheme default
endif
