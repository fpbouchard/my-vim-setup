call plug#begin('~/.vim/plugged')

Plug 'Shougo/vimproc.vim', { 'do': 'make' }

" tpope!
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-git'
Plug 'tpope/vim-haml'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-ragtag'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-rvm'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-sleuth'
"Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-vinegar'

" Navigation
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

" Autocomplete/fuzzy search/ack
Plug 'bufexplorer.zip'
"Plug 'ervandew/supertab'
Plug 'Valloric/YouCompleteMe'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'JazzCore/ctrlp-cmatcher'
Plug 'mileszs/ack.vim'

" Languages/editing
Plug 'vim-ruby/vim-ruby'
Plug 'bingaman/vim-sparkup'
Plug 'kchmck/vim-coffee-script'
" Plug 'scrooloose/nerdcommenter'
Plug 'JSON.vim'
Plug 'robbles/logstash.vim'
" Was breaking html.erb indentation
"Plug 'pangloss/vim-javascript'
Plug 'airblade/vim-gitgutter'
"Plug 'Quramy/tsuquyomi'
Plug 'leafgarland/typescript-vim'

" Make/link
" Plug 'scrooloose/syntastic'
Plug 'neomake/neomake'

" objects
Plug 'vim-indent-object'

" tests
"Plug 'skalnik/vim-vroom'
"Plug 'thoughtbot/vim-rspec'
Plug 'janko-m/vim-test'

" misc
"Plug 'clones/vim-align'
Plug 'godlygeek/tabular'
Plug 'bling/vim-airline'
Plug 'AutoTag'

" Local bundles
if !has("nvim") && filereadable(glob("~/.vim-plug.local"))
    source ~/.vim-plug.local
endif
if has("nvim") && filereadable(glob("~/.vim-plug.nvim.local"))
    source ~/.vim-plug.nvim.local
endif

call plug#end()