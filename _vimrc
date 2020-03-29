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



nnoremap <C-J> <C-F>
nnoremap <C-K> <C-B>

vnoremap ,c :s/^/#<CR>
vnoremap ,x :s/^#//<CR>
nnoremap ,c :s/^/#<CR>
nnoremap ,x :s/^#//<CR>

vnoremap { y:s/<C-R>0/\{<C-R>0}<CR>
vnoremap ( y:s/<C-R>0/(<C-R>0)<CR>
vnoremap ' y:s/<C-R>0/'<C-R>0'<CR>
vnoremap " y:s/<C-R>0/"<C-R>0"<CR>

nmap <S-J> <C-W><C-J>
nmap <S-K> <C-W><C-K>
nmap <S-L> <C-W><C-L>
nmap <S-H> <C-W><C-H>


"noremap : ;
"noremap ; :
"inoremap kj <Esc>

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
set statusline+=%F
"set spell spelllang=en_us
"set foldmethod=syntax


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

nnoremap <Leader>b :ls<CR>:b<Space>
nnoremap <Tab> :bn<CR>
nnoremap ,<Tab> :b#<CR>

set wildchar=<Tab> wildmenu wildmode=full

autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent loadview 


"Setting up fzf
"Install plugin manager: copy plug.vim to autoload in install dir
"Copy fzf.exe to vimplugins directory [created in home folder]
"run :PlugInstall
"

set rtp+=C:\CustomSoftware

call plug#begin('C:\CustomSoftware\Vim\plugged')

Plug 'junegunn/fzf', { 'dir': 'C:\CustomSoftware\Vim\plugged\.fzf', 'do': './install --all' }
Plug 'pangloss/vim-javascript'
Plug 'mattn/emmet-vim'
"Plug 'neoclide/coc.nvim', {'tag': '*', 'do': './install.cmd'}
call plug#end()

noremap f :FZF<CR>

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()


" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"


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
