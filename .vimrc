" Vim configs for shujun (wsj20369@foxmail.com)

" Below configs should be placed in
"   ~/.vimrc                  for vim
"   ~/.config/nvim/init.vim   for neovim
"
" Install vim-plug:
"   git clone https://github.com/junegunn/vim-plug
"   copy the plug.vim to
"     ~/.vim/autoload/plug.vim           if you are using vim
"     ~/.config/nvim/autoload/plug.vim   if you are using neovim
"
" Learn more vim plugin info: https://github.com/yangyangwithgnu/use_vim_as_ide

" Disable old-VI compatible
set nocompatible

" Auto apply the configs after changed
" autocmd BufWritePost $MYVIMRC source $MYVIMRC

" Leader key
let mapleader = ";"

" Auto detect filetype
filetype on
filetype plugin on

" Plugins
call plug#begin('~/.vim/plugged')
" Views
Plug 'jlanzarotta/bufexplorer'
" Programmer
Plug 'scrooloose/nerdtree'
Plug 'preservim/nerdcommenter'
Plug 'majutsushi/tagbar'
" Plug 'frazrepo/vim-rainbow'
" Color Schemes
Plug 'mrkn/mrkn256.vim'
Plug 'w0ng/vim-hybrid'
Plug 'altercation/vim-colors-solarized'
Plug 'tomasr/molokai'
" Git helper
Plug 'tpope/vim-fugitive'
" Common helper
Plug 'liuchengxu/vim-which-key'
Plug 'mg979/vim-visual-multi'
" Plug 'powerline/powerline'
Plug 'skywind3000/quickmenu.vim'
call plug#end()

" Tab Indent Lines
function! TabIndentLineToggle()
	if !exists("g:tabindentline")
		let g:tabindentline = 0
		set list
		set lcs=tab:\|\ ,nbsp:%,trail:-
	endif
	if g:tabindentline == 1
		let g:tabindentline = 0
		set nolist
	else
		let g:tabindentline = 1
		set list
		set lcs=tab:\|\ ,nbsp:%,trail:-
	endif
endfunc
let g:tabindentline = 0
call TabIndentLineToggle()

" Remove Trailing-Blank chars
function! RemoveTrailingBlanks()
	%s/[\t ]*$//g
endfunc

" Track cursor in Cross-Mode
function! CursorCrossMode()
	if !exists("g:cursorcrossmode")
		let g:cursorcrossmode = 0
	endif
	if g:cursorcrossmode == 1
		let g:cursorcrossmode = 0
		set nocursorcolumn
	else
		let g:cursorcrossmode = 1
		set cursorline
		set cursorcolumn
		highlight CursorLine cterm=reverse
		highlight CursorColumn cterm=NONE ctermbg=lightblue ctermfg=NONE guibg=NONE guifg=NONE
	endif
endfunc
let g:cursorcrossmode = 0

" Colors
set background=light
colorscheme desert

" Common Settings
syntax enable
syntax on
set hlsearch
set nonumber
set ruler
set magic                       " Extend pattern for search
set autoindent                  " Copy indent from current line when starting a new line
set smarttab
set cindent
set nowrap                      " Disallow line wrap
set laststatus=2                " Always has status line
set wildmenu                    " Enhanced command-line completion, possible matches are shown just above the command line
set cursorline
highlight CursorLine cterm=reverse
" set cursorcolumn
" set nocursorcolumn
" highlight CursorColumn cterm=NONE ctermbg=black ctermfg=green guibg=NONE guifg=NONE
set colorcolumn=100
highlight ColorColumn cterm=NONE ctermbg=NONE ctermfg=green guibg=NONE guifg=NONE

" Enter source code directory, do ctags -R
set tags=./tags;,tags

" Rainbow Parentheses
" au FileType c,cpp,objc,objcpp call rainbow#load()
" let g:rainbow_active = 1

" Keys Settings
noremap <F6> :NERDTreeToggle<CR>
noremap <F8> :TagbarToggle<CR>
noremap <F9> :BufExplorer<CR>
noremap <F11> :call TabIndentLineToggle()<CR>
noremap <F12> :call quickmenu#toggle(0)<cr>

nnoremap <Leader>q :q<CR>
nnoremap <Leader>w :w<CR>

nnoremap <Leader>f :BufExplorer<CR>
nnoremap <Leader>d :NERDTreeToggle<CR>

nnoremap <Leader>\ :call TabIndentLineToggle()<CR>
nnoremap <Leader>x :call CursorCrossMode()<CR>

" Tags browser
nnoremap <Leader>n :tnext<CR>
nnoremap <Leader>p :tprevious<CR>

" Commenter
let g:NERDSpaceDelims = 1                     " Add spaces after comment delimiters by default
let g:NERDCompactSexyComs = 1                 " Use compact syntax for prettified multi-line comments
let g:NERDDefaultAlign = 'left'               " Align line-wise comment delimiters flush left instead of following code indentation
" Add your own custom formats or override the defaults
" let g:NERDCustomDelimiters = { 'c': { 'left': '/*','right': '*/' } }
let g:NERDCommentEmptyLines = 1               " Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDTrimTrailingWhitespace = 1          " Enable trimming of trailing whitespace when uncommenting
let g:NERDToggleCheckAllLines = 1             " Enable NERDCommenterToggle to check all selected lines is commented or not

" BufExplorer
let g:bufExplorerDefaultHelp=0                " Do not show default help.
let g:bufExplorerShowRelativePath=1           " Show relative paths.
let g:bufExplorerSortBy='mru'                 " Sort by most recently used.
let g:bufExplorerSplitRight=1                 " Split left.
let g:bufExplorerSplitVertical=1              " Split vertically.
let g:bufExplorerSplitVertSize = 30           " Split width
let g:bufExplorerUseCurrentWindow=1           " Open in new window.
let g:bufExplorerDisableDefaultKeyMapping =0  " Do not disable default key mappings.

" Quick Menu
let g:quickmenu_options = "LH"  " L = cursorline, H = Cmdline Help
call g:quickmenu#reset()
call g:quickmenu#append('# Hot Keys', '')
call g:quickmenu#append('F9  - Buf Explorer',       'BufExplorer', '')
call g:quickmenu#append('F6  - NERDTreeToggle',     'NERDTreeToggle', '')
call g:quickmenu#append('F8  - TagbarToggle',       'TagbarToggle', '')
call g:quickmenu#append('F11 - Tab Indent Line',    'call TabIndentLineToggle()', '')
call g:quickmenu#append('F12 - QuickMenu',          'call quickmenu#toggle(0)', '')
call g:quickmenu#append('# Programming', '')
call g:quickmenu#append('Remove Trailing Blanks',   'call RemoveTrailingBlanks()', '')
call g:quickmenu#append('# Look & feel', '')
call g:quickmenu#append('Show Number',              'set number', '')
call g:quickmenu#append('No Number',                'set nonumber', '')
call g:quickmenu#append('CursorLine Reverse',       'highlight CursorLine cterm=reverse', '')
call g:quickmenu#append('Cursor Cross',             'call CursorCrossMode()', '')
call g:quickmenu#append('# Git helper', '')
call g:quickmenu#append('Git Status',               'Gstatus', '')
call g:quickmenu#append('Git Diff',                 'Gvdiff', '')
call g:quickmenu#append('Git Blame',                'Gblame', '')
call g:quickmenu#append('# Color Scheme', '')
call g:quickmenu#append('default',                  'colorscheme default', '')
call g:quickmenu#append('desert',                   'colorscheme desert', '')
call g:quickmenu#append('blue',                     'colorscheme blue', '')
call g:quickmenu#append('hybrid',                   'colorscheme hybrid', '')
call g:quickmenu#append('molokai',                  'colorscheme molokai', '')

