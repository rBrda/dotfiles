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
set fileformat=unix             " force unix fileformat

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
set nostartofline               " don't jump back to the beginning of the line when switching between buffers

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

" Python2.7 and Python3 config
let g:python_host_prog = '/usr/bin/python'
let g:python3_host_prog = '/usr/local/bin/python3'

" ----------------------------------------------------------------------------
" Key bindings
" ----------------------------------------------------------------------------

" @(Windows -> right)
nnoremap <C-l> <C-W>l
" @(Windows -> left)
nnoremap <C-h> <C-W>h
" @(Windows -> up)
nnoremap <C-k> <C-W>k
" @(Windows -> down)
nnoremap <C-j> <C-W>j

" @(Split -> horizontal)
nnoremap <leader>h :<C-u>split<CR>
" @(Split -> vertical)
nnoremap <leader>v :<C-u>vsplit<CR>

" @(Fast save)
nnoremap <leader>w :w!<CR>

" @(Copy full path of current file)
nnoremap <leader>cp :let @+ = expand("%:p")<CR>

" @(Exit terminal mode)
tnoremap <Esc> <C-\><C-n>

" @(Clear search result)
nnoremap <Esc><Esc> :let @/=""<CR>

" @(Buffers -> previous)
nnoremap <C-p> :bp<CR>
" @(Buffers -> next)
nnoremap <C-n> :bn<CR>
" @(Buffers -> close)
nnoremap <silent> <C-q> :call CloseBuffer()<CR>
cnoremap <silent> bd call CloseBuffer()<CR>

" @(Tabs -> previous)
nnoremap <C-Left> gT<CR>
" @(Tabs -> next)
nnoremap <C-Right> gt<CR>
" @(Tabs -> close)
nnoremap <leader>q :tabclose<CR>

" @(Select word under cursor)
nnoremap <S-s> viw

" @(Select all lines)
nnoremap <C-a> <Esc>ggVG<CR>

" @(Shift indentation)
vnoremap <Tab> >gv
" @(Unshift indentation)
vnoremap <S-Tab> <gv

" @(Copy)
vnoremap <C-c> "+yi
" @(Cut)
vnoremap <C-x> "+c
" @(Paste)
nnoremap <C-v> <Esc>"+pa
" @(Paste)
inoremap <C-v> <Esc>"+pa

" Moving lines up and down
" In OSX Terminal make sure the Option key is used as the Meta key!
" @(Move line down)
nnoremap <M-j> :m .+1<CR>==
" @(Move line up)
nnoremap <M-k> :m .-2<CR>==
" @(Move line down)
inoremap <M-j> <Esc>:m .+1<CR>==gi
" @(Move line up)
inoremap <M-k> <Esc>:m .-2<CR>==gi
" @(Move line down)
vnoremap <M-j> :m '>+1<CR>gv=gv
" @(Move line up)
vnoremap <M-k> :m '<-2<CR>gv=gv

function! CloseBuffer()
    if &modified
        echohl ErrorMsg
        echom "E89: no write since last change"
        echohl None
    elseif len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
        execute ':new | bd #'
    else
        execute ':bp | bd #'
    endif
endfunction

" ----------------------------------------------------------------------------
" Plugins
" ----------------------------------------------------------------------------

call plug#begin()

" Vim extensions
Plug 'tpope/vim-obsession'
Plug 'dhruvasagar/vim-prosession'
Plug 'airblade/vim-rooter'
Plug 'rBrda/vim-prosettings'
Plug 'rBrda/myKeymap'

" Git
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'

" Theme and looks
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'
Plug 'gruvbox-community/gruvbox'

" File management and search
Plug 'antoinemadec/FixCursorHold.nvim'
Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/fern-git-status.vim'
Plug 'lambdalisue/nerdfont.vim'
Plug 'lambdalisue/fern-renderer-nerdfont.vim'
Plug 'tpope/vim-eunuch'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Code editing
Plug 'Raimondi/delimitMate'
Plug 'tpope/vim-commentary'
Plug 'ntpeters/vim-better-whitespace'
Plug 'wellle/targets.vim'

" Code syntax
Plug 'sheerun/vim-polyglot'
Plug 'ekalinin/dockerfile.vim'
Plug 'hashivim/vim-terraform'

" Code linting & completion
Plug 'dense-analysis/ale'
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}

" Debugging
Plug 'vim-vdebug/vdebug'

call plug#end()

" Automatically install missing plugins on startup
autocmd VimEnter *
    \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
    \|   PlugInstall --sync | q
    \| endif

" ----------------------------------------------------------------------------
" dhruvasagar/vim-prosession
" ----------------------------------------------------------------------------

let g:prosession_per_branch = 1

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
" mhinz/vim-signify
" ----------------------------------------------------------------------------

nnoremap <silent> <leader>sd :SignifyDiff<CR>
nnoremap <silent> <leader>sh :SignifyToggleHighlight<CR>
nnoremap <silent> <leader>u :SignifyHunkUndo<CR>

" ----------------------------------------------------------------------------
" junegunn/fzf.vim
" ----------------------------------------------------------------------------

let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.8 } }
let $FZF_DEFAULT_OPTS = "--preview-window 'right:60%' --layout reverse --margin=1,4 --preview 'bat --color=always --style=header,grid --line-range :300 {}'"

if executable('rg')
    let $FZF_DEFAULT_COMMAND = 'rg --files --ignore-case --hidden -g "!{.git,node_modules,vendor}/*"'
    set grepprg=rg\ --vimgrep\ --smart-case\ --hidden\ --follow
endif

command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, &columns > 80 ? fzf#vim#with_preview() : {}, <bang>0)

command! -bang -nargs=? -complete=dir GFiles
    \ call fzf#vim#gitfiles(<q-args>, &columns > 80 ? fzf#vim#with_preview() : {}, <bang>0)

nnoremap <silent> <M-f> :call FzfFiles()<CR>
nnoremap <silent> <M-g> :Rg<CR>

function! FzfFiles()
    let is_git = system('git status')
    if v:shell_error
        :Files
    else
        :GFiles --exclude-standard --others --cached
    endif
endfunction

" ----------------------------------------------------------------------------
" vim-airline/vim-airline
" ----------------------------------------------------------------------------

set noshowmode " disable built-in mode indicator

let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='gruvbox'

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
" lambdalisue/fern.vim
" ----------------------------------------------------------------------------

" Disable netrw.
let g:loaded_netrw  = 1
let g:loaded_netrwPlugin = 1
let g:loaded_netrwSettings = 1
let g:loaded_netrwFileHandlers = 1

augroup my-fern-hijack
  autocmd!
  autocmd BufEnter * ++nested call s:hijack_directory()
augroup END

function! s:hijack_directory() abort
  let path = expand('%:p')
  if !isdirectory(path)
    return
  endif
  bwipeout %
  execute printf('Fern %s', fnameescape(path))
endfunction

" Custom settings and mappings.
let g:fern#disable_default_mappings = 1

noremap <silent> ff :Fern . -drawer -stay -reveal=% -toggle -width=35<CR><C-w>=

function! FernInit() abort
  nmap <buffer><expr>
        \ <Plug>(fern-my-open-expand-collapse)
        \ fern#smart#leaf(
        \   "\<Plug>(fern-action-open:select)",
        \   "\<Plug>(fern-action-expand)",
        \   "\<Plug>(fern-action-collapse)",
        \ )
  nmap <buffer> <CR> <Plug>(fern-my-open-expand-collapse)
  nmap <buffer> <2-LeftMouse> <Plug>(fern-my-open-expand-collapse)
  nmap <buffer> n <Plug>(fern-action-new-path)
  nmap <buffer> d <Plug>(fern-action-remove)
  nmap <buffer> m <Plug>(fern-action-move)
  nmap <buffer> M <Plug>(fern-action-rename)
  nmap <buffer> H <Plug>(fern-action-hidden:toggle)
  nmap <buffer> r <Plug>(fern-action-reload)
  nmap <buffer> b <Plug>(fern-action-open:split)
  nmap <buffer> v <Plug>(fern-action-open:vsplit)
  nmap <buffer><nowait> < <Plug>(fern-action-leave)
  nmap <buffer><nowait> > <Plug>(fern-action-enter)
  " When switching between buffers, we go back to the
  " previous window and perform the action there.
  nmap <buffer> <C-n> <C-w>p <bar> :bn<CR>
  nmap <buffer> <C-p> <C-w>p <bar> :bp<CR>
endfunction

augroup FernGroup
  autocmd!
  autocmd FileType fern call FernInit()
augroup END

" ----------------------------------------------------------------------------
" lambdalisue/fern-renderer-nerdfont.vim
" ----------------------------------------------------------------------------

let g:fern#renderer = "nerdfont"

" ----------------------------------------------------------------------------
" neoclide/coc.nvim
" ----------------------------------------------------------------------------

let g:coc_global_extensions = [
    \ 'coc-eslint',
    \ 'coc-html',
    \ 'coc-json',
    \ 'coc-phpls',
    \ 'coc-tsserver',
    \ ]

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
" @(CoC -> jump to definition)
nmap <silent> gd <Plug>(coc-definition)
" @(CoC -> jump to type definition)
nmap <silent> gy <Plug>(coc-type-definition)
" @(CoC -> jump to implementation)
nmap <silent> gi <Plug>(coc-implementation)
" @(CoC -> show references)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
" Note coc#float#scroll works on neovim >= 0.4.3 or vim >= 8.2.0750
nnoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

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
let g:vdebug_options['layout'] = 'horizontal'
let g:vdebug_options['watch_window_style'] = 'compact'

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
