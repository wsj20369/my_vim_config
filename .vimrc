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

" Plugins
call plug#begin('~/.vim/plugged')
" Views
Plug 'jlanzarotta/bufexplorer'
" Programmer
Plug 'scrooloose/nerdtree'
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
	if !exists("b:tabindentline")
		let b:tabindentline = 0
		set list
		set lcs=tab:\|\ ,nbsp:%,trail:-
	endif
	if b:tabindentline == 1
		let b:tabindentline = 0
		set nolist
	else
		let b:tabindentline = 1
		set list
		set lcs=tab:\|\ ,nbsp:%,trail:-
	endif
endfunc

" Colors
set background=light
colorscheme desert

" Common Settings
set hlsearch
set nonumber
set ruler
set magic         " Extend pattern for search
set autoindent    " Copy indent from current line when starting a new line
set smarttab
set cindent
syntax on
call TabIndentLineToggle()
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
map <F6> :NERDTreeToggle<CR>
map <F8> :TagbarToggle<CR>
map <F11> :call TabIndentLineToggle()<CR>

" BufExplorer
let g:bufExplorerDefaultHelp=0                " Do not show default help.
let g:bufExplorerShowRelativePath=1           " Show relative paths.
let g:bufExplorerSortBy='mru'                 " Sort by most recently used.
let g:bufExplorerSplitRight=1                 " Split left.
let g:bufExplorerSplitVertical=1              " Split vertically.
let g:bufExplorerSplitVertSize = 30           " Split width
let g:bufExplorerUseCurrentWindow=1           " Open in new window.
let g:bufExplorerDisableDefaultKeyMapping =0  " Do not disable default key mappings.
nnoremap <silent> <F9> :BufExplorer<CR>

" Quick Menu
let g:quickmenu_options = "LH"  " L = cursorline, H = Cmdline Help
call g:quickmenu#reset()
call g:quickmenu#append('# Hot Keys', '')
call g:quickmenu#append('F9  - Buf Explorer',    'BufExplorer', '')
call g:quickmenu#append('F6  - NERDTreeToggle',  'NERDTreeToggle', '')
call g:quickmenu#append('F8  - TagbarToggle',    'TagbarToggle', '')
call g:quickmenu#append('F11 - Tab Indent Line', 'call TabIndentLineToggle()', '')
call g:quickmenu#append('F12 - QuickMenu',       'call quickmenu#toggle(0)', '')
call g:quickmenu#append('# Look & feel', '')
call g:quickmenu#append('Show Number',           'set number', '')
call g:quickmenu#append('No Number',             'set nonumber', '')
call g:quickmenu#append('CursorLine Reverse',    'highlight CursorLine cterm=reverse', '')
call g:quickmenu#append('# Git helper', '')
call g:quickmenu#append('Git Status',            'Gstatus', '')
call g:quickmenu#append('Git Diff',              'Gvdiff', '')
call g:quickmenu#append('Git Blame',             'Gblame', '')
call g:quickmenu#append('# Color Scheme', '')
call g:quickmenu#append('default',               'colorscheme default', '')
call g:quickmenu#append('desert',                'colorscheme desert', '')
call g:quickmenu#append('blue',                  'colorscheme blue', '')
call g:quickmenu#append('hybrid',                'colorscheme hybrid', '')
call g:quickmenu#append('molokai',               'colorscheme molokai', '')
noremap <silent><F12> :call quickmenu#toggle(0)<cr>

