set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'

" tpope!
Bundle 'tpope/vim-sensible'
Bundle 'tpope/vim-cucumber'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-git'
Bundle 'tpope/vim-haml'
Bundle 'tpope/vim-markdown'
Bundle 'tpope/vim-ragtag'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-unimpaired'
Bundle 'tpope/vim-rvm'
Bundle 'tpope/vim-bundler'
Bundle 'tpope/vim-sleuth'

" Navigation
Bundle 'scrooloose/nerdtree'

" Autocomplete/fuzzy search/ack
Bundle 'bufexplorer.zip'
Bundle 'ervandew/supertab'
Bundle 'kien/ctrlp.vim'
Bundle 'mileszs/ack.vim'

" Languages/editing
Bundle 'vim-ruby/vim-ruby'
Bundle 'bingaman/vim-sparkup'
Bundle 'kchmck/vim-coffee-script'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/syntastic'
Bundle 'JSON.vim'
" Was breaking html.erb indentation
"Bundle 'pangloss/vim-javascript'
Bundle 'airblade/vim-gitgutter'

" objects
Bundle 'vim-indent-object'

" misc
Bundle 'Color-Sampler-Pack'
Bundle 'clones/vim-align'
Bundle 'godlygeek/tabular'
Bundle 'Lokaltog/vim-powerline'
Bundle 'AutoTag'
Bundle 'sjl/gundo.vim'

" Local bundles
if filereadable(glob("~/.vimbundles.local"))
    source ~/.vimbundles.local
endif

filetype plugin indent on     " required!