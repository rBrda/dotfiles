" ----------------------------------------------------------------------------
" Settings
" ----------------------------------------------------------------------------

syntax on                       " enable syntax highlighting
language en_US                  " specify language explicitly
filetype plugin indent on       " turn on filetype (+plugin, +indent)

set nocompatible                " Use Vim settings rather than Vi settings;
                                " this *must* be first in .vimrc

set encoding=utf-8              " set encoding to UTF-8
set updatetime=50               " faster updates
set clipboard=unnamedplus       " use system clipboard

set ignorecase                  " case insensitive searching
set smartcase                   " will automatically switch to case sensitive search if you use any capitals

set number                      " always show line numbers
set cursorline                  " highlight the current line (where the cursor is)
set showmode                    " always show what mode we're currently editing in
set cmdheight=3                 " give more space for displaying messages
set scrolloff=1                 " always show at least one line above/below the cursor
set hlsearch                    " highlight all search matches
set splitbelow                  " split belowe the current window
set splitright                  " split to the right of the current window

set backspace=indent,eol,start  " allow backspacing over everything in insert mode
set nowrap                      " don't wrap lines
set autoindent                  " always set autoindenting on
set smartindent
set expandtab                   " user spaces instead of tabs (overloadable per file type later)
set shiftwidth=4                " number of spaces to use for autoindenting
set tabstop=4 softtabstop=4     " a tab is four spaces
set smarttab

set visualbell                  " don't beep
set noerrorbells                " don't beep

set hidden                      " keep unsaved buffers
set autowrite                   " save on buffer switch

set exrc                        " enable reading and loading .vimrc files in project root
set secure                      " disable shell, autocmd and write commands in those .vimrc files

set backup                      " enable backups
set swapfile                    " enable swaps
set undofile                    " enable undos
set undolevels=1000             " how many undos
set undoreload=10000            " number of lines to save for undo

" Show max line length
set colorcolumn=80
highlight ColorColumn ctermbg=0 guibg=lightgrey

" Auto-resize splits when Vim gets resized
autocmd VimResized * wincmd =

" Store backups, swap files and undofiles outside of project root
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
set backupdir=~/.vim/undo//

if !isdirectory(expand(&backupdir))
    call mkdir(expand(&backupdir), "p", 0700)
endif
if !isdirectory(expand(&directory))
    call mkdir(expand(&directory), "p", 0700)
endif
if !isdirectory(expand(&backupdir))
    call mkdir(expand(&backupdir), "p", 0700)
endif

" Filetype dependent settings
autocmd Filetype javascript setlocal ts=2 sw=2 sts=2 expandtab

" Detect the OS and store it in the g:os global variable
" Currently not used!
if !exists("g:os")
    if has("win64") || has("win32") || has("win16")
        let g:os = "Windows"
    else
        let g:os = substitute(system('uname'), '\n', '', '')
    endif
endif

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" ----------------------------------------------------------------------------
" Key bindings
" ----------------------------------------------------------------------------

" Navigating between open windows
nnoremap <C-l> <C-W>l
nnoremap <C-h> <C-W>h
nnoremap <C-k> <C-W>k
nnoremap <C-j> <C-W>j

" Splits
nnoremap <leader>h :<C-u>split<CR>
nnoremap <leader>v :<C-u>vsplit<CR>

" Fast saves
nnoremap <leader>w :w!<CR>

" Copy the full path of the open buffer to clipboard
nnoremap <leader>cp :let @+ = expand("%:p")<CR>

" Exit Terminal mode by hitting ESC
tnoremap <Esc> <C-\><C-n>

" Clear search result highlighting by hitting ESC
nnoremap <Esc> :noh<Return><Esc>

" Navigation between buffers (next, previous)
nnoremap <C-p> :bp<CR>
nnoremap <C-n> :bn<CR>

" Close buffer
nnoremap <C-q> :bd<CR>

" Select all lines
nnoremap <C-a> <Esc>ggVG<CR>

" Copy and paste
vnoremap <C-c> "+yi
vnoremap <C-x> "+c
nnoremap <C-v> <ESC>"+pa
inoremap <C-v> <ESC>"+pa

" Moving lines up and down
" In OSX Terminal make sure the Option key is used as the Meta key!
nnoremap <M-j> :m .+1<CR>==
nnoremap <M-k> :m .-2<CR>==
inoremap <M-j> <Esc>:m .+1<CR>==gi
inoremap <M-k> <Esc>:m .-2<CR>==gi
vnoremap <M-j> :m '>+1<CR>gv=gv
vnoremap <M-k> :m '<-2<CR>gv=gv

" ----------------------------------------------------------------------------
" Plugins
" ----------------------------------------------------------------------------

call plug#begin()

" Vim extensions
Plug 'tpope/vim-obsession'
Plug 'dhruvasagar/vim-prosession'
Plug 'airblade/vim-rooter'

" Git
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive'

" Theme and looks
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'
Plug 'gruvbox-community/gruvbox'

" File management and search
Plug 'tpope/vim-eunuch'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Code editing, completion & syntax checking
Plug 'dense-analysis/ale'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-commentary'
Plug 'ntpeters/vim-better-whitespace'
Plug 'ekalinin/dockerfile.vim'
Plug 'hashivim/vim-terraform'

if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

" Debugging
Plug 'vim-vdebug/vdebug'

call plug#end()

" Automatically install missing plugins on startup
autocmd VimEnter *
    \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
    \|   PlugInstall --sync | q
    \| endif

" ----------------------------------------------------------------------------
" gruvbox-community/gruvbox
" ----------------------------------------------------------------------------

let g:gruvbox_contrast_dark = 'hard'
if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif
let g:gruvbox_invert_selection='0'

colorscheme gruvbox
set background=dark

" ----------------------------------------------------------------------------
" junegunn/fzf.vim
" ----------------------------------------------------------------------------

let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.8 } }
let $FZF_DEFAULT_COMMAND = 'rg --files --ignore-case --hidden -g "!{.git,node_modules,vendor}/*"'
let $FZF_DEFAULT_OPTS = "--ansi --preview-window 'right:60%' --layout reverse --margin=1,4 --preview 'bat --color=always --style=header,grid --line-range :300 {}'"

command! -bang -nargs=? -complete=dir Files
     \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

set grepprg=rg\ --vimgrep\ --smart-case\ --hidden\ --follow
set rtp+=~/.fzf
set rtp+=/usr/local/opt/fzf

nnoremap <silent> <C-f> :GFiles<CR>
nnoremap <silent> <C-g> :Rg<CR>

" ----------------------------------------------------------------------------
" vim-airline/vim-airline
" ----------------------------------------------------------------------------

let g:airline#extensions#tabline#enabled = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.crypt = '🔒'
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.maxlinenr = '㏑'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.spell = 'Ꞩ'
let g:airline_symbols.notexists = 'Ɇ'
let g:airline_symbols.whitespace = 'Ξ'

" ----------------------------------------------------------------------------
" ntpeters/vim-better-whitespace
" ----------------------------------------------------------------------------

let g:strip_whitespace_confirm = 1
let g:strip_whitelines_at_eof = 1
let g:strip_whitespace_on_save = 1

" ----------------------------------------------------------------------------
" Shougo/deoplete.nvim
" ----------------------------------------------------------------------------

let g:deoplete#enable_at_startup = 1

" ----------------------------------------------------------------------------
" dense-analysis/ale
" ----------------------------------------------------------------------------

let b:ale_linters = {
    \  'javascript': ['eslint'],
    \  'php': ['php']
    \}

nnoremap <silent> <F8> <ESC>:call AleToggle()<CR>

function! AleToggle()
  let g:wi = getloclist(2, {'winid' : 1})
  if g:wi != {}
    lclose
  else
    lopen
  endif
endfunction

" ----------------------------------------------------------------------------
" vim-vdebug/vdebug
" ----------------------------------------------------------------------------

let g:vdebug_options = {}
let g:vdebug_options['ide_key'] = 'PHPSTORM'
let g:vdebug_options['port'] = 9000

let g:vdebug_keymap = {
    \    "run" : "<F5>",
    \    "run_to_cursor" : "<F9>",
    \    "step_over" : "<F2>",
    \    "step_into" : "<F3>",
    \    "step_out" : "<F4>",
    \    "close" : "<F6>",
    \    "detach" : "<F7>",
    \    "set_breakpoint" : "<F10>",
    \    "get_context" : "<F11>",
    \    "eval_under_cursor" : "<F12>",
    \    "eval_visual" : "<Leader>e",
    \}

" ----------------------------------------------------------------------------
" intelephense (nodejs package, PHP code completion)
" ----------------------------------------------------------------------------

if executable('intelephense')
  augroup LspPHPIntelephense
    au!
    au User lsp_setup call lsp#register_server({
        \ 'name': 'intelephense',
        \ 'cmd': {server_info->[&shell, &shellcmdflag, 'intelephense --stdio']},
        \ 'whitelist': ['php'],
        \ 'initialization_options': {'storagePath': '/tmp/intelephense'},
        \ 'workspace_config': {
        \   'intelephense': {
        \     'files': {
        \       'maxSize': 1000000,
        \       'associations': ['*.php', '*.phtml'],
        \       'exclude': [],
        \     },
        \     'completion': {
        \       'insertUseDeclaration': v:true,
        \       'fullyQualifyGlobalConstantsAndFunctions': v:false,
        \       'triggerParameterHints': v:true,
        \       'maxItems': 100,
        \     },
        \     'format': {
        \       'enable': v:true
        \     },
        \   },
        \ }
        \})
  augroup END
endif
