" Vim configs for shujun (wsj20369@foxmail.com)
"
" Github: https://github.com/wsj20369/my_vim_config.git
" Gitee:  https://gitee.com/shujun20369/my_vim_config.git

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
" How to install "YouComleteMe":
"  1) Use normal method...
"    $ cd ~/.vim/plugged
"    $ git clone https://github.com/ycm-core/YouCompleteMe.git
"    $ sudo apt install build-essential cmake python3-dev
"    $ sudo apt install node.js golang xbuilder
"    $ cd YouCompleteMe
"    $ cd third_party
"    $ git submodule update --init --recursive
"    $ # python3 install.py --all           [ Failed ]
"    $ python3 install.py                   [ Support C only ]
"  2) Use the cached YouCompleteMe.tar.gz   [ About 300MB, too big to upload to Github ]
"    Extract the YouCompleteMe.tar.gz to ~/.vim/plugged/
"     Or
"    Extract the YouCompleteMe.tar.gz, and make a symlink '~/.vim/plugged/YouCompleteMe' to YouCompleteMe/
"
" Learn more vim plugin info: https://github.com/yangyangwithgnu/use_vim_as_ide
" Learn VimScript: https://www.w3cschool.cn/vim/nckx1pu0.html
"

" Disable old-VI compatible
set nocompatible

" Auto apply the configs after changed
autocmd BufWritePost $MYVIMRC source $MYVIMRC

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
" Org mode
Plug 'jceb/vim-orgmode'
Plug 'tpope/vim-speeddating'
Plug 'mattn/calendar-vim'
" YouCompleteMe
Plug 'ycm-core/YouCompleteMe'
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
function! CursorCrossMode(enable)
	let l:en = a:enable

	if l:en == 2
		if !exists("g:cursorcrossmode")
			let g:cursorcrossmode = 0
		endif
		if g:cursorcrossmode == 1
			let l:en = 0
		else
			let l:en = 1
		endif
	endif

	if l:en == 0
		let g:cursorcrossmode = 0
		set nocursorcolumn
	else
		let g:cursorcrossmode = 1
		set cursorline
		set cursorcolumn
		highlight CursorLine cterm=NONE ctermbg=blue ctermfg=NONE guibg=blue guifg=NONE
		highlight CursorColumn cterm=NONE ctermbg=blue ctermfg=NONE guibg=blue guifg=NONE
	endif
endfunc

" Add semicolon in the end of line
function! AddSemicolonInLineTail()
	execute "normal! mqA;\<esc>`q"
endfunc

" Grep Operator, <Leader>giw to grep the current word
" Copied from: https://www.w3cschool.cn/vim/tfogmozt.html
function! GrepOperator(type)
	let l:saved_unnamed_register = @@

	if a:type ==# 'v'
		execute "normal! `<v`>y"
	elseif a:type ==# 'char'
		execute "normal! `[v`]y"
	else
		return
	endif

	silent execute "grep! -R " . shellescape(@@) . " ."
	silent copen 16

	let @@ = l:saved_unnamed_register
endfunc

" Error highlight if has too many Spaces/Tabs in the Line tail
function! ErrorHighlightIfTooManySpacesInLineTail(enable)
	if a:enable == 1
		highlight TooManySpacesInLineTail ctermbg=red guibg=red
		match TooManySpacesInLineTail /\v[ \t]+$/
	else
		match none
	endif
endfunc

" Get current directory
function! GetPWD()
	return substitute(getcwd(), "", "", "g")
endfunc

" Change Statue Line
function! UpdateStatusLine()
	let l:styles = []
	call add(l:styles, '(^_^) %f%m%r%h %= %c%V,%l/%L [%P]')
	call add(l:styles, '(^_^) %f%m%r%h >> %{GetPWD()} %= %c%V,%l/%L [%P]')

	if !exists("g:statusline_style") || !exists("g:statusline_mode")
		let g:statusline_style = 0
		let g:statusline_mode = 0
	endif

	let g:statusline_mode += 1
	if g:statusline_mode > 2
		let g:statusline_mode = 1
		let g:statusline_style += 1
		if g:statusline_style >= len(l:styles)
			let g:statusline_style = 0
		endif
	endif

	let &laststatus = g:statusline_mode
	let &statusline = l:styles[g:statusline_style]
endfunc

" Make project
function! MakeCurrentProject(clean_build)
	if a:clean_build ==# 1
		make clean
	endif
	make
endfunc
noremap <silent> <Leader>mm :call MakeCurrentProject(0)<CR>
noremap <silent> <Leader>mn :call MakeCurrentProject(1)<CR>

" Common Settings
syntax enable
syntax on
set hlsearch
set incsearch
set fileencoding=utf-8
" set nonumber
set number
set relativenumber
set ruler
set magic                       " Extend pattern for search
set autoindent                  " Copy indent from current line when starting a new line
set smarttab
set cindent
set nowrap                      " Disallow line wrap
set wildmenu                    " Enhanced command-line completion, possible matches are shown just above the command line
set colorcolumn=100

" Colors
set background=light
colorscheme desert

call CursorCrossMode(1)
highlight CursorLine cterm=NONE ctermbg=blue ctermfg=NONE guibg=blue guifg=NONE
highlight ColorColumn cterm=NONE ctermbg=NONE ctermfg=green guibg=NONE guifg=NONE
highlight Folded cterm=NONE ctermbg=blue ctermfg=grey guibg=NONE guifg=NONE
highlight FoldColumn cterm=NONE ctermbg=blue ctermfg=grey guibg=NONE guifg=NONE

" Enter source code directory, do ctags -R
set tags=./tags;,tags

" Org mode
let g:org_agenda_files=['~/org/index.org']

" Rainbow Parentheses
" au FileType c,cpp,objc,objcpp call rainbow#load()
" let g:rainbow_active = 1

" Keys Settings
noremap <F8> :TagbarToggle<CR>
noremap <F12> :call quickmenu#toggle(0)<cr>

nnoremap <Leader>q :q<CR>
nnoremap <Leader>w :w<CR>

nnoremap <Leader>f :ToggleBufExplorer<CR>
nnoremap <Leader>d :NERDTreeToggle<CR>

nnoremap <Leader>\ :call TabIndentLineToggle()<CR>
nnoremap <Leader>x :call CursorCrossMode(2)<CR>

nnoremap <Leader><Leader>w :call ErrorHighlightIfTooManySpacesInLineTail(1)<CR>
nnoremap <Leader><Leader>W :call ErrorHighlightIfTooManySpacesInLineTail(0)<CR>

" Tags browser
nnoremap <Leader>n :tnext<CR>
nnoremap <Leader>p :tprevious<CR>

" C code edit
nnoremap <Leader><Leader>z :call AddSemicolonInLineTail()<CR>

" Grep...
nnoremap <Leader>g :set operatorfunc=GrepOperator<CR>g@
vnoremap <Leader>g :<c-u>call GrepOperator(visualmode())<CR>

" Status Line
call UpdateStatusLine()
nnoremap <Leader><Leader>s :call UpdateStatusLine()<CR>
nnoremap <Leader><Leader>S :set laststatus=0<CR>

" Gvim: Toggle Menu and Toolbar
set guioptions-=m
set guioptions-=T
noremap <silent> <F2> :if &guioptions =~# 'T' <Bar>
			\set guioptions-=T <Bar>
			\set guioptions-=m <bar>
			\else <Bar>
			\set guioptions+=T <Bar>
			\set guioptions+=m <Bar>
			\endif<CR>

" Gvim: font
set guifont=Consolas:h11:cANSI:qDRAFT

" Gvim: window maximize
autocmd GUIEnter * simalt ~x

" Gvim: full screen
if has('gui_running') && has("win32") && has('libcall')
	let g:MyVimLib = $VIMRUNTIME.'/gvimfullscreen.dll'
	function ToggleFullScreen()
		call libcallnr(g:MyVimLib, "ToggleFullScreen", 0)
	endfunc

	" Alt+Enter/F11 to toggle full screen
	noremap <A-Enter> <Esc>:call ToggleFullScreen()<CR>
	noremap <silent> <F11> :call ToggleFullScreen()<CR>

	let g:VimAlpha = 240
	function! SetAlpha(alpha)
		let g:VimAlpha = g:VimAlpha + a:alpha
		if g:VimAlpha < 180
			let g:VimAlpha = 180
		endif
		if g:VimAlpha > 255
			let g:VimAlpha = 255
		endif
		call libcall(g:MyVimLib, 'SetAlpha', g:VimAlpha)
	endfunc

	" <Leader><Leader>y
	nnoremap <silent> <Leader><Leader>y <Esc>:call SetAlpha(3)<CR>
	" <Leader><Leader>t
	nnoremap <silent> <Leader><Leader>t <Esc>:call SetAlpha(-3)<CR>
endif

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
call g:quickmenu#append('<L>f - Buf Explorer',      'BufExplorer', '')
call g:quickmenu#append('<L>d - NERDTreeToggle',    'NERDTreeToggle', '')
call g:quickmenu#append('<L>\ - Tab Indent Line',   'call TabIndentLineToggle()', '')
call g:quickmenu#append('F8   - TagbarToggle',      'TagbarToggle', '')
call g:quickmenu#append('F12  - QuickMenu',         'call quickmenu#toggle(0)', '')
call g:quickmenu#append('# Programming', '')
call g:quickmenu#append('Remove Trailing Blanks',   'call RemoveTrailingBlanks()', '')
call g:quickmenu#append('# Look & feel', '')
call g:quickmenu#append('Show Number',              'set number', '')
call g:quickmenu#append('No Number',                'set nonumber', '')
call g:quickmenu#append('CursorLine Reverse',       'highlight CursorLine cterm=reverse', '')
call g:quickmenu#append('Cursor Cross',             'call CursorCrossMode(2)', '')
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

