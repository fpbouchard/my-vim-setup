set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'

" tpope!
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

" Navigation
Bundle 'scrooloose/nerdtree'

" Autocomplete/fuzzy search/ack
Bundle 'bufexplorer.zip'
Bundle 'ervandew/supertab'
Bundle 'kien/ctrlp.vim'
Bundle 'mileszs/ack.vim'

" Languages/editing
Bundle 'bingaman/vim-sparkup'
Bundle 'kchmck/vim-coffee-script'
Bundle 'pangloss/vim-javascript'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/syntastic'
Bundle 'vim-ruby/vim-ruby'
Bundle 'JSON.vim'

" misc
Bundle 'Color-Sampler-Pack'
Bundle 'clones/vim-align'
Bundle 'godlygeek/tabular'

" objects
Bundle 'vim-indent-object'
Bundle 'coderifous/textobj-word-column.vim'

filetype plugin indent on     " required!