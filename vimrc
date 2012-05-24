call pathogen#infect()
call pathogen#helptags()

set nocompatible                  " Must come first because it changes other options.

set autoindent

set showcmd                       " Display incomplete commands.
set showmode                      " Display the mode you're in.

set backspace=indent,eol,start    " Intuitive backspacing.

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

set softtabstop=2
set shiftwidth=2
set expandtab                     " Use spaces instead of tabs

set autoread                      " Do not ask when non-modified files have changed

set laststatus=2                  " Show the status line all the time
" Useful status information at bottom of screen
set statusline=[%n]\ %<%.99f\ %h%w%m%r%y\ %{exists('*CapsLockStatusline')?CapsLockStatusline():''}%{fugitive#statusline()}%{SyntasticStatuslineFlag()}%=%-16(\ %l,%c-%v\ %)%P

" Enable folding (commented out since it really slows the rendering)
" set foldmethod=syntax

" Enable a fold column
" set foldcolumn=1

" Don't fold stuff by default
" set foldlevelstart=99

" Highlight line and column when cursor is idle (after 4-5 seconds)
" See http://www.reddit.com/r/vim/comments/t1lhc/cursorcolumn_cursorline_slowdown/
autocmd CursorHold * setlocal cursorline cursorcolumn
autocmd CursorMoved,InsertEnter *
    \ if &l:cursorline | setlocal nocursorline nocursorcolumn | endif

" Split below and right
set splitbelow
set splitright

"colorscheme desert
colorscheme pyte

" Show tabs, trailing whitespaces, extends and precedes
set listchars=tab:>-,trail:·,extends:>,precedes:<,nbsp:+
set list

filetype plugin on
filetype indent on

syntax on

" Buf explorer on Ctrl-B
map <C-b> :BufExplorer<CR>
" Show relative paths in BufExplorer
let g:bufExplorerShowRelativePath=1

" Enable matchit
runtime! macros/matchit.vim


" CtrlP
" ------------------------------------------------------------------------------------
" 'matcher' fuzzy finder for CtrlP, see https://github.com/burke/matcher
let g:path_to_matcher = "/usr/local/bin/matcher"
let g:ctrlp_user_command = ['.git/', 'cd %s && git ls-files . -co --exclude-standard']
let g:ctrlp_match_func = { 'match': 'GoodMatch' }
function! GoodMatch(items, str, limit, mmode, ispath, crfile, regex)

  " Create a cache file if not yet exists
  let cachefile = ctrlp#utils#cachedir().'/matcher.cache'
  if !( filereadable(cachefile) && a:items == readfile(cachefile) )
    call writefile(a:items, cachefile)
  endif
  if !filereadable(cachefile)
    return []
  endif

  " a:mmode is currently ignored. In the future, we should probably do
  " something about that. the matcher behaves like "full-line".
  let cmd = g:path_to_matcher.' --limit '.a:limit.' --manifest '.cachefile.' '
  if !( exists('g:ctrlp_dotfiles') && g:ctrlp_dotfiles )
    let cmd = cmd.'--no-dotfiles '
  endif
  let cmd = cmd.a:str

  return split(system(cmd), "\n")

endfunction

let g:ctrlp_map = '<D-t>'
let g:ctrlp_max_height = 25
let g:ctrlp_extensions = ['buffertag', 'line']
let g:ctrlp_buftag_types = {
  \ 'javascript' : '--language-force=js',
  \ 'coffee'     : '--language-force=coffee',
  \ }

" In insert mode, Commant-T leaves insert mode then opens ctrlp
imap <D-t> <ESC>:CtrlPBufTag<CR>
" Command-Shift-T opens the buffer tag finder (open symbol)
map <D-T> :CtrlPBufTag<CR>
imap <D-T> <ESC>:CtrlPBufTag<CR>
" Command-B opens the buffer finder
map <D-b> :CtrlPBuffer<CR>
imap <D-b> <ESC>:CtrlPBuffer<CR>

" map Leader-e to :e <path of current file>
map <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

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

" Add .mobile.erb and .pdf.erb as html syntax to vim-rails
" Only setting the subtype was not working, I had to reset the filetype once
" the subtype is set. See: https://github.com/vim-ruby/vim-ruby/issues/34
autocmd BufNewFile,BufRead *.mobile.erb let b:eruby_subtype='html'
autocmd BufNewFile,BufRead *.mobile.erb set filetype=eruby
autocmd BufNewFile,BufRead *.pdf.erb let b:eruby_subtype='html'
autocmd BufNewFile,BufRead *.pdf.erb set filetype=eruby

" We are stuck with a non-Rails standard shiftwidth of 4 in our html.erb files in petalmd :(
" See: https://github.com/tpope/vim-rails/issues/unreads#issue/33
" See: :help rails-'shiftwidth' & :help rails-autocommands
autocmd User Rails.view.*erb if getcwd() =~ 'code/petalmd$' | set sw=4 sts=4 | endif
" Indent yaml
autocmd User Rails.config* set smartindent
" Expand tabs in javascript, force tab at 2 (also covers CoffeeScript: Rails.javascript.coffee)
autocmd User Rails.javascript* set expandtab sw=2 sts=2
" Cucumber are indented by 2
autocmd User Rails.cucumber.feature* set sw=2 sts=2

" Add macro to convert sass2 files to sass3 syntax
autocmd FileType sass map <buffer> <Leader>c :!sass-convert -i -f sass2 %<CR>

" CoffeeScript stuff
" Compile coffeescript on save (with -p so it does not save the .js, just check syntax for errors), show cwindow -- commented since now included in Syntastic
":autocmd BufWritePost *.coffee silent CoffeeMake! -p | cwindow
" Leader-C compiles a snippet
autocmd FileType coffee noremap <buffer> <Leader>c :CoffeeCompile 25<CR>

" Add macro to convert js files to CoffeeScript
autocmd FileType javascript noremap <buffer> <Leader>c :!js2coffee %<CR>

" Clear the current search highlight by pressing Esc
nnoremap <silent> <esc> :noh<cr><esc>

" CTags - refresh tags
" jsctags was not that great --
" map <Leader>rt :!jsctags .;ctags -a -R --languages=-JavaScript *<CR><CR>
map <Leader>rt :!ctags --extra=+f --exclude=.git --exclude=log --exclude=compiled -R * `rvm gemdir`/gems/*<CR><CR>

" Disable annoying middle-click paste feature
map <MiddleMouse> <Nop>
imap <MiddleMouse> <Nop>
map <2-MiddleMouse> <Nop>
imap <2-MiddleMouse> <Nop>
map <3-MiddleMouse> <Nop>
imap <3-MiddleMouse> <Nop>
map <4-MiddleMouse> <Nop>
imap <4-MiddleMouse> <Nop>

" NERDTree
map <F6> :NERDTreeToggle<CR>
map <F5> :NERDTreeFind<CR>

" Syntastic
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=1

" vim-ruby-doc
let g:ruby_doc_command='open'

" Always open the quick fix window after a quick fix command
autocmd QuickFixCmdPost *grep* cwindow

" Auto align | in cucumber features
inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align_cukes()<CR>a

function! s:align_cukes()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction

" Route aligning (note, this is dependent on the 'routes' tabular pipeline
" found in ~/.vim/after/plugin

inoremap <silent> : :<Esc>:call <SID>align_routes()<CR>a
noremap <silent> <Leader>tr :Tabularize routes<CR>

function! s:align_routes()
  let p = '\v\s+map.*\s+.*$'
  if exists(':Tabularize') && getline('.') =~# '\v^\s*map' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)

    let column = strlen(substitute(getline('.')[0:col('.')],'[^:]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*:\s*\zs.*'))

    Tabularize routes

    normal! 0
    call search(repeat('[^:]*:',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction

" Close the quickfix window with <Leader>l
noremap <Leader>l :lcl<CR>

" Enable folding by <Leader>f
noremap <Leader>f :setlocal foldmethod=syntax foldcolumn=4<CR>

" Toggle fullscreen with cmd-enter
set fuopt+=maxhorz
map <D-CR> :set invfu<CR>

" Select last pasted text with gp
nnoremap gp `[v`]
