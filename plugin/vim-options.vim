"----------------------------------------------------------------------------------------------------------------------
" KEY MAPS
"----------------------------------------------------------------------------------------------------------------------

" Useful macros I use the most
nmap \A :set formatoptions+=a<CR>:echo "autowrap enabled"<CR>
nmap \a :set formatoptions-=a<CR>:echo "autowrap disabled"<CR>
nmap \d :ALEToggleBuffer<CR>
nmap \g :Gstatus<CR>
nmap \l :setlocal number! relativenumber!<CR>:setlocal number? relativenumber?<CR> 
nmap \o :set paste!<CR>:set paste?<CR>
nmap \q :nohlsearch<CR>
nmap \u :setlocal list!<CR>:setlocal list?<CR>
nmap \w :setlocal wrap!<CR>:setlocal wrap?<CR>
nmap \x :cclose<CR> " close quickfix
nmap \t :%s/\s\+$//e " remove trailing spaces from buffer
nmap \p :! prettier --no-semi --trailing-comma es5 --write %<CR> " visually format JS/CSS/Sass
nmap \h :syntax sync fromstart<CR> " refresh syntax highlighting
" nmap \z :w<CR>:!open %<CR><CR>

" Set custom leader key
let mapleader = ","
let maplocalleader = ","

" Turn off linewise keys. Normally, the `j' and `k' keys move the cursor down one entire line. with
" line wrapping on, this can cause the cursor to actually skip a few lines on the screen because
" it's moving from line N to line N+1 in the file. I want this to act more visually -- I want `down'
" to mean the next line on the screen
nmap j gj
nmap k gk

" Edit last buffer
nmap <C-e> :e#<CR>

" Use the space key to toggle folds
nnoremap <space> za
vnoremap <space> zf

" Super fast window movement shortcuts
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
nnoremap <C-]> <C-w><C-]>

" Resize panes when window/terminal gets resize
autocmd VimResized * :wincmd =

" Search for the word under the cursor in the current directory
" nmap <M-k>    :Ack! "<cword>" <CR>
" nmap <Esc>k   :Ack! "<cword>" <CR>
" nmap <M-S-k>  :Ggrep! "<cword>" <CR>
" nmap <Esc>K   :Ggrep! "<cword>" <CR>

" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

" Highlighting in vim leaves your cursor wherever you ended at
:vmap y ygv<ESC>

" Select the stuff I just pasted
nnoremap gV `[V`]

" Change indent continuously
vmap < <gv
vmap > >gv

" camelCase => snake_case
vnoremap <leader>case :s/\v\C(([a-z]+)([A-Z]))/\2_\l\3/g<CR>

" Snippets
nnoremap <leader>date :read !date +\%F<CR>
nnoremap <leader>fabfile :-1read $EditorDir/plugged/vim-options/snippets/python/fabfile.py<CR>
nnoremap <leader>cutf8 :-1read $EditorDir/plugged/vim-options/snippets/python/cutf8.py<CR>jf.i
nnoremap <leader>pudb :-1read $EditorDir/plugged/vim-options/snippets/python/pudb.py<CR>V
nnoremap <leader>pydef :-1read $EditorDir/plugged/vim-options/snippets/python/pydef.py<CR>/jump<CR>V12j
nnoremap <leader>pyclass :-1read $EditorDir/plugged/vim-options/snippets/python/pyclass.py<CR>/jump<CR>
nnoremap <leader>pydev :0read $EditorDir/plugged/vim-options/snippets/python/local_dev.py<CR>/jump<CR>
nnoremap <leader>ps :-1read $EditorDir/plugged/vim-options/snippets/javascript/performance-start.js<CR>
nnoremap <leader>pe :-1read $EditorDir/plugged/vim-options/snippets/javascript/performance-end.js<CR>


""" REVIEW
" Insert timestamp
"nnoremap <C-d> "=strftime("%-l:%M%p")<CR>P
"inoremap <C-d> <C-r>=strftime("%-l:%M%p")<CR>

" Create the `tags` file (may need to install ctags first)
" command! MakeTags !ctags -R .

" Use <C-S> to clear the highlighting of :set hlsearch.
" nnoremap <C-S> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-S>

" Toggle linenumbers
" nnoremap <leader>gn :set number!<CR>

" Diff Mode
" nnoremap <silent> ,j :if &diff \| exec 'normal ]czz' \| endif<CR>
" nnoremap <silent> ,k :if &diff \| exec 'normal [czz' \| endif<CR>
" nnoremap <silent> ,p :if &diff \| exec 'normal dp' \| endif<CR>
" nnoremap <silent> ,o :if &diff \| exec 'normal do' \| endif<CR>
" nnoremap <silent> ZD :if &diff \| exec ':qall' \| endif<CR>

" Vimdiff commands
" nnoremap <leader>du :diffupdate<CR>
" nnoremap <leader>dd :diffget<CR>
" nnoremap <leader>df :diffput<CR>
" nnoremap _ [c
" nnoremap = ]c
""" END REVIEW


" ----------------------------------------------------------------------------
" ABBREVATIONS
" ----------------------------------------------------------------------------

" Typing `$c` on the command line expands to `:e` + the current path, so it's easy to edit a file in
" the same directory as the current file.
cnoremap $c e <C-\>eCurrentFileDir()<CR>
function! CurrentFileDir()
  return "e " . expand("%:p:h") . "/"
endfunction

" Debugging helpers
autocmd BufEnter *.py iabbr xxx print('XXX
autocmd BufEnter *.py iabbr yyy print('YYY
autocmd BufEnter *.py iabbr zzz print('ZZZ
autocmd BufEnter *.js iabbr xxx console.log('XXX',
autocmd BufEnter *.js iabbr yyy console.log('YYY',
autocmd BufEnter *.js iabbr zzz console.log('ZZZ',


" ----------------------------------------------------------------------------
" OPTIONS
" ----------------------------------------------------------------------------

" Set confirg paths
if has('nvim')
  let $EditorDir=$HOME.'/.config/nvim/'
else
  " Vim Options
  let $EditorDir=$HOME.'/.vim/'
endif

set nocompatible " Vim is non-compatible with vi. Neovim ignores this
set autowrite               " Write on :next/:prev/^Z
set cindent                 " Automatic program indenting
set cinkeys-=0#             " Comments don't fiddle with indenting
set cino=                   " See :h cinoptions-values
set commentstring=\ \ #%s   " When folds are created, add them to this
set copyindent              " Make autoindent use the same chars as prev line
set directory-=.            " Don't store temp files in cwd
set expandtab               " No tabs
set fileformats=unix,dos,mac  " Prefer Unix
set fillchars=vert:\ ,stl:\ ,stlnc:\ ,fold:-,diff:┄
                            " Unicode chars for diffs/folds, and rely on
                            " Colors for window borders
set foldmethod=indent       " Use indent by default
set foldlevel=3
set formatoptions=cqjn1     " t - autowrap normal text
                            " c - autowrap comments
                            " q - gq formats comments
                            " n - autowrap lists
                            " 1 - break _before_ single-letter words
                            " 2 - use indenting from 2nd line of para
set hidden                  " Don't prompt to save hidden windows until exit
set hlsearch                " Hilight searching
set ignorecase              " Case insensitive
set infercase               " Completion recognizes capitalization
set linebreak               " Break long lines by word, not char
set list                    " Show whitespace as special chars - see listchars
set listchars=tab:»\ ,extends:›,precedes:‹,nbsp:·,trail:· " Unicode characters for various things
set matchtime=2             " Tenths of second to hilight matching paren
set modelines=5             " How many lines of head & tail to look for ml's
silent! set mouse=nvc       " Use the mouse, but not in insert mode
set nobackup                " No backups left after done editing
set nowritebackup           " No backups made while editing
set visualbell t_vb=        " No flashing or beeping at all
set printoptions=paper:letter " US paper
set number                  " show line numbers
set relativenumber          " Use relative numbers
set shiftround              " Shift to certain columns, not just n spaces
set shiftwidth=2            " Number of spaces to shift for autoindent or >,<
set shortmess+=A            " Don't bother me when a swapfile exists
set showmatch               " Hilight matching braces/parens/etc.
set smartcase               " Lets you search for ALL CAPS
set softtabstop=2           " Spaces 'feel' like tabs
set suffixes+=.pyc          " Ignore these files when tab-completing
" set textwidth=80            " TODO: set local markdown, text files, etc.
set notitle                 " Don't set the title of the Vim window
set wildmenu                " Show possible completions on command line
set wildmode=list:longest,full " List all options and complete
set wildignore=*/app/cache,*/vendor,*/env,*.pyc,*/venv,*/__pycache__,*/.git,*/node_modules  " Ignore certain files in tab-completion
set splitright              " Horizontal Splits go to the right
set splitbelow              " Vertical  Splits go underneath
set grepprg=grep\ -IrsnH    " TODO: document these options
" set cursorline              " highlight current line
" set statusline=%!MyStatusLine() " Custom status line
" set synmaxcol=250           " Limit syntax highlighting to speed up vim in files with large line lengths
" set omnifunc=syntaxcomplete#Complete " Enable omni-completion based off of syntax
set noshowmode              " Don't need this anymore due to lightline plugin
set shell=bash " Use bash in terminal mode
set nowrap " Turn off TextWrapping

" Essential for filetype plugins.
filetype plugin indent on

""" REVIEW """
" let g:is_bash=1             " Always use bash syntax for sh filetype
" set completeopt+=menuone,noinsert " Autocomplete options
" set completeopt-=preview " Hide the preview/scratch window
" set iskeyword+=- " Word splitting (add hyphen)
" set lazyredraw " Don't redraw while executing macros (good performance config)
""" END REVIEW """


" ----------------------------------------------------------------------------
" CUSTOM COMMANDS AND FUNCTIONS
" ----------------------------------------------------------------------------

" I always hit ":W" instead of ":w" because I linger on the shift key...
command! Q q
command! W w

" Trim spaces at EOL and retab. I run `:CLEAN` a lot to clean up files.
command! TEOL %s/\s\+$//
command! CLEAN retab | TEOL

" Close all buffers except this one
command! BufCloseOthers %bd|e#

function! MyStatusLine()
  let statusline = ""
  " Filename (F -> full, f -> relative)
  let statusline .= "%f"
  " Buffer flags
  let statusline .= "%( %h%1*%m%*%r%w%) "
  " File format and type
  let statusline .= "(%{&ff}%(\/%Y%))"
  " Left/right separator
  let statusline .= "%="
  " Line & column
  let statusline .= "(%l,%c%V) "
  " File progress
  let statusline .= "| %P/%L"
  return statusline
endfunction


"----------------------------------------------------------------------------------------------------------------------
" COLORS
"----------------------------------------------------------------------------------------------------------------------

" Make sure colored syntax mode is on, and make it Just Work with 256-color terminals.
set background=light
colorscheme solarized


" ----------------------------------------------------------------------------
" PLUGIN SETTINGS
" ----------------------------------------------------------------------------

" FZF (replaces Ctrl-P, FuzzyFinder and Command-T)
nmap ; :Buffers<CR>
nmap <Leader>r :Tags<CR>
nmap <Leader>t :Files<CR>

" Tell ack.vim to use ag (the Silver Searcher) instead
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" GitGutter styling to use · instead of +/-
" let g:gitgutter_sign_added = '∙'
" let g:gitgutter_sign_modified = '∙'
" let g:gitgutter_sign_removed = '∙'
" let g:gitgutter_sign_modified_removed = '∙'

" SuperTab
let g:SuperTabLongestEnhanced=1
let g:SuperTabLongestHighlight=1

" ALE
" let g:ale_enabled = 0
" let g:ale_lint_on_enter = 0
" let g:ale_lint_on_text_changed = 'never'
" let g:ale_python_mypy_options='--ignore-missing-imports'
" let g:ale_fixers = {
"   \'javascript': ['eslint'],
"   \'scss': ['stylelint'],
" \}
" let g:ale_sign_warning = '▲'
" let g:ale_sign_error = '✗'
" highlight link ALEWarningSign String
" highlight link ALEErrorSign Title
" TODO: navigate between errors quickly
" nmap <silent> <C-k> <Plug>(ale_previous_wrap)
" nmap <silent> <C-j> <Plug>(ale_next_wrap)

" CamelCaseMotion
" map <silent> <leader>w <Plug>CamelCaseMotion_w
" map <silent> <leader>e <Plug>CamelCaseMotion_e
" map <silent> <leader>b <Plug>CamelCaseMotion_b

" if you don't want to jump to first result...
cnoreabbrev Ack Ack!
nnoremap <Leader>a :Ack!<Space>
noremap <Leader>A :Ack! <cword><cr>

" Ranger Integration
let g:ranger_map_keys = 0
let g:ranger_replace_netrw = 1 " open ranger when vim open a directory
nnoremap <leader>m :Ranger<CR>
nnoremap <leader>n :RangerWorkingDirectory<CR>

" Lightline
let g:lightline = {
  \ 'colorscheme': 'solarized',
  \ }

" Argwrap
nnoremap <leader>W :ArgWrap<CR>
let g:argwrap_tail_comma = 1

" vim-pbcopy
" neovim (inside docker container) and vim
if has('nvim')
  let g:vim_pbcopy_local_cmd = "nc -w 0 172.17.0.1 41401"
  let g:vim_pbcopy_remote_cmd = "nc -w 0 172.17.0.1 41401"
else
  let g:vim_pbcopy_local_cmd = "nc -w 0 localhost 41401"
  let g:vim_pbcopy_remote_cmd = "nc -w 0 localhost 41401"
endif

" indent guides
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_auto_colors = 0
let g:indent_guides_guide_size = 0
let g:indent_guides_exclude_filetypes = ['help', 'markdown']
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=white   ctermbg=15
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=lightgray ctermbg=7


" ----------------------------------------------------------------------------
" FILE TYPE TRIGGERS
" ----------------------------------------------------------------------------

" Reset all autocommands
augroup vimrc
autocmd!

au BufNewFile,BufRead *.gyp     set ft=python
au BufNewFile,BufRead *.html    setlocal nocindent smartindent
au BufNewFile,BufRead *.ini     setf conf
au BufNewFile,BufRead *.json    set ft=json tw=0
au BufNewFile,BufRead *.less    setlocal ft=less nocindent smartindent
au BufNewFile,BufRead *.md      setlocal ft=markdown nolist wrap " spell < disable spellchecker until I set up persistant wordlists
au BufNewFile,BufRead *.md      setlocal formatoptions+=t " t - autowrap normal text
au BufNewFile,BufRead *.md,*.markdown setlocal foldlevel=999 tw=0 nocin
au BufNewFile,BufRead *.rb      setlocal noai
au BufNewFile,BufRead *.sass    setf sass
au BufNewFile,BufRead *.xml     setlocal ft=xml  ts=2 sw=2 et
au BufNewFile,BufRead *.zsh     setf zsh
au BufNewFile,BufRead *templates/*.html setf htmldjango
au BufNewFile,BufRead .git/config setlocal ft=gitconfig nolist ts=4 sw=4 noet
au BufNewFile,BufRead .gitconfig* setlocal ft=gitconfig nolist ts=4 sw=4 noet
au BufNewFile,BufRead /tmp/crontab* setf crontab
au BufNewFile,BufRead COMMIT_EDITMSG setlocal nolist nonumber
au BufNewFile,BufRead Makefile setlocal nolist

au FileType gitcommit setlocal nolist ts=4 sts=4 sw=4 noet
au FileType json setlocal conceallevel=0 foldmethod=syntax foldlevel=999
au FileType make setlocal nolist ts=4 sts=4 sw=4 noet
au FileType markdown syn sync fromstart
au Filetype gitcommit setlocal tw=80
au FileType htmldjango setlocal commentstring={#\ %s\ #} " use django single line comments

au BufNewFile,BufRead * call matchadd('ColorColumn', '\%81v', 80) " Highlight long lines at 80 mark
au BufNewFile,BufRead * call matchadd('Error', '\%121v', 100) " Highlight super long lines

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Folding
"au FileType html,htmldjango,css,sass,scss,javascript,python,json setl foldmethod=indent foldenable
" au FileType html,htmldjango,css,sass,scss,javascript,python,json setl foldmethod=manual

augroup END

" vim:set tw=100:
