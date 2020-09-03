set nocompatible              " be iMproved, required
filetype off                  " required
syntax syntastic_check_on_wq
set ignorecase
set smartcase
" set the runtime path to include Vundle and initialize
set rtp+=$HOME\.vim\bundle\Vundle.vim
call vundle#begin() 
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" all plugin
Plugin 'vim-syntastic/syntastic'

Plugin 'google/vim-maktaba'
Plugin 'google/vim-codefmt'
Plugin 'google/vim-glaive'

Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
Plugin 'honza/vim-snippets'
Plugin 'drewtempelmeyer/palenight.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'vim-airline/vim-airline'
Plugin 'Raimondi/delimitMate'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'majutsushi/tagbar'
Plugin 'Yggdroot/indentLine'
Plugin 'cjuniet/clang-format.vim'
Plugin 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
    \ 'branch': 'release/1.x'
      \ }

" All of your Plugins must be added before the following line
call vundle#end()            " required
call glaive#Install()        " enable this line after the installation of glaive
filetype plugin indent on    " required

" custom setting
set mouse=a
set number
set encoding=utf-8
set backspace=indent,eol,start
set cursorline
set guioptions=
syntax on

" indent for global
set expandtab
set shiftwidth=4
set softtabstop=4
set autoindent

" indent for special file
autocmd FileType c,cpp setlocal expandtab shiftwidth=4 softtabstop=4 cindent 
autocmd FileType python setlocal expandtab shiftwidth=4 softtabstop=4 autoindent

" setup for syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 0
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_python_checkers = ['flake8']
let g:prettier#config#trailing_comma = 'none'

" open NERDTree automatically when vim starts up on opening a directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

map <silent> <F5> : NERDTreeToggle<CR>

set autowrite
set autoread

nnoremap <F2> :!g++ -O2 -Wall -Wl,--stack=268435456 % -o %:r.exe<Enter>
nnoremap <F3> :!%:r.exe
nnoremap <F4> :r d:\Coding\C++\templates\
nnoremap <F7> :r cd .. && cd ..

" autoformat
augroup autoformat_settings
    autocmd FileType c,cpp,proto,javascript AutoFormatBuffer clang-format
     autocmd FileType python AutoFormatBuffer yapf
augroup END

autocmd BufNewFile *.cpp 0r d:/Coding/C++/templates/skeleton.cpp
autocmd bufnewfile *.cpp exe "1," . 10 . "g/created:.*/s//created: " .strftime("%Y-%m-%d ")."".strftime("%T")
" use google style for clang-format
Glaive codefmt clang_format_style='google'
set background=dark
colorscheme palenight

:autocmd BufWritePost *.cpp execute '%!astyle'

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

