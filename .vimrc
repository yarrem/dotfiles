set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set nobackup		" do not keep a backup file, use versions instead
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
set hidden " if hidden is not set, TextEdit might fail
set cmdheight=2 " Better display for messages
set updatetime=300 " Smaller updatetime for CursorHold & CursorHoldI
set shortmess+=c " don't give |ins-completion-menu| messages.
set signcolumn=yes " always show signcolumns
set laststatus=2
set completeopt=longest,menuone,preview
set previewheight=5
set wildignore+=*.*~

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") >= 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

if has('langmap') && exists('+langnoremap')
  " Prevent that the langmap option applies to characters that result from a
  " mapping.  If unset (default), this may break plugins (but it's backward
  " compatible).
  set langnoremap
endif

" Line numbers
:set number relativenumber

" Center screen around cursor
:set so=999

" My own settings:
syntax on " Switch syntax highlighting on, when the terminal has colors
set hlsearch " Also switch on highlighting the last used search pattern.
set listchars=trail:~,tab:··
set list
set cursorline
set encoding=utf-8
set fileencoding=utf-8
set tabstop=4 softtabstop=0 shiftwidth=4 expandtab smarttab
set foldmethod=syntax
set foldnestmax=5
set foldlevelstart=20
set spell spelllang=en_us
set ignorecase
set smartcase
set showmatch
set bg=dark
set splitbelow " Set preview window to appear at bottom
set noshowmode " Don't dispay mode in command line (airilne already shows it)
set autoread " Automatically re-read file if a change was detected outside of vim
set redrawtime=10000
"set termguicolors
map ; :
nnoremap <SPACE> <Nop>
let g:mapleader=' ' " Remap leader key to space
" autoclose tags
inoremap ( ()<Left>
inoremap { {}<Left>
inoremap [ []<Left>
inoremap <> <><Left>
inoremap "" ""<Left>
inoremap ' ''<Left>
inoremap ` ``<Left>
" elixir mappings
inoremap fn- fn ->  end<Left><Left><Left><Left>
inoremap def<Space> def  do<CR>end<Esc>k<Right>a
inoremap defp<Space> defp  do<CR>end<Esc>k<Right><Right>a
inoremap defmo defmodule  do<CR>end<Esc>k<Right><Right><Right><Right><Right><Right><Right>a
inoremap do<Enter> do<CR>end<Esc>O
inoremap @typet<Space> @type t :: %__MODULE__{}<Left><Enter><Esc>O
inoremap @typet( @type t() :: %__MODULE__{}<Left><Enter><Esc>O
inoremap defd defdelegate (), to:<Left><Left><Left><Left><Left><Left><Left>
" create new buffer
nnoremap <Leader>B :enew<CR>
" close current buffer
nnoremap <Leader>bq :bp <bar> bd! #<CR>
" switch to next open buffer
nnoremap <Leader>bn :bnext<CR>
" switch to previous open buffer
nnoremap <Leader>bp :bprevious<CR>
" cycle between last two open buffers
nnoremap <Leader><Leader> <c-^>
" <Ctrl-l> redraws the screen and removes any search highlighting.
nnoremap <silent> <C-l> :nohl<CR><C-l>
nnoremap <C-]> :vertical resize +10<CR>
nnoremap <C-[> :vertical resize -10<CR>

" ================================================================================================================================= "
" ===                                                    Plugin Installation                                                    === "
" ================================================================================================================================= "

if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" vim-plug setup (https://github.com/junegunn/vim-plug)
" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
call plug#begin('~/.vim/plugged')
" ctgas
Plug 'ludovicchabant/vim-gutentags'
Plug 'majutsushi/tagbar'

Plug 'ctrlpvim/ctrlp.vim'
Plug 'arcticicestudio/nord-vim'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-commentary'
Plug 'pangloss/vim-javascript'
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'

" git
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'

" Language syntax highlight
Plug 'sheerun/vim-polyglot'

" typescript
Plug 'ianks/vim-tsx'

" lsp client
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete.vim'

Plug 'Quramy/vim-js-pretty-template'
Plug 'Yggdroot/indentLine'
Plug 'kien/rainbow_parentheses.vim'
Plug 'mhinz/vim-signify'
Plug 'othree/html5.vim'
Plug 'SirVer/ultisnips'

" Elixir/Phoenix
Plug 'elixir-editors/vim-elixir'
call plug#end()

" Automatically install missing plugins on startup
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif

" ================================================================================================================================= "
" ===                                                    Plugin Configuration                                                   === "
" ================================================================================================================================= "

" ===                                                    CtrlP                                                                  === "
" --------------------------------------------------------------------------------------------------------------------------------- "
let g:ctrlp_map='<c-p>'
let g:ctrlp_cmd='CtrlP'
let g:ctrlp_root_markers=['project.json', 'go.mod', '*.sln', 'mix.exs', '.gitignore']
map <C-b> :CtrlPBuffer<CR>
map <C-c> :CtrlPClearAllCaches<CR>

" ===                                                    Theme                                                                  === "
" --------------------------------------------------------------------------------------------------------------------------------- "
colorscheme nord

" ===                                                    Airline                                                                === "
" --------------------------------------------------------------------------------------------------------------------------------- "
" Do not draw separators for empty sections (only for the active window) >
let g:airline_skip_empty_sections = 1
"
" Smartly uniquify buffers names with similar filename, suppressing common parts of paths.
let g:airline#extensions#tabline#formatter='unique_tail'
"
" Custom setup that removes filetype/whitespace from default vim airline bar
let g:airline#extensions#default#layout=[['a', 'b', 'c'], ['x', 'z', 'warning', 'error']]

" ===                                                    Rainbow Parentheses                                                    === "
" --------------------------------------------------------------------------------------------------------------------------------- "
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

" ===                                                    NERDTree                                                               === "
" --------------------------------------------------------------------------------------------------------------------------------- "
" Show hidden files/directories
let g:NERDTreeShowHidden=1
" Remove bookmarks and help text from NERDTree
let g:NERDTreeMinimalUI=1
" Hide certain files and directories from NERDTree
let g:NERDTreeIgnore=['^\.DS_Store$', '^\.elixir_ls$', '\.git$[[dir]]', '\.idea$[[dir]]', '\.sass-cache$']
" Toggle NERDTree on/off
map <C-n> :NERDTreeToggle<CR>
" Opens current file location in NERDTree
nmap <leader>f :NERDTreeFind<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" ===                                                    Vim-Fugitive                                                           === "
" --------------------------------------------------------------------------------------------------------------------------------- "
" git blame
nmap <Leader>gb :Gblame<CR>
" git status
nmap <Leader>gs :G<CR>
" git diff
nmap <Leader>gd :Gdiffsplit<CR>
" git commit
nmap <Leader>gc :Gcommit<CR>
" git push
nmap <Leader>gp :Gpush<CR>
" git merge select left
nmap <Leader>gf :diffget //2<CR>
" git merge select right
nmap <Leader>gh :diffget //3<CR>

" ===                                                  Gutentags                                                                === "
" --------------------------------------------------------------------------------------------------------------------------------- "
let g:gutentags_cache_dir = expand('~/.cache/vim/ctags/')
let g:gutentags_generate_on_new = 1
let g:gutentags_generate_on_missing = 1
let g:gutentags_generate_on_write = 1
let g:gutentags_generate_on_empty_buffer = 0
let g:gutentags_ctags_extra_args = [
      \ '--tag-relative=yes',
      \ '--fields=+ailmnS',
      \ ]
let g:gutentags_ctags_exclude = [
      \ '*.git', '*.svg', '*.hg',
      \ 'build',
      \ 'dist',
      \ 'bin',
      \ 'node_modules',
      \ 'cache',
      \ 'compiled',
      \ 'bundle',
      \ 'vendor',
      \ '*.md',
      \ '*-lock.json',
      \ '*.lock',
      \ '*bundle*.js',
      \ '*build*.js',
      \ '.*rc*',
      \ '*.json',
      \ '*.min.*',
      \ '*.map',
      \ '*.bak',
      \ '*.zip',
      \ '*.pyc',
      \ '*.class',
      \ '*.sln',
      \ '*.Master',
      \ '*.csproj',
      \ '*.tmp',
      \ '*.csproj.user',
      \ '*.cache',
      \ '*.pdb',
      \ 'cscope.*',
      \ '*.css',
      \ '*.less',
      \ '*.scss',
      \ '*.exe', '*.dll',
      \ '*.mp3', '*.ogg', '*.flac',
      \ '*.swp', '*.swo',
      \ '*.bmp', '*.gif', '*.ico', '*.jpg', '*.png',
      \ '*.rar', '*.zip', '*.tar', '*.tar.gz', '*.tar.xz', '*.tar.bz2',
      \ '*.pdf', '*.doc', '*.docx', '*.ppt', '*.pptx',
      \ ]

" ===                                                    Tagbar                                                                 === "
" --------------------------------------------------------------------------------------------------------------------------------- "
nmap <Leader>tt :TagbarToggle<CR>

" Go
let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }

" Elixir
let g:tagbar_type_elixir = {
    \ 'ctagstype' : 'elixir',
    \ 'kinds' : [
        \ 'p:protocols',
        \ 'm:modules',
        \ 'e:exceptions',
        \ 'y:types',
        \ 'd:delegates',
        \ 'f:functions',
        \ 'c:callbacks',
        \ 'a:macros',
        \ 't:tests',
        \ 'i:implementations',
        \ 'o:operators',
        \ 'r:records'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 'p' : 'protocol',
        \ 'm' : 'module'
    \ },
    \ 'scope2kind' : {
        \ 'protocol' : 'p',
        \ 'module' : 'm'
    \ },
    \ 'sort' : 0
\ }

" Typescript
let g:tagbar_type_typescript = {
  \ 'ctagsbin' : 'tstags',
  \ 'ctagsargs' : '-f-',
  \ 'kinds': [
    \ 'e:enums:0:1',
    \ 'f:function:0:1',
    \ 't:typealias:0:1',
    \ 'M:Module:0:1',
    \ 'I:import:0:1',
    \ 'i:interface:0:1',
    \ 'C:class:0:1',
    \ 'm:method:0:1',
    \ 'p:property:0:1',
    \ 'v:variable:0:1',
    \ 'c:const:0:1',
  \ ],
  \ 'sort' : 0
\}

" ===                                                    LSP                                                                    === "
" --------------------------------------------------------------------------------------------------------------------------------- "
augroup elixir_lsp
  au!
  au User lsp_setup call lsp#register_server({
    \ 'name': 'elixir-ls',
    \ 'cmd': {server_info->[&shell, &shellcmdflag, '~/.lsp/elixir-ls/release/language_server.sh']},
    \ 'whitelist': ['elixir', 'eelixir'],
    \ })
augroup END
augroup fsharp_lsp
  au!
  au User lsp_setup call lsp#register_server({
    \ 'name': 'FSAC',
    \ 'cmd': {server_info->[&shell, &shellcmdflag, 'dotnet ~/.lsp/FsAutoComplete/bin/release_netcore/fsautocomplete.dll --background-service-enabled']},
    \ 'initialization_options': {'AutomaticWorkspaceInit': 1},
    \ 'workspace_config': {
        \ 'FSharp': {
            \ 'keywordsAutocomplete': 1,
            \ 'ExternalAutocomplete': 1,
            \ 'Linter': 1,
            \ 'UnionCaseStubGeneration': 1,
            \ 'UnionCaseStubGenerationBody': 'failwith \"Not Implemented\"',
            \ 'RecordStubGeneration': 1,
            \ 'RecordStubGenerationBody': 'failwith \"Not Implemented\"',
            \ 'InterfaceStubGeneration': 1,
            \ 'InterfaceStubGenerationObjectIdentifier': 'this',
            \ 'InterfaceStubGenerationMethodBody': 'failwith \"Not Implemented\"',
            \ 'UnusedOpensAnalyzer': 1,
            \ 'UnusedDeclarationsAnalyzer': 1,
            \ 'UseSdkScripts': 1,
            \ 'SimplifyNameAnalyzer': 0,
            \ 'ResolveNamespaces': 1,
            \ 'EnableReferenceCodeLens': 0,
            \ 'dotNetRoot': '/usr/local/share/dotnet',
            \ 'fsiExtraParameters': []
        \ }
    \ },
    \ 'whitelist': ['fsharp'],
    \ })
augroup END
if executable('gopls')
    augroup go_lsp
        au!
        au User lsp_setup call lsp#register_server({
            \ 'name': 'gopls',
            \ 'cmd': {server_info->['gopls']},
            \ 'whitelist': ['go'],
            \ })
        autocmd BufWritePre *.go LspDocumentFormatSync
    augroup END
endif
if executable('typescript-language-server')
    augroup typescript_lsp
        au!
        au User lsp_setup call lsp#register_server({
            \ 'name': 'typescript-language-server',
            \ 'cmd': {server_info->[&shell, &shellcmdflag, 'typescript-language-server --stdio']},
            \ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'tsconfig.json'))},
            \ 'whitelist': ['typescript', 'typescript.tsx'],
            \ })
    augroup END
    augroup js_lsp
        au!
        au User lsp_setup call lsp#register_server({
            \ 'name': 'javascript support using typescript-language-server',
            \ 'cmd': {server_info->[&shell, &shellcmdflag, 'typescript-language-server --stdio']},
            \ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'package.json'))},
            \ 'whitelist': ['javascript', 'javascript.jsx', 'javascriptreact'],
            \ })
    augroup END
endif
if executable('html-languageserver')
    augroup html_lsp
        au!
        au User lsp_setup call lsp#register_server({
          \ 'name': 'html-languageserver',
          \ 'cmd': {server_info->[&shell, &shellcmdflag, 'html-languageserver --stdio']},
          \ 'whielist': ['html'],
        \ })
    augroup END
endif
if executable('css-languageserver')
    augroup css_lsp
        au!
            au User lsp_setup call lsp#register_server({
                \ 'name': 'css-languageserver',
                \ 'cmd': {server_info->[&shell, &shellcmdflag, 'css-languageserver --stdio']},
                \ 'whitelist': ['css', 'less', 'sass'],
                \ })
    augroup END
endif
if executable('docker-langserver')
    augroup docker_lsp
        au!
        au User lsp_setup call lsp#register_server({
            \ 'name': 'docker-langserver',
            \ 'cmd': {server_info->[&shell, &shellcmdflag, 'docker-langserver --stdio']},
            \ 'whitelist': ['dockerfile'],
            \ })
    augroup END
endif
augroup vim_lsp
  au!
  au User lsp_setup call lsp#register_server({
    \ 'name': 'vim-language-server',
    \ 'cmd': {server_info->[&shell, &shellcmdflag, 'vim-language-server --stdio']},
    \ 'initialization_options': { 'vimruntime': $VIMRUNTIME, 'runtimepath': &rtp },
    \ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), ['.git/', '.vim/', 'vimfiles/']))},
    \ 'whitelist': ['vim'],
    \ })
augroup END
augroup bash_lsp
  au!
  au User lsp_setup call lsp#register_server({
    \ 'name': 'bash-language-server',
    \ 'cmd': {server_info->[&shell, &shellcmdflag, 'vim-language-server --stdio']},
    \ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), ['.git/']))},
    \ 'whitelist': ['sh'],
    \ })
augroup END
augroup csharp_lsp
  au!
  au User lsp_setup call lsp#register_server({
    \ 'name': 'omnisharp-lsp',
    \ 'cmd': {server_info->[&shell, &shellcmdflag, '~/.lsp/omnisharp-osx/run -lsp']},
    \ 'whitelist': ['cs'],
    \ 'initialization_options': {},
    \ 'config': {},
    \ 'workspace_config': {},
    \ })
augroup END

let g:lsp_signs_enabled = 1         " enable signs
let g:lsp_diagnostics_echo_cursor = 1 " enable echo under cursor when in normal mode
let g:lsp_signs_error = {'text': '✘'}
let g:lsp_signs_warning = {'text': '⚠'} " icons require GUI
let g:lsp_signs_hint = {'text': '!'} " icons require GUI
let g:lsp_highlights_enabled = 0
let g:lsp_textprop_enabled = 0
let g:lsp_highlight_references_enabled = 1
highlight link LspErrorText ALEErrorSign
highlight link LspWarningText ALEWarningSign
highlight link LspErrorLine ALEErrorSign
highlight link LspWarningLine ALEWarningSign

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
nmap <silent> <Leader>e <Plug>(lsp-next-error)
nmap <silent> <Leader>w <Plug>(lsp-next-warning)
nmap <silent> <Leader>D <Plug>(lsp-declaration)
nmap <silent> <Leader>d <Plug>(lsp-definition)
nmap <silent> <Leader>i <Plug>(lsp-implementation)
nmap <silent> <Leader>r <Plug>(lsp-references)
nmap <silent> <Leader>dd <Plug>(lsp-document-diagnostics)
" Use K to show documentation in preview window
nmap <silent> <Leader>K <Plug>(lsp-hover)
nmap <Leader>kd <Plug>(lsp-document-format)
    " refer to doc to add more commands
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END
