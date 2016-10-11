set nocompatible               " be iMproved

" vim-plug configuration
source ~/.vim/vim-plug.vim

" GENERAL CONFIGURATION

set showcmd                       " Display incomplete commands.
set showmode                      " Display the mode you're in.

set hidden                        " Handle multiple buffers better.

set wildmenu                      " Enhanced command line completion.
set wildmode=list:longest         " Complete files like a shell.
set wildignore+=*/log/**
set wildignore+=*/tmp/**
set wildignore+=*/public/javascripts/compiled/**
set wildignore+=*/.sass-cache/**

set ignorecase                    " Case-insensitive searching.
set smartcase                     " But case-sensitive if expression contains a capital letter.

set number                        " Show line numbers.
set ruler                         " Show cursor position.

set incsearch                     " Highlight matches as you type.
set hlsearch                      " Highlight matches.

set nowrap                        " Turn off line wrapping.
set scrolloff=3                   " Show 3 lines of context around the cursor.

set title                         " Set the terminal's title

set visualbell                    " No beeping.

set nobackup                      " Don't make a backup before overwriting a file.
set nowritebackup                 " And again.
set directory=$HOME/.vim/tmp//,.  " Keep swap files in one location

set autowriteall                  " Save as often as possible
set autoread                      " Do not ask when non-modified files have changed

set laststatus=2                  " Show the status line all the time

set clipboard=unnamed             " Map the mac clipboard to the anonymous register

" Still set defaults for tabs
set expandtab
set shiftwidth=2

" Set fold method -- currently 'manual' for performance reasons (dramatically
" accelerates opening files like routes.rb)
set foldmethod=manual
" Enable a fold column
set foldcolumn=4
" Disable folding by default
set nofoldenable

" Split below and right
set splitbelow
set splitright

" Show tabs, trailing whitespaces, extends and precedes
set list


" PLUGINS ===================================================================


" Buf explorer on Ctrl-B
map <C-b> :BufExplorer<CR>
" Show relative paths in BufExplorer
let g:bufExplorerShowRelativePath=1



" CtrlP
let g:ctrlp_map = '<C-p>'
let g:ctrlp_max_height = 25
let g:ctrlp_extensions = ['buffertag', 'line']
let g:ctrlp_buftag_types = {
      \ 'javascript' : '--language-force=js',
      \ 'coffee'     : '--language-force=coffee',
      \ }
let g:ctrlp_match_func = {'match' : 'matcher#cmatch' }

" In insert mode, Commant-T leaves insert mode then opens ctrlp
"imap <C-t> <ESC>:CtrlPBufTag<CR>
" Command-Shift-T opens the buffer tag finder (open symbol)
map <C-T> :CtrlPBufTag<CR>
imap <C-T> <ESC>:CtrlPBufTag<CR>
" Command-B opens the buffer finder
map <C-b> :CtrlPBuffer<CR>
imap <C-b> <ESC>:CtrlPBuffer<CR>



" NERDTree
map <F6> :NERDTreeToggle<CR>
map <F5> :NERDTreeFind<CR>


" Syntastic
"let g:syntastic_enable_signs=1

" neomake
autocmd! BufWritePost * Neomake
let g:neomake_open_list=2

map <Leader>e :Errors<CR>


" vim-ruby-doc
let g:ruby_doc_command='open'


" vim-airline
let g:airline_powerline_fonts = 1


" ack.vim customization
" Use the_silver_searcher: brew install the_silver_searcher
let g:ackprg = 'ag --nogroup --nocolor --column'


" Sparkup
let g:sparkupArgs = '--no-last-newline --expand-divs'

" vroom
"let g:vroom_use_dispatch = 1
"let g:vroom_use_spring = 1

" vim-test
"let test#ruby#rspec#executable = 'zeus rspec'
nmap <silent> <leader>r :TestFile<CR>
nmap <silent> <leader>R :TestNearest<CR>

" Strip trailing whitespace
function! <SID>StripTrailingWhitespaces()
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  %s/\s\+$//e
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()



"jump to last cursor position when opening a file
"dont do it when writing a commit log entry
autocmd BufReadPost * call SetCursorPosition()
function! SetCursorPosition()
  if &filetype !~ 'commit\c'
    if line("'\"") > 0 && line("'\"") <= line("$")
      exe "normal! g`\""
      normal! zz
    endif
  end
endfunction



" Big magic bunch of code to prevent adding EOL to non-binary files
augroup EOL
  autocmd!
  autocmd BufWritePre * call EolSavePre()
  autocmd BufWritePost * call EolSavePost()
  autocmd BufNewFile * set noeol
augroup END

" If no eol at end of file, set binary so no eol will be added
function! EolSavePre()
  let b:save_bin = &bin
  if ! &eol
    let &l:bin = 1
  endif
endfunction

" Restore binary flag
function! EolSavePost()
  let &l:bin = b:save_bin
endfunction
" END of eol bunch of code


" Autosize quickfix window to content: https://gist.github.com/juanpabloaj/5845848
au FileType qf call AdjustWindowHeight(3, 15)
function! AdjustWindowHeight(minheight, maxheight)
    let l = 1
    let n_lines = 0
    let w_width = winwidth(0)
    while l <= line('$')
        " number to float for division
        let l_len = strlen(getline(l)) + 0.0
        let line_width = l_len/w_width
        let n_lines += float2nr(ceil(line_width))
        let l += 1
    endw
    exe max([min([n_lines, a:maxheight]), a:minheight]) . "wincmd _"
endfunction



" Add .mobile.erb and .pdf.erb as html syntax to vim-ruby
" Only setting the subtype was not working, I had to reset the filetype once
" the subtype is set. See: https://github.com/vim-ruby/vim-ruby/issues/34
augroup ruby_subtypes
  autocmd!
  autocmd BufNewFile,BufRead *.mobile.erb let b:eruby_subtype='html'
  autocmd BufNewFile,BufRead *.mobile.erb set filetype=eruby
  autocmd BufNewFile,BufRead *.pdf.erb let b:eruby_subtype='html'
  autocmd BufNewFile,BufRead *.pdf.erb set filetype=eruby
augroup END

augroup folding
  autocmd BufNewFile,BufReadPost *.coffee setl foldmethod=indent
augroup END



" Clear the current search highlight by pressing Esc
nnoremap <esc><esc> :noh<CR>



" CTags - refresh tags
" jsctags was not that great --
" map <Leader>tt :!jsctags .;ctags -a -R --languages=-JavaScript *<CR><CR>
" Also index gems -- this could be done only once and referred in vim's setup.
" It it still good enough so I didn't try to find how to tweak it.
map <Leader>tt :!ctags --extra=+f --exclude=.git --exclude=log --exclude=compiled --exclude=tmp -R *<CR><CR>

" Disable annoying middle-click paste feature
map <MiddleMouse> <Nop>
imap <MiddleMouse> <Nop>
map <2-MiddleMouse> <Nop>
imap <2-MiddleMouse> <Nop>
map <3-MiddleMouse> <Nop>
imap <3-MiddleMouse> <Nop>
map <4-MiddleMouse> <Nop>
imap <4-MiddleMouse> <Nop>

" Always open the quick fix window after a quick fix command
autocmd QuickFixCmdPost *grep* cwindow

" Close the quickfix window with <Leader>l
noremap <Leader>l :lcl<CR>

" Enable folding by <Leader>f
noremap <Leader>f :setlocal foldmethod=syntax foldcolumn=4<CR>

" Select last pasted text with gp
nnoremap gp `[v`]

" Highlight line and column when cursor is idle (after 4-5 seconds)
" See http://www.reddit.com/r/vim/comments/t1lhc/cursorcolumn_cursorline_slowdown/
augroup cursor
  autocmd!
  autocmd CursorHold * setlocal cursorline cursorcolumn
  autocmd CursorMoved,InsertEnter *
        \ if &l:cursorline | setlocal nocursorline nocursorcolumn | endif
augroup END

" skip paren matching -- it's too slow
if version >= 700
  ":NoMatchParen and :DoMatchParen toggle this
  let loaded_matchparen = 1
endif

" Local overrides
if !has('nvim') && filereadable(glob("~/.vimrc.local"))
    source ~/.vimrc.local
endif

if has('nvim') && filereadable(glob("~/.vimrc.nvim.local"))
  source ~/.vimrc.nvim.local
endif
