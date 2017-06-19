let mapleader = "\<space>"

" NERDTree
map <silent> <leader>t :NERDTreeToggle<CR>
let g:NERDTreeMapOpenSplit="s"
let g:NERDTreeMapOpenVSplit="v"


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

" Duplicating lines.
nnoremap <silent> <D-d> yyp
imap <silent> <D-d> <esc>yypi

" Remove highlight after search
map <silent> <leader>/ :noh<CR>

" Search for highlighted text
vnoremap // y/<C-R>"<CR>

" Insert spaces using space bar when in normal mode.
nnoremap <silent> <leader><space> a <ESC>h

" Delete to previous line
map <leader>l 0dwi<backspace> <ESC>

" Replaces word with last yanked word
nmap <leader>r viw"0p

" Pastes last word yanked
nmap <leader>p "0p

" Moving lines up/down using [apple]-[shift]-[up]/[down].
nmap <silent> <D-S-down> ddp==
nmap <silent> <D-S-up> ddkP==
imap <silent> <D-S-down> <esc>ddp==i
imap <silent> <D-S-up> <esc>ddkP==i

" Indenting
vmap < <gv
vmap > >gv
nmap > >>
nmap < <<

" Consistency
nmap Y y$

" Prevent paste in visual mode from copying text
xnoremap p "_dp
xnoremap P "_dP

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

" Run q macro
map <silent> <leader>q @q
