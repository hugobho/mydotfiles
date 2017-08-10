let mapleader = "\<space>"

" ------------- STYLE --------------

" Tab indenting
set tabstop=2
set expandtab
set shiftwidth=2
set softtabstop=2
set ai " Autoindent

" Color scheme
colorscheme flattened_light
let g:ariline_them = 'flatten_light'

" Searching
set incsearch
set hlsearch

" Misc
set nobackup          " Don't create backup files
set nowritebackup     " Don't create backup files
set noswapfile        " No .swp files
set spelllang=en_us   " Set spell check language
set nowrap            " Disable line wrapping
set autoread          " Read changes on a file when it is changed
set clipboard=unnamed " Make vim share clipboard with system

" Only display cursorline on active pane
" From: http://stackoverflow.com/questions/12017331/how-can-i-make-vim-highlight-the-current-line-on-only-the-active-buffer
augroup CursorLine
au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline cursorcolumn
  au WinLeave * setlocal nocursorline nocursorcolumn
augroup END

" ----------- APPEARANCE -----------

set laststatus=2     " Always show the statusline
set number           " Show line numbers
set title            " Display filename in title bar
set cursorline       " Adds highlighted line on current line
set cursorcolumn     " Adds highlighted line on current column
set scrolloff=20     " set minimum space between the cursor and window
set ttyfast          " Faster scrolling
set guioptions-=r    " remove right scrollbar
set guioptions-=R    " remove right scrollbar
set guioptions-=l    " remove right scrollbar
set guioptions-=L    " remove right scrollbar
set guicursor=a:blinkon300-blinkoff250

" This line enables the true colour support.
set termguicolors

" ----------- MAPPINGS -------------

" Remove highlight after search
map <silent> <leader>/ :noh<CR>

" Search for highlighted text
vnoremap // y/<C-R>"<CR>

" Insert spaces using space bar when in normal mode.
nnoremap <silent> <leader><space> a <ESC>h

" Indenting
vmap < <gv
vmap > >gv
nmap > >>
nmap < <<

" Consistency
nmap Y y$

" Run q macro
map <silent> <leader>q @q

" Prevent paste in visual mode from copying text
xnoremap p "_dp
xnoremap P "_dP

" Delete to previous line
map <leader>l 0dwi<backspace> <ESC>

" Replaces word with last yanked word
nmap <leader>r viw"0p

" Pastes last word yanked
nmap <leader>p "0p

" Window management
nmap <silent> <C-h> :wincmd h<CR>
nmap <silent> <C-j> :wincmd j<CR>
nmap <silent> <C-k> :wincmd k<CR>
nmap <silent> <C-l> :wincmd l<CR>

" Function Resize - resizes split panes like tmux does:
" When focus is on the last pane it reverses resizing
fun! Resize(direction, scalar, notLastCommand, lastCommand)
  let startWinnr = winnr()
  exec "normal! " . a:direction
  if winnr() == startWinnr
    " We are on the last pane use lastCommand
    exec "normal! " . a:scalar . "" . a:lastCommand
  else
    exec startWinnr . "wincmd w"
    " We are not on the last pane use notLastCommand
    exec "normal! " . a:scalar . "" . a:notLastCommand
  endif
endfun

nmap <leader>h :call Resize('l', 1, '<', '>')<CR>
nmap <leader>l :call Resize('l', 1, '>', '<')<CR>
nmap <leader>j :call Resize('j', 1, '+', '-')<CR>
nmap <leader>k :call Resize('j', 1, '-', '+')<CR>

nmap <leader>H :call Resize('l', 10, '<', '>')<CR>
nmap <leader>L :call Resize('l', 10, '>', '<')<CR>
nmap <leader>J :call Resize('j', 10, '+', '-')<CR>
nmap <leader>K :call Resize('j', 10, '-', '+')<CR>


" ----------- PLUGINS -------------

" NERDTree
map <silent> <leader>t :NERDTreeToggle<CR>
let g:NERDTreeMapOpenSplit="s"
let g:NERDTreeMapOpenVSplit="v"

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ea <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ea <Plug>(EasyAlign)

" Vim Go
" Disable :GoDef 'gd' mapping
let g:go_def_mapping_enabled = 0
" run goimports on save
let g:go_fmt_command = "goimports"

" ------------- GIT ---------------

" Vim diff
fun! DiffUpdate()
  if &diff
    diffupdate
  endif
endfun
autocmd InsertLeave * call DiffUpdate()
noremap <leader>g :diffget \| diffupdate<CR>
noremap <leader>p :diffput \| diffupdate<CR>

" Git/fugitive shortcuts
nmap gd :Gdiff<CR>
nmap g3d :Gdiff HEAD<CR><C-W>l:Gdiff<CR>
nmap gs :Gministatus<CR>
nmap gcm :Gcommit<CR>:set spell<CR><C-W>Ki
nmap git :Git

" Find merge conflicts
nmap gmc /\v^[<=>\|]{7}.*$<CR>

" Vim fugitive
set diffopt+=vertical

" ---------- AUTO COMMANDS ---------

" Reset cursor to '_' (horizontal + 100% char width) on leave
autocmd VimLeave * set guicursor=a:hor100-blinkwait200-blinkon400-blinkoff250

" Strip whitespace on save
autocmd BufWritePre * :%s/\s\+$//e


" ----------- TERMINAL -------------

" Map <Esc> to exit terminal mode
tnoremap <Esc> <C-\><C-n>

" Open new Terminal vertically
nmap tt :vs<CR>:term<CR>
" Open new Terminal horizontally
nmap th :sp<CR>:term<CR>



" ----------- PLUGINS --------------

so ~/.config/nvim/plugin/airline.vim
call plug#begin()

" Plug 'kien/ctrlp.vim'
Plug 'Shougo/neocomplete.vim'
Plug 'Valloric/MatchTagAlways'
Plug 'airblade/vim-gitgutter'
Plug 'alexdavid/nerdtree_icons'
Plug 'alexdavid/vim-min-git-status'
Plug 'alvan/vim-closetag'
Plug 'digitaltoad/vim-pug'
Plug 'elzr/vim-json'
Plug 'ervandew/supertab'
Plug 'fatih/vim-go'
Plug 'gkz/vim-ls'
Plug 'hashivim/vim-terraform'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/vim-easy-align'
Plug 'mxw/vim-jsx'
Plug 'othree/html5.vim'
Plug 'pangloss/vim-javascript'
Plug 'rking/ag.vim'
Plug 'romainl/flattened'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'wavded/vim-stylus'

call plug#end()
