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
" How to browse Linux kernel source code           <--------------
"   1. Vim 9.0 or above is better
"   2. Install 'bear' to generate the compile_commands.json
"   3. Under Linux kernel:
"      $ make defconfig
"      $ make tags cscope
"      $ bear -- make -j16 CC=clang
"   4. The LSP config file 'compile_commands.json' should be ready
"   5. Let's start a journey to the Linux kernel
"
" Install for Fuzzy Finder
"   fzf: Install:
"     sudo apt install fzf
"   ag: Install
"     sudo apt install silversearcher-ag
"
"   Support commands: Files, Ag, Colors
"
" Install for CoC, this needs the Vim >= 8.1, nodejs >= 14.14.0
"   Add plugin: Plug 'neoclide/coc.nvim',{'branch': 'release'}
"   After plugin installed, do below commands:
"     :CocInstall coc-clangd
"     :CocInstall coc-json
"     :CocInstall coc-python
"     :CocInstall coc-tsserver
"     :CocInstall coc-marketplace
"     ..or more commands..
"
"   C/C++ auto completion also needs the "clangd":
"     $ sudo apt install clangd
"     $ sudo apt install bear         # Used to generate 'compile_commands.json' for clangd
"
"   If you wanna read the Linux kernel code, try below commands for clangd:
"     $ cd linux_sourcecode
"     $ make clean                    # If need to clean last build
"     $ make CC=clang defconfig       # Or make menuconfig...
"     $ bear -- make CC=clang -j16    # Generate the 'compile_commands.json'
"   Or
"     $ make CC=clang -j16            # Or execute: $ make CC=clang ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu-
"     $ scripts/clang-tools/gen_compile_commands.py
"                                     # Generate the 'compile_commands.json', same as the 'bear ...' command
"
"   Then, you can edit the Linux code with auto completion.
"   If any problem, you can see: https://stackoverflow.com/questions/70819007/can-not-use-clangd-to-read-linux-kernel-code
"
"   Coc plugin needs the nodejs, Install latest nodejs:
"     $ sudo apt install npm
"     $ sudo npm install n -g
"     $ sudo n lts
"     $ sudo npm install npm -g
"     $ node -v  # If not updated, please exit current shell, and do it in new shell
"     $ npm -v
"
"   Config the CoC:
"     :CocConfig
"        Add below line to disable the file path completion
"	    "coc.source.file.enable": false
"
"        Add below line to disable the CocInlayHintParameter
"	    "inlayHint.enable": false
"
"   Ask question: https://gitter.im/neoclide/coc-cn
"   See also: https://www.codenong.com/cs105832148/
"   See also: https://github.com/neoclide/coc.nvim/wiki/Completion-with-sources#trigger-mode-of-completion
"
" How to install "YouComleteMe": [It's hard to install, please use CoC]
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

" Set mouse available
" set mouse=a

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

" Plugin Manager: vim-plug
" Automatically downloads vim-plug if not found.
if empty(glob('~/.vim/autoload/plug.vim'))
	silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
		\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync
endif

" Plugins
call plug#begin('~/.vim/plugged')

" Views
Plug 'jlanzarotta/bufexplorer'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Programmer
Plug 'scrooloose/nerdtree'
Plug 'preservim/nerdcommenter'
Plug 'majutsushi/tagbar'
Plug 'kien/rainbow_parentheses.vim'
Plug 'neoclide/coc.nvim',{'branch': 'release'}
Plug 'airblade/vim-gitgutter'

" Fuzzy Finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Color Schemes
" Find your favourite theme on: https://vimcolorschemes.com/
Plug 'rafi/awesome-vim-colorschemes'
Plug 'mrkn/mrkn256.vim'
Plug 'w0ng/vim-hybrid'
Plug 'altercation/vim-colors-solarized'
Plug 'tomasr/molokai'
Plug 'NLKNguyen/papercolor-theme'
Plug 'wsj20369/vim-shenzhenwan'
Plug 'ghifarit53/tokyonight-vim'
Plug 'sainnhe/everforest'
Plug 'morhetz/gruvbox'
Plug 'pineapplegiant/spaceduck'
Plug 'joshdick/onedark.vim'

" Common helper
Plug 'liuchengxu/vim-which-key'
Plug 'mg979/vim-visual-multi' " vim-visual-multi needs vim-8
" Plug 'powerline/powerline'
Plug 'skywind3000/quickmenu.vim'
Plug 'mhinz/vim-startify'

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

" Language Translater
Plug 'voldikss/vim-translator'

call plug#end()

function! s:SetColorOfLineAndColumn()
	let l:cursorline_style  = "underline"
	let l:warningcolorfg    = "NONE"
	let l:warningcolorbg    = "darkgrey"
	let l:normalcolorfg     = "NONE"
	let l:normalcolorbg     = "blue"
	let l:cursorcolumnfg    = "yellow"
	let l:cursorcolumnbg    = "darkblue"
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
	execute "highlight CursorColumn cterm=NONE ctermfg=" l:cursorcolumnfg " ctermbg=" l:cursorcolumnbg
				\ " gui=NONE guifg=" l:cursorcolumnfg " guibg=" l:cursorcolumnbg

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
set novisualbell
set backspace=indent,eol,start  " So, Backspace works normally

" Colors
set background=dark
set t_Co=256
colorscheme spaceduck           " More: molokai, onedark, darkblue, spaceduck, space-vim-dark
call <SID>SetColorOfLineAndColumn()

" Colors for CoC plugin
highlight SignColumn ctermbg=black
highlight CocErrorSign ctermfg=red ctermbg=darkblue

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

" Coc auto complete
" use <tab> to trigger completion and navigate to the next complete item
function! CheckBackspace() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <Tab> or custom key for trigger completion
inoremap <silent><expr> <Tab>
			\ coc#pum#visible() ? coc#pum#next(1) :
			\ CheckBackspace() ? "\<Tab>" :
			\ coc#refresh()

" Use <Tab> and <S-Tab> to navigate the completion list:
inoremap <expr> <Tab> coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"
inoremap <expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"

" Use <cr> to confirm completion
inoremap <expr> <cr> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"
inoremap <silent><expr> <cr> coc#pum#visible() ? coc#_select_confirm() : "\<C-g>u\<CR>"

" Coc: code navigation
"  Thanks to: CyrilWongMy <https://juejin.cn/post/6968807773366976549>
nnoremap <silent> gd <Plug>(coc-definition)
nnoremap <silent> gy <Plug>(coc-type-definition)
nnoremap <silent> gi <Plug>(coc-implementation)
nnoremap <silent> gr <Plug>(coc-references)

" Symbol renaming.
nnoremap <leader>rn <Plug>(coc-rename)

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nnoremap <silent> [g <Plug>(coc-diagnostic-prev)
nnoremap <silent> ]g <Plug>(coc-diagnostic-next)

" Use gh to show documentation in preview window.
nnoremap <silent> gh :call <SID>show_documentation()<CR>

function! s:show_documentation()
	if (index(['vim','help'], &filetype) >= 0)
		execute 'h '.expand('<cword>')
	elseif (coc#rpc#ready())
		call CocActionAsync('doHover')
	else
		execute '!' . &keywordprg . " " . expand('<cword>')
	endif
endfunction

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
nnoremap <C-n> :NERDTreeToggle<CR>

nnoremap <Leader>\ :call TabIndentLineToggle()<CR>

nnoremap <Leader><Leader>w :call ErrorHighlightIfTooManySpacesInLineTail(1)<CR>
nnoremap <Leader><Leader>W :call ErrorHighlightIfTooManySpacesInLineTail(0)<CR>

" Tags browser
nnoremap <Leader>n :tnext<CR>
nnoremap <Leader>p :tprevious<CR>

" C code edit
nnoremap <Leader><Leader>z :call AddSemicolonInLineTail()<CR>

" Fuzzy Finder, find files
nnoremap <C-p> :Files<CR>
" Search in current buffer
nnoremap <C-s> :BLines<CR>
nnoremap <Leader>t :BTags<CR>
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>h :History<CR>
" Search in all opened buffers
nnoremap <Leader>e :Lines<CR>
" Search in current directory
nnoremap <Leader>s :Ag<CR>

" Grep...
nnoremap <Leader>g :set operatorfunc=<SID>GrepOperator<CR>g@
vnoremap <Leader>g :<c-u>call <SID>GrepOperator(visualmode())<CR>

" Status Line & Tab Line
"  Use :help airline to get help
set laststatus=2                                         " Show status line always, 2 = Alway, 1 = More than 1, 0 = Never
let g:airline#extensions#tabline#enabled = 1             " Enable airline tabline
let g:airline#extensions#tabline#tab_min_count = 1       " Minimum of 1 tabs needed to display the tabline
let g:airline#extensions#tabline#show_buffers = 0        " Do NOT show buffers in Tab line
let g:airline#extensions#tabline#show_splits = 1         " Enable the buffer name on the right
let g:airline#extensions#tabline#show_tab_count = 1      " Show Tab numbers on the right
let g:airline#extensions#tabline#show_tab_nr = 0         " Disable tab numbers
let g:airline#extensions#tabline#show_tab_type = 0       " Disables the weird orange arrow on the tabline
let g:airline#extensions#tabline#show_close_button = 0   " Remove 'X' at the end of the tabline
let g:airline#extensions#tabline#tabs_label = ''         " Can put text here like BUFFERS to denote buffers (I clear it so nothing is shown)
let g:airline#extensions#tabline#buffers_label = ''      " Can put text here like TABS to denote tabs (I clear it so nothing is shown)
let g:airline#extensions#tabline#fnamemod = ':t'         " Disable file paths in the tab
let g:airline_section_b = '%{getcwd()}'                  " In section B of the status line display the CWD
let g:airline_powerline_fonts = 1                        " Show powerline font
let g:airline_theme='apprentice'                         " Set status line theme to 'murmur'

if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif
let g:airline_left_sep = '▶'
let g:airline_left_alt_sep = '❯'
let g:airline_right_sep = '◀'
let g:airline_right_alt_sep = '❮'
let g:airline_symbols.linenr = ' L'
let g:airline_symbols.branch = '⎇'

" tt -> Go to next Tab, if reached last one, go to the first Tab
" TT -> Go to previous Tab, if reached first one, go to the last Tab
nnoremap <silent> tt :tabnext<CR>
nnoremap <silent> TT :tabprevious<CR>
nnoremap <silent> <Leader>1 :1tabnext<CR>
nnoremap <silent> <Leader>2 :2tabnext<CR>
nnoremap <silent> <Leader>3 :3tabnext<CR>
nnoremap <silent> <Leader>4 :4tabnext<CR>
nnoremap <silent> <Leader>5 :5tabnext<CR>
nnoremap <silent> <Leader>6 :6tabnext<CR>
nnoremap <silent> <Leader>7 :7tabnext<CR>
nnoremap <silent> <Leader>8 :8tabnext<CR>
nnoremap <silent> <Leader>9 :9tabnext<CR>

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
call g:quickmenu#append('Show Line Number',         'set number relativenumber', '')
call g:quickmenu#append('No Line Number',           'set nonumber norelativenumber', '')
call g:quickmenu#append('CursorLine Reverse',       'highlight CursorLine cterm=reverse', '')
call g:quickmenu#append('Cursor Cross',             'call CursorCrossMode(2)', '')
call g:quickmenu#append('# Git helper', '')
call g:quickmenu#append('Git Status',               'Gstatus', '')
call g:quickmenu#append('Git Diff',                 'Gvdiff', '')
call g:quickmenu#append('Git Blame',                'Gblame', '')
call g:quickmenu#append('# Color Scheme', '')
call g:quickmenu#append('default',                  'colorscheme default', '')
call g:quickmenu#append('desert',                   'colorscheme desert', '')
call g:quickmenu#append('spaceduck',                'colorscheme spaceduck', '')
call g:quickmenu#append('molokai',                  'colorscheme molokai', '')
call g:quickmenu#append('blue',                     'colorscheme blue', '')
call g:quickmenu#append('darkblue',                 'colorscheme darkblue', '')
call g:quickmenu#append('onedark',                  'colorscheme onedark', '')
call g:quickmenu#append('gruvbox',                  'colorscheme gruvbox', '')
call g:quickmenu#append('hybrid',                   'colorscheme hybrid', '')
call g:quickmenu#append('tokyonight',               'colorscheme tokyonight', '')
call g:quickmenu#append('shenzhenwan',              'colorscheme shenzhenwan', '')
call g:quickmenu#append('space-vim-dark',           'colorscheme space-vim-dark', '')

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

" Language Translater
let g:translator_target_lang='zh'
let g:translator_source_lang='en'
let g:translator_default_engines=['bing', 'youdao']
let g:translator_proxy_url=''
let g:translator_history_enable=v:true
let g:translator_window_type='popup'
let g:translator_window_max_width=0.6
let g:translator_window_max_height=0.6
" Display translation in a window
nnoremap <silent> <C-c>y :<C-u>TranslateW<CR>
vnoremap <silent> <C-c>y :<C-u>'<,'>TranslateW<CR>

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

