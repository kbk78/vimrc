source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

colorscheme desert
hi Visual  guifg=White guibg=darkGrey gui=none

set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar
set guifont=Hack

"set rtp+=C:\ProgramData\chocolatey\lib\fzf\tools

inoremap {} {}<Left>
inoremap () ()<Left>
inoremap [] []<Left>
inoremap '' ''<Left>
inoremap "" ""<Left>
inoremap kj <Esc>

nnoremap <C-J> <C-F>
nnoremap <C-K> <C-B>

vnoremap ,c :s/^/#<CR> /#<CR>
vnoremap ,x :s/^#//<CR>
nnoremap ,c :s/^/#<CR> /#<CR>
nnoremap ,x :s/^#//<CR>



noremap : ;
noremap ; :
set relativenumber
set nu

set nowrap
set clipboard=unnamed
set autowriteall
set autoread
set ignorecase smartcase
set autochdir
set hidden
set cul
set incsearch
set hlsearch



:au FocusLost * silent! wa

" allow the . to execute once for each line of a visual selection
vnoremap . :normal .<CR>

"allow macro to execute once for each line of a visual selection
xnoremap Q :'<,'>:normal @q<CR>


noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

vnoremap // y/<C-R>"<CR>
vnoremap /, /[;,]<CR>y/<C-R>"<CR>

nnoremap <Leader>b :ls<CR>:b<Space>
nnoremap <Tab> :bn<CR>
nnoremap ,<Tab> :b#<CR>

set wildchar=<Tab> wildmenu wildmode=full


"save folds,marks to sessions
:set sessionoptions+=folds
:set viminfo='1000,f1

function! AutoSaveSession()
"saves a session if it exists "**Does not work need to save session manually**
  if (filereadable("session.vim"))
    exe "mks! " . "session.vim"
    echo 'Session saved'
  endif
endfunction

au VimLeave * :call AutoSaveSession()

function! AutoLoadSession()
"loads a session if it exists
  if (filereadable("session.vim"))
    exe 'source session.vim'
  endif
endfunction

au VimEnter * :call AutoLoadSession()



set diffexpr=MyDiff()
function MyDiff()
    let opt = '-a --binary '
    if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
    if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
    let arg1 = v:fname_in
    if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
    let arg2 = v:fname_new
    if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
    let arg3 = v:fname_out
    if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
    if $VIMRUNTIME =~ ' '
        if &sh =~ '\<cmd'
            if empty(&shellxquote)
                let l:shxq_sav = ''
                set shellxquote&
            endif
            let cmd = '"' . $VIMRUNTIME . '\diff"'
        else
            let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
        endif
    else
        let cmd = $VIMRUNTIME . '\diff'
    endif
    silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
    if exists('l:shxq_sav')
        let &shellxquote=l:shxq_sav
    endif
endfunction
