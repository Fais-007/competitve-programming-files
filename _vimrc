" Vim with all enhancements
source $VIMRUNTIME/vimrc_example.vim

" Use the internal diff if available.
" Otherwise use the special 'diffexpr' for Windows.
if &diffopt !~# 'internal'
  set diffexpr=MyDiff()
endif
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg1 = substitute(arg1, '!', '\!', 'g')
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg2 = substitute(arg2, '!', '\!', 'g')
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let arg3 = substitute(arg3, '!', '\!', 'g')
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
  let cmd = substitute(cmd, '!', '\!', 'g')
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction

set nocompatible              " be iMproved, required
filetype off                  " required
set ignorecase
set smartcase
" set the runtime path to include Vundle and initialize
set rtp+=C:\Users\user_\vimfiles\bundle\Vundle.vim
call vundle#begin() 
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'scrooloose/syntastic'

" all plugin
Plugin 'scrooloose/nerdtree'
Plugin 'sheerun/vim-polyglot'
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" custom setting
set mouse=a
set number
set encoding=utf-8
set backspace=indent,eol,start
set guioptions=
syntax on

" indent for global
set expandtab
set shiftwidth=8
set softtabstop=8
set autoindent

" indent for special file
autocmd FileType c,cpp setlocal expandtab shiftwidth=4 softtabstop=4 cindent 
autocmd FileType python setlocal expandtab shiftwidth=4 softtabstop=4 autoindent

" open NERDTree automatically when vim starts up on opening a directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

map <silent> <F5> : NERDTreeToggle<CR>

set autowrite
set autoread
set clipboard=unnamed

nnoremap <F2> :!g++ -O2 -Wall -Wl,--stack=268435456 % -o %:r.exe<Enter>
nnoremap <F3> :!%:r.exe
nnoremap <F4> :r d:\Coding\C++\templates\
nnoremap <F7> :r cd .. && cd ..

autocmd BufNewFile *.cpp 0r d:\Coding\C++\templates\skeleton.cpp
autocmd bufnewfile *.cpp exe "1," . 10 . "g/created:.*/s//created: " .strftime("%Y-%m-%d ")."".strftime("%T")
set background=dark

" setup for ctrlp
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

" setup for tagbar
nmap <F8> :TagbarToggle<CR>
au FocusGained,BufEnter * :silent! checktime
au FocusLost,WinLeave * :silent! w
" setup for indent line
let g:indentLine_char = '│'
set tags=./tags,tags;$HOME

