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

call plug#begin('~/.vim/plugged')
Plug 'itchyny/lightline.vim'
Plug 'scrooloose/nerdtree'
Plug 'majutsushi/tagbar'
Plug 'liuchengxu/vim-which-key'
Plug 'skywind3000/quickmenu.vim'
Plug 'tpope/vim-fugitive'
Plug 'mg979/vim-visual-multi'
Plug 'Yggdroot/indentLine'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'Lokaltog/powerline'
" Color Schemes
Plug 'mrkn/mrkn256.vim'
Plug 'w0ng/vim-hybrid'
Plug 'altercation/vim-colors-solarized'
call plug#end()

set background=light
colorscheme desert

map <F6> :NERDTreeToggle<CR>
map <F8> :TagbarToggle<CR>

set hlsearch
set number
set cursorline
highlight CursorLine cterm=reverse
" set cursorcolumn
" set nocursorcolumn
" highlight CursorColumn cterm=NONE ctermbg=black ctermfg=green guibg=NONE guifg=NONE

" Enter source code directory, do ctags -R
set tags=./tags;,tags
