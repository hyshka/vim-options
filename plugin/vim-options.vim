"----------------------------------------------------------------------------------------------------------------------
" User Preferences
"----------------------------------------------------------------------------------------------------------------------
" Vim options that neovim has turned on but vim has off/ignores
set nocompatible " Vim is non-compatible with vi. Neovim ignores this
set hlsearch " After a '/' search, highlight the matches

" Set custom leader key
let mapleader="\\" " Set map leader

" For clever completion with the :find command
set path+=**

" Always use bash syntax for sh filetype
let g:is_bash=1

" Search
set ignorecase smartcase
set grepprg=grep\ -IrsnH

" Splits
set splitright " Horizontal Splits go to the right
set splitbelow " Vertical  Splits go underneath

" Buffers
set hidden " Don't abandon buffers when switching between them

" Text display
set list

" Typing behavious
set showmatch
set wildmode=list:longest,full " Completion mode for wildchar
set wildignore=*/app/cache,*/vendor,*/env,*.pyc,*/venv,*/__pycache__ " Ignore useless files
set completeopt=menu,preview,noinsert " Autocomplete options

" Formatting
set nowrap " Turn off TextWrapping
set tabstop=2 " Number of space that tab counts for
set shiftwidth=2 " Number of spaces for each autoindent
set softtabstop=2
"set textwidth=0 " Maximium width of text that is being inserted. 0 disables it
set foldlevelstart=2

" Word splitting (add hyphen)
set iskeyword+=-

" Line numbers
set relativenumber " Use relative numbers
set number " Show line numbers

" Visual aids
set cursorline " highlight current line
"set colorcolumn=120 " display colored column at these line lengths

" Custom status line
set statusline=%!MyStatusLine()

" Limit syntax highlighting to speed up vim in files with large line lengths
set synmaxcol=250
"----------------------------------------------------------------------------------------------------------------------


"----------------------------------------------------------------------------------------------------------------------
" Vim vs Neovim settings
"----------------------------------------------------------------------------------------------------------------------
if has('nvim')
  let $EditorDir=$HOME.'/.config/nvim/'
  silent! execute '!mkdir -p .vimcache/backup'
  " Set Backup dirs
  set backupdir=.vimcache/backup/
  set directory=.vimcache/swp/
else
  " Vim Options
  let $EditorDir=$HOME.'/.vim/'
  " Set Backup dirs
  set backupdir=~/.vim/vim-files/backups/
  set directory=~/.vim/vim-files/swaps/
  "let g:vimwiki_list = [{'path': '~/Wiki/wiki', 'path_html': '~/Wiki/wiki_html/', 'ext': '.markdown'}]
endif
"----------------------------------------------------------------------------------------------------------------------


"----------------------------------------------------------------------------------------------------------------------
" Autocommands
"----------------------------------------------------------------------------------------------------------------------
" Make the modification indicator [+] white on red background
au ColorScheme * hi User1 gui=bold term=bold cterm=bold guifg=white guibg=red ctermfg=white ctermbg=red

" Tweak the color of the fold display column
au ColorScheme * hi FoldColumn cterm=bold ctermbg=233 ctermfg=146

" Spaces Only
au FileType markdown,cpp,vim,sh,html,htmldjango,css,sass,scss,javascript,json,python setl expandtab list

" Tabs Only
au FileType c,h,make setl foldmethod=syntax noexpandtab nolist
au FileType gitconfig,apache,sql setl noexpandtab nolist

" Folding
"au FileType html,htmldjango,css,sass,scss,javascript,python,json setl foldmethod=indent foldenable
au FileType html,htmldjango,css,sass,scss,javascript,python,json setl foldmethod=manual

" Tabstop/Shiftwidth
au FileType javascript,sass,scss setl softtabstop=2 shiftwidth=2 tabstop=2
au FileType json setl shiftwidth=4 softtabstop=4 tabstop=4
"au FileType python,sh, setl softtabstop=4 shiftwidth=4 tabstop=4

" Other
au FileType python let b:python_highlight_all=1
au FileType markdown setl linebreak

" Commentstrings
autocmd FileType htmldjango setlocal commentstring={#\ %s\ #}

" Old
"au BufNewFile,BufRead *.yml set filetype=yaml
"au BufNewFile,BufRead *.sls set filetype=yaml
"au BufRead,BufNewFile *.md set filetype=markdown

" Highlight long lines at 80 mark
au BufNewFile,BufRead * call matchadd('ColorColumn', '\%81v', 100)
" Highlight super long lines
au BufNewFile,BufRead * call matchadd('Error', '\%121v', 100)
"----------------------------------------------------------------------------------------------------------------------

"----------------------------------------------------------------------------------------------------------------------
" Custom Mappings
"----------------------------------------------------------------------------------------------------------------------

" Run shell command
" ... and print output
nnoremap <C-h> :.w !bash<CR>
" ... and append output
nnoremap <C-l> yyp!!bash<CR>

" Select the stuff I just pasted
nnoremap gV `[V`]

" Change indent continuously
vmap < <gv
vmap > >gv

" camelCase => camel_case
vnoremap ,case :s/\v\C(([a-z]+)([A-Z]))/\2_\l\3/g<CR>

" Diff Mode
nnoremap <silent> ,j :if &diff \| exec 'normal ]czz' \| endif<CR>
nnoremap <silent> ,k :if &diff \| exec 'normal [czz' \| endif<CR>
nnoremap <silent> ,p :if &diff \| exec 'normal dp' \| endif<CR>
nnoremap <silent> ,o :if &diff \| exec 'normal do' \| endif<CR>
nnoremap <silent> ZD :if &diff \| exec ':qall' \| endif<CR>

" Insert timestamp
"nnoremap <C-d> "=strftime("%-l:%M%p")<CR>P
"inoremap <C-d> <C-r>=strftime("%-l:%M%p")<CR>

" Turn off syntax highlighting
nnoremap <leader><space> :noh<CR>

" Hardcore Mode
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" Highlighting in vim leaves your cursor wherever you ended at
:vmap y ygv<ESC>

" Formating a json file
com! Formatjson %!python -m json.tool

" Command for figuring out highlight group
map <leader>hi :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">" . " FG:" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"fg#")<CR>

" Faster saving
noremap <leader>w :update<CR>
" Faster quiting
noremap <leader>q :quit!<CR>

" Yank without newline
nmap yY ^y$

" Window switching
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
nnoremap <C-]> <C-w><C-]>

" Create the `tags` file (may need to install ctags first)
command! MakeTags !ctags -R .

nnoremap <C-w>t :tabnew<CR>
" allows incsearch highlighting for range commands
cnoremap <leader>t <CR>:t''<CR>
cnoremap <leader>T <CR>:t''<CR>ddkP
cnoremap <leader>m <CR>:m''<CR>
cnoremap <leader>M <CR>:m''<CR>ddkP
cnoremap <leader>d <CR>:d<CR>``

" clever tab
inoremap <Tab> <C-R>=CleverTab()<CR>

" Use <C-S> to clear the highlighting of :set hlsearch.
nnoremap <C-S> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-S>

" Toggle linenumbers
nnoremap <leader>gn :set number! relativenumber!<CR>

" Shortcut for find command
nnoremap <leader>f :find 

" Snippets
nnoremap <leader>,date :-1read !date +\%F<CR>
nnoremap <leader>,clog :-1read $EditorDir/plugged/vim-options/snippets/javascript/clog.js<CR>jf'a
nnoremap <leader>,fabfile :-1read $EditorDir/plugged/vim-options/snippets/python/fabfile.py<CR>
nnoremap <leader>,cutf8 :-1read $EditorDir/plugged/vim-options/snippets/python/cutf8.py<CR>jf.i
nnoremap <leader>,pudb :-1read $EditorDir/plugged/vim-options/snippets/python/pudb.py<CR>V
nnoremap <leader>,pydef :-1read $EditorDir/plugged/vim-options/snippets/python/pydef.py<CR>/jump<CR>V12j
nnoremap <leader>,pyclass :-1read $EditorDir/plugged/vim-options/snippets/python/pyclass.py<CR>/jump<CR>
"----------------------------------------------------------------------------------------------------------------------

"----------------------------------------------------------------------------------------------------------------------
" Custom Functions
"----------------------------------------------------------------------------------------------------------------------
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
  " Character under cursor (decimal)
  let statusline .= "%03.3b "
  " Character under cursor (hexadecimal)
  let statusline .= "0x%02.2B "
  " File progress
  let statusline .= "| %P/%L"
  return statusline
endfunction

" Taken from ins-completion docs. Tab if only whitespace, autocomplete if
" there is text
function! CleverTab()
  if strpart( getline('.'), 0, col('.')-1 ) =~ '^\s*$'
    return "\<Tab>"
  else
    return "\<C-N>"
  endif
endfunction
"----------------------------------------------------------------------------------------------------------------------

"----------------------------------------------------------------------------------------------------------------------
" Color/Theming Options
"----------------------------------------------------------------------------------------------------------------------

"Colorscheme
let base16colorspace=256  " Access colors present in 256 colorspace
colorscheme base16-tomorrow
set background=light

" disables opaque background
"hi Normal ctermbg=none
"hi NonText ctermbg=none

"" highlight colorcolumn markers
hi ColorColumn ctermbg=20

"" Highligh current cursorline
hi CursorLineNR cterm=bold ctermfg=4

"" Status line colors  per mode
"hi User1 ctermfg=226  ctermbg=8 cterm=bold
"hi User3 ctermfg=4  ctermbg=0
"hi User2 ctermfg=6  ctermbg=0

"" Change gutter color
"highlight SignColumn cterm=NONE ctermfg=0 ctermbg=8

"" Vim diff Colors
"highlight DiffAdd    cterm=BOLD ctermfg=NONE ctermbg=22
"highlight DiffDelete cterm=BOLD ctermfg=NONE ctermbg=52
"highlight DiffChange cterm=BOLD ctermfg=NONE ctermbg=23
"highlight DiffText   cterm=BOLD ctermfg=NONE ctermbg=23
"----------------------------------------------------------------------------------------------------------------------


"----------------------------------------------------------------------------------------------------------------------
" Nerdtree Plugin
"----------------------------------------------------------------------------------------------------------------------
if !empty(glob($EditorDir.'/plugged/nerdtree/plugin/NERD_tree.vim'))
    nnoremap <leader>n :NERDTreeToggle<CR>
    nnoremap <leader>m :NERDTreeFind<CR>
    let g:NERDTreeShowLineNumbers=1
    let g:NERDTreeWinSize = 40
    let g:NERDTreeIgnore = ['\.pyc$']
"    let g:NERDTreeDirArrows=0
"    let g:NERDTreeDirArrowExpandable = '▸'
"    let g:NERDTreeDirArrowCollapsible = '▾'
"    let g:NERDTreeMapOpenSplit = 's'
"    let g:NERDTreeMapPreviewSplit = 'gs'
"    let g:NERDTreeMapOpenVSplit = 'v'
"    let g:NERDTreeMapPreviewVSplit = 'gv'
endif
"----------------------------------------------------------------------------------------------------------------------


"----------------------------------------------------------------------------------------------------------------------
" Indent Lines Plugin
"----------------------------------------------------------------------------------------------------------------------
if !empty(glob($EditorDir.'/plugged/indentline/after/plugin/indentLine.vim'))
  " disable auto-colors
  let g:indentLine_setColors = 0
  " vim
  let g:indentLine_color_term = 18
  " non-X terminal
  let g:indentLine_color_tty_light = 18 " (default: 4)
  let g:indentLine_color_dark = 18 " (default: 2)
  "let g:indentLine_char = '┆'
  let g:indentLine_char = '' " using our patched font
  nnoremap <leader>ig :IndentLinesToggle<CR>
endif
"----------------------------------------------------------------------------------------------------------------------


"----------------------------------------------------------------------------------------------------------------------
" Fugitive
"----------------------------------------------------------------------------------------------------------------------
if !empty(glob($EditorDir.'/plugged/vim-fugitive/plugin/fugitive.vim'))
  nnoremap <leader>gc :Gcommit --verbose<CR>
  nnoremap <leader>gd :Gdiff<CR>
  nnoremap <leader>gl :Glog<CR>
  nnoremap <leader>gb :Gblame<CR>
"  function! ToggleGStatus()
"    if buflisted(bufname('.git/index'))
"      bd .git/index
"    else
"      Gstatus
"    endif
"  endfunction
"  command ToggleGStatus :call ToggleGStatus()
"  nnoremap <leader>gs :ToggleGStatus<CR>
  " Diff commands
  nnoremap <leader>du :diffupdate<CR>
  nnoremap <leader>dd :diffget<CR>
  nnoremap <leader>df :diffput<CR>
  nnoremap _ [c
  nnoremap = ]c
endif
"----------------------------------------------------------------------------------------------------------------------


"----------------------------------------------------------------------------------------------------------------------
" Python-Syntax
"----------------------------------------------------------------------------------------------------------------------
if !empty(glob($EditorDir.'/plugged/python-syntax/syntax/python.vim'))
  let python_highlight_all = 1
endif
"----------------------------------------------------------------------------------------------------------------------


"----------------------------------------------------------------------------------------------------------------------
" CtrlP Plugin
"----------------------------------------------------------------------------------------------------------------------
if !empty(glob($EditorDir.'/plugged/ctrlp.vim/plugin/ctrlp.vim'))
  " Making ctrl-p better and faster
  "if executable('ag')
  "  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  "  let g:ackprg = 'ag --vimgrep'
  "endif
  let g:ctrlp_clear_cache_on_exit = 0
  let g:ctrlp_cache_dir = './.vimcache/ctrlp'
  let g:ctrlp_map = '<Space>p'
  let g:ctrlp_working_path_mode = 'a'
  let g:ctrlp_custom_ignore = 'node_modules\|bower_components\|DS_Store\|git'
  nnoremap <Space>b :CtrlPBuffer<CR>
endif
"----------------------------------------------------------------------------------------------------------------------


"----------------------------------------------------------------------------------------------------------------------
" Markdown
"----------------------------------------------------------------------------------------------------------------------
if !empty(glob($EditorDir.'/plugged/vim-markdown/indent/markdown.vim'))
  let g:vim_markdown_folding_disabled=1
  let g:vim_markdown_conceal = 0 " don't conceal anything, dammit.
endif
"----------------------------------------------------------------------------------------------------------------------


"----------------------------------------------------------------------------------------------------------------------
" Dev-icons
"----------------------------------------------------------------------------------------------------------------------
if !empty(glob($EditorDir.'/plugged/vim-devicons/plugin/webdevicons.vim'))
"  let g:webdevicons_enable_nerdtree = 1
"  let g:webdevicons_enable = 1
"  let g:WebDevIconsNerdTreeGitPluginForceVAlign = 1
  let g:WebDevIconsUnicodeDecorateFolderNodes = 1
  let g:DevIconsEnableFoldersOpenClose = 1
  " make vue files display as js
  let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols = {} " needed
  let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['vue'] = ''
endif
"----------------------------------------------------------------------------------------------------------------------


"----------------------------------------------------------------------------------------------------------------------
" CamelCaseMotion
"----------------------------------------------------------------------------------------------------------------------
if !empty(glob($EditorDir.'/plugged/CamelCaseMotion/plugin/camelcasemotion.vim'))
  map <silent> ,w <Plug>CamelCaseMotion_w
  map <silent> ,e <Plug>CamelCaseMotion_e
  map <silent> ,b <Plug>CamelCaseMotion_b
endif
"----------------------------------------------------------------------------------------------------------------------


"----------------------------------------------------------------------------------------------------------------------
" Vim JSON
"----------------------------------------------------------------------------------------------------------------------
if !empty(glob($EditorDir.'/plugged/vim-json/indent/json.vim'))
  let g:vim_json_syntax_conceal = 0
endif
"----------------------------------------------------------------------------------------------------------------------


"----------------------------------------------------------------------------------------------------------------------
" Ack Searching
"----------------------------------------------------------------------------------------------------------------------
if !empty(glob($EditorDir.'/plugged/ack.vim/plugin/ack.vim'))
  nnoremap <space>/ :call AckSearch()<CR>
  function! AckSearch()
    call inputsave()
    let term = input('Search: ')
    call inputrestore()
    if !empty(term)
        execute "Ack '" . term . "'"
    endif
  endfunction
endif
"----------------------------------------------------------------------------------------------------------------------


"----------------------------------------------------------------------------------------------------------------------
" Syntastic
"----------------------------------------------------------------------------------------------------------------------
if !empty(glob($EditorDir.'/plugged/syntastic/plugin/syntastic.vim'))
  let g:syntastic_javascript_checkers = ['eslint']
  let g:syntastic_css_checkers = ['stylelint']
  " let g:syntastic_css_stylelint_args = '--configFile ~/stylelint.config.js'
  let g:syntastic_scss_checkers = ['stylelint']
  " let g:syntastic_scss_stylelint_args = '--configFile ~/stylelint.config.js'
  let g:syntastic_always_populate_loc_list = 1
  let g:syntastic_auto_loc_list = 0
  let g:syntastic_check_on_open = 1
  let g:syntastic_check_on_wq = 1
  let g:syntastic_aggregate_errors = 1
  let g:syntastic_python_python_exec = '/usr/bin/python3'
  let g:syntastic_mode_map = { 'mode': 'active' }
  function! ToggleSyntasticMode()
python << EOF
import vim
import ast
value = dict(vim.eval('g:syntastic_mode_map'))
vim.command('let l:syntastic_current_mode = \''+value['mode']+'\'')
EOF
    SyntasticToggleMode
    if l:syntastic_current_mode == 'passive'
      SyntasticCheck
    endif
  endfunction
  nnoremap <leader>s :call ToggleSyntasticMode()<CR>
endif
"----------------------------------------------------------------------------------------------------------------------


"----------------------------------------------------------------------------------------------------------------------
" Toggle List
"----------------------------------------------------------------------------------------------------------------------
if !empty(glob($EditorDir.'/plugged/vim-togglelist/plugin/togglelist.vim'))
  noremap <leader>[ :lprevious<CR>
  noremap <leader>] :lnext<CR>
  noremap <leader>p :ll<CR>
  " Disable the mapping it overwrites leader q
  let g:toggle_list_no_mappings = 1
  nmap <script> <silent> <leader>l :call ToggleLocationList()<CR>
endif
"----------------------------------------------------------------------------------------------------------------------


"----------------------------------------------------------------------------------------------------------------------
" Colorizer
"----------------------------------------------------------------------------------------------------------------------
if !empty(glob($EditorDir.'/plugged/colorizer/plugin/ColorizerPlugin.vim'))
  let g:colorizer_auto_filetype='css,scss,sass' " only colorize these extensions
  "let g:colorizer_colornames = 0
endif
"----------------------------------------------------------------------------------------------------------------------


"----------------------------------------------------------------------------------------------------------------------
" Stylefmt
"----------------------------------------------------------------------------------------------------------------------
if !empty(glob($EditorDir.'/plugged/vim-stylefmt/plugin/stylefmt.vim'))
  nnoremap <silent> <leader>cs :Stylefmt<CR>
  vnoremap <silent> <leader>cs :StylefmtVisual<CR>
endif
"----------------------------------------------------------------------------------------------------------------------


"----------------------------------------------------------------------------------------------------------------------
" Javascript Library Syntax
"----------------------------------------------------------------------------------------------------------------------
if !empty(glob($EditorDir.'/plugged/javascript-libraries-syntax.vim/autoload/jslibsyntax.vim'))
  let g:used_javascript_libs = 'jquery,vue'
endif
"----------------------------------------------------------------------------------------------------------------------


"----------------------------------------------------------------------------------------------------------------------
" Clipper (clipboard proxy)
"----------------------------------------------------------------------------------------------------------------------
if !empty(glob($EditorDir.'/plugged/vim-clipper/plugin/clipper.vim'))
  " specify UNIX domain socket to send data over
  let g:ClipperAddress='~/.clipper.sock'
  " disable port number so socket works
  let g:ClipperPort=0
endif
"----------------------------------------------------------------------------------------------------------------------
