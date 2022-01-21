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
" Install for Ctags:
"   sudo apt-get install exuberant-ctags
"
" Install for Linux/C code reading
"   Cscope: Install:
"     sudo apt install cscope
"   Cscope: Generate database in your project:
"     find . -type f > cscope.files # If you need files other than .c/.h/.l/.y
"     cscope -Rbq     # For userspace programs
"     cscope -Rbqk    # For Linux kernel
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
"    $ cd ..
"    $ # python3 install.py --all                  [ Failed ]
"    $ python3 install.py --clangd-completer       [ Support C only ]
"  2) Use the cached YouCompleteMe.tar.gz          [ About 300MB, too big to upload to Github ]
"    Extract the YouCompleteMe.tar.gz to ~/.vim/plugged/
"     Or
"    Extract the YouCompleteMe.tar.gz, and make a symlink '~/.vim/plugged/YouCompleteMe' to YouCompleteMe/
"
" Learn more vim plugin info: https://github.com/yangyangwithgnu/use_vim_as_ide
" Learn VimScript: https://www.w3cschool.cn/vim/nckx1pu0.html

" Tips about Vim:
"  1) How to write to root permission file with normal user:
"    :w !sudo tee %
"                 |
"                 \--> % means current file name
"  2) Read shell command output to current buffer, example:
"    :r !ls -l /
"

" Disable old-VI compatible
set nocompatible

" Auto apply the configs after changed
autocmd BufWritePost $MYVIMRC source $MYVIMRC

" Leader key
let g:mapleader = ";"

" Auto detect filetype
filetype on
filetype plugin on

" Vim plugin configs
let s:has_YouCompleteMe = 0
let s:has_OrgMode = 0
if has("python3")
	let s:has_YouCompleteMe = 0
	let s:has_OrgMode = 1
endif

" Plugins
call plug#begin('~/.vim/plugged')
" Views
Plug 'jlanzarotta/bufexplorer'
" Programmer
Plug 'scrooloose/nerdtree'
Plug 'preservim/nerdcommenter'
Plug 'majutsushi/tagbar'
Plug 'kien/rainbow_parentheses.vim'
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
if s:has_OrgMode ==# 1
	Plug 'jceb/vim-orgmode'
	Plug 'tpope/vim-speeddating'
	Plug 'mattn/calendar-vim'
endif
" YouCompleteMe
if s:has_YouCompleteMe ==# 1
	Plug 'ycm-core/YouCompleteMe'
endif
" Youdao translater
Plug 'ianva/vim-youdao-translater'
call plug#end()

function! s:SetColorOfLineAndColumn()
	let l:cursorline_style  = "underline"
	let l:warningcolorfg    = "NONE"
	let l:warningcolorbg    = "darkgrey"
	let l:normalcolorfg     = "NONE"
	let l:normalcolorbg     = "blue"
	let l:foldedcolorfg     = "grey"
	let l:foldedcolorbg     = "blue"

	if l:cursorline_style ==? "NONE"
		let l:cursorline_style = "NONE"
	else
		let l:normalcolorfg    = "NONE"
		let l:normalcolorbg    = "NONE"
	endif

	execute "highlight ColorColumn cterm=NONE ctermfg=" l:warningcolorfg " ctermbg=" l:warningcolorbg
				\ " guifg=" l:warningcolorfg " guibg=" l:warningcolorbg

	execute "highlight CursorLine cterm=" l:cursorline_style " ctermfg=" l:normalcolorfg " ctermbg=" l:normalcolorbg
				\ " gui=" l:cursorline_style " guifg=" l:normalcolorfg " guibg=" l:normalcolorbg
	execute "highlight CursorColumn cterm=NONE ctermfg=" l:normalcolorfg " ctermbg=" l:normalcolorbg
				\ " gui=NONE guifg=" l:normalcolorfg " guibg=" l:normalcolorbg

	execute "highlight Folded cterm=NONE ctermfg=" l:foldedcolorfg " ctermbg=" l:foldedcolorbg
				\ " guifg=" l:foldedcolorfg " guibg=" l:foldedcolorbg
	execute "highlight FoldColumn cterm=NONE ctermfg=" l:foldedcolorfg " ctermbg=" l:foldedcolorbg
				\ " guifg=" l:foldedcolorfg " guibg=" l:foldedcolorbg
endfunc

" Tab Indent Lines
function! TabIndentLineEnable(enable)
	let g:tabindentline = a:enable

	if g:tabindentline == 0
		set nolist
	else
		set list
		set lcs=tab:\|\ ,nbsp:%,trail:-
	endif
endfunc

function! TabIndentLineToggle()
	if !exists("g:tabindentline")
		let g:tabindentline = 0
	endif

	call TabIndentLineEnable(!g:tabindentline)
endfunc

call TabIndentLineEnable(0)

" Remove Trailing-Blank chars
function! RemoveTrailingBlanks()
	%s/[\t ]*$//g
endfunc

" Track cursor in Cross-Mode
function! CursorCrossMode(enable)
	if !exists("g:cursorcrossmode")
		let g:cursorcrossmode = 0
	endif

	if a:enable == 2
		let g:cursorcrossmode = !g:cursorcrossmode
	else
		let g:cursorcrossmode = a:enable
	endif

	if g:cursorcrossmode == 0
		set cursorline
		set nocursorcolumn
	else
		set cursorline
		set cursorcolumn
		call <SID>SetColorOfLineAndColumn()
	endif
endfunc
call CursorCrossMode(0)

" Add semicolon in the end of line
function! AddSemicolonInLineTail()
	execute "normal! mqA;\<esc>`q"
endfunc

" Grep Operator, <Leader>giw to grep the current word
" Copied from: https://www.w3cschool.cn/vim/tfogmozt.html
function! s:GrepOperator(type)
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

	let &laststatus = 0 "g:statusline_mode, Always close the status line
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
set encoding=utf-8
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
set backspace=indent,eol,start  " So, Backspace works normally

" Colors
set background=light
colorscheme desert
call <SID>SetColorOfLineAndColumn()

" For Linux kernel code style
" Disable it by set it to 0 if you hate the red column line
set colorcolumn=0

" Enter source code directory, do ctags -R
set tags=./tags;,tags
map <c-]> g<c-]>

" Cscope - Good way to read C code, especially Linux kernel.
" sudo apt install cscope
" cscope -Rbq     # For userspace programs
" cscope -Rbqk    # For Linux kernel
if has("cscope")
	set cst         " Use cscope via C-]
	set csto=0      " search: first try cscope, then try ctag
	set nocsverb    " cscopeverbose
	if filereadable("cscope.out")
		cs add cscope.out
	else
		let cscope_file = findfile("cscope.out", ".;")
		let cscope_pre = matchstr(cscope_file, ".*/")
		if !empty(cscope_file) && filereadable(cscope_file)
			execute "cs add" cscope_file cscope_pre
		endif
	endif
	set csverb      " cscopeverbose

	nnoremap <C-\>a :cs find a <C-R>=expand("<cword>")<CR><CR>
	nnoremap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
	nnoremap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
	nnoremap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
	nnoremap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
	nnoremap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
	nnoremap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
	nnoremap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
	nnoremap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>

	" ;x to find who is calling me, only for function
	nnoremap <Leader>x :cs find c <C-R>=expand("<cword>")<CR><CR>
	" ;a to find where the symbol is used,
	"    for both function and variable
	nnoremap <Leader>a :cs find s <C-R>=expand("<cword>")<CR><CR>
	" ;= to find assignments to the symbol
	nnoremap <Leader>= :cs find a <C-R>=expand("<cword>")<CR><CR>
endif

" Org mode
if s:has_OrgMode ==# 1
	let g:org_agenda_files=['~/org/index.org']
endif

" YouCompleteMe
if s:has_YouCompleteMe ==# 1
	let g:ycm_global_ycm_extra_conf='~/.ycm_extra_conf.py'
	let g:ycm_confirm_extra_conf = 0
endif

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

nnoremap <Leader><Leader>w :call ErrorHighlightIfTooManySpacesInLineTail(1)<CR>
nnoremap <Leader><Leader>W :call ErrorHighlightIfTooManySpacesInLineTail(0)<CR>

" Tags browser
nnoremap <Leader>n :tnext<CR>
nnoremap <Leader>p :tprevious<CR>

" C code edit
nnoremap <Leader><Leader>z :call AddSemicolonInLineTail()<CR>

" Grep...
nnoremap <Leader>g :set operatorfunc=<SID>GrepOperator<CR>g@
vnoremap <Leader>g :<c-u>call <SID>GrepOperator(visualmode())<CR>

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

" Rainbow Parentheses
" Below codes copied from https://github.com/kien/rainbow_parentheses.vim
" Always On, use cmd ':RainbowParenthesesToggle' to toggle it
let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]

let g:rbpt_max = 16
let g:rbpt_loadcmd_toggle = 0

au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

" Youdao translater
vnoremap <silent> <C-c>y :<C-u>Ydv<CR>
nnoremap <silent> <C-c>y :<C-u>Ydc<CR>
vnoremap <silent> <leader>yy :<C-u>Ydv<CR>
nnoremap <silent> <leader>yy :<C-u>Ydc<CR>
noremap <leader>yd :<C-u>Yde<CR>

" Which Key
set timeout timeoutlen=500
let g:which_key_map = {}

let g:which_key_map.m = {
      \ 'name' : '+Make project',
      \ 'm' : ['MakeCurrentProject(0)', 'build project'],
      \ 'n' : ['MakeCurrentProject(1)', 'rebuild prject'],
      \ }

let g:which_key_map[';'] = {
      \ 'name' : '+More Keys',
      \ }

call which_key#register(';', "g:which_key_map")
nnoremap <silent> <leader> :<c-u>WhichKey ';'<CR>
vnoremap <silent> <leader> :<c-u>WhichKeyVisual ';'<CR>

