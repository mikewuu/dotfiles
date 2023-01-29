
" ----- Plugins -----


call plug#begin()

" NerdTree (File Explorer)
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'      " File icons

"FZF - File search
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Use ripgrep for search
Plug 'jremmen/vim-ripgrep'

" Syntax Highlighting
Plug 'pangloss/vim-javascript'                                         " JavaScript
"Plug 'leafgarland/typescript-vim'                                      " TypeScript
Plug 'maxmellon/vim-jsx-pretty'                                        " JSX/TSX
Plug 'jparise/vim-graphql'                                             " GraphQL
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }   " Styled Components
Plug 'posva/vim-vue'                                                   " Vue

" Editor Config
Plug 'editorconfig/editorconfig-vim'

" Closing Brackets
Plug 'jiangmiao/auto-pairs' 	" Auto-close [brackets]
Plug 'alvan/vim-closetag' 	" Auto-close <tags>
Plug 'tpope/vim-surround' 	" Quickly change <tags> -> [brackets] -> 'quotes' -> <tags>

" Quickly comment out code
Plug 'tpope/vim-commentary'

" Tmux focus events - required for plugins
Plug 'tmux-plugins/vim-tmux-focus-events'

" Select next occurrence
Plug 'terryma/vim-multiple-cursors'

" Smoother scroll
Plug 'terryma/vim-smooth-scroll'

" Lightline
Plug 'itchyny/lightline.vim'

" VSCode style Auto-complete
Plug 'neoclide/coc.nvim' , { 'branch' : 'release'  }

" Themes
Plug 'hzchirs/vim-material'
Plug 'arcticicestudio/nord-vim'
Plug 'mhartington/oceanic-next'

" Git commands in vim
Plug 'tpope/vim-fugitive'

" Indent JS/TS files properly
Plug 'jason0x43/vim-js-indent'

" Navigate vim, and tmux panes together
Plug 'christoomey/vim-tmux-navigator'

call plug#end() 


" ----- System Config -----

" Focus on new split windows
set splitbelow
set splitright

" Don't show the intro
set shortmess+=I

" Turn on the mouse in all modes
set mouse=a

" Give one virtual space at end of line
set virtualedit=onemore

" Set to auto write/save file
set autowriteall

" Tab settings
set expandtab
set shiftwidth=2
set tabstop=8
set softtabstop=2
set smarttab

" Text display settings
set linebreak
set textwidth=80
set autoindent
set whichwrap+=h,l,<,>,[,]

" Give line breaks the same indentation
set breakindent

" Explicitly set encoding to utf-8
set encoding=utf-8

" Turn off sound
set vb
set t_vb=

" Allow changing buffer without saving it first
set hidden

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Show incomplete commands
set showcmd

" Enable syntax highlighting
syntax enable

" Show line number
set number

" Show file type
filetype on

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300 " Quicker autocomplete

" Enable autoread to update changed files
set autoread 

" Use 'ag' for FZF (Search) to prevent searching git ignore
" let $FZF_DEFAULT_COMMAND = 'ag --hidden -g ""'

" Search with ripgrep
let $FZF_DEFAULT_COMMAND = 'rg --hidden --files'

" Coc automatically install these extensions
let g:coc_global_extensions = [ 'coc-tsserver', 'coc-snippets', 'coc-prettier', 'coc-eslint', 'coc-yaml', 'coc-vetur', 'coc-styled-components', 'coc-phpls', 'coc-markdownlint', 'coc-json', 'coc-css' ]  			  
if isdirectory('./node_modules') && isdirectory('./node_modules/eslint')   " ESlint (if in node_modules)
  let g:coc_global_extensions += ['coc-eslint']
endif
autocmd CursorHold * silent call CocActionAsync('highlight')               " Highlight symbol on cursor highlight


" NERDTree
let NERDTreeShowHidden=1
let NERDTreeIgnore=['\~$', '\.swp$', '\.git', '\.cache', '\.idea', '.DS_Store'] 

" Automatically show file in NERDTree
" Check if NERDTree is open or active
function! IsNERDTreeOpen()        
  return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction
" Call NERDTreeFind iff NERDTree is active, current window contains a modifiable
" file, and we're not in vimdiff
function! SyncTree()
  if &modifiable && IsNERDTreeOpen() && strlen(expand('%')) > 0 && !&diff
    NERDTreeFind
    wincmd p
  endif
endfunction

" Close NERDTree if it's the last buffer
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Highlight currently open buffer in NERDTree
autocmd BufRead * call SyncTree()

function! ToggleTree()
    if exists("g:NERDTree") && g:NERDTree.IsOpen()
        NERDTreeClose
    elseif filereadable(expand('%'))
        NERDTreeFind
    else
        NERDTree
    endif
endfunction

" Ctrl+E to open NERDTree 
nmap <silent> <c-e> :call ToggleTree()<CR>


" Cursor settings. This makes terminal vim sooo much nicer!
" Tmux will only forward escape sequences to the terminal if surrounded by a DCS
" sequence
if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif


" Themes
"colorscheme vim-material
"colorscheme nord
colorscheme OceanicNext
"colorscheme onedark

" Set terminal colors for theme
if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
"For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
"Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
" < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
if (has("termguicolors"))
  set termguicolors
endif

" Lightline (File status on bottom)
let g:lightline = {
      \ 'component_function': {
      \   'filename': 'LightlineFilename',
      \ }
      \ }
" Show full file path in lightline
function! LightlineFilename()
  let root = fnamemodify(get(b:, 'git_dir'), ':h')
  let path = expand('%:p')
  if path[:len(root)-1] ==# root
    return path[len(root)+1:]
  endif
  return expand('%')
endfunction

" Setup auto-close <xml> tags for JSX/TSX
let g:closetag_xhtml_filetypes = 'xhtml,javascript.jsx,jsx,typescript.tsx,tsx'
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.jsx,*.tsx'
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx,*.tsx'
let g:closetag_regions = {
    \ 'typescript.tsx': 'jsxRegion,tsxRegion',
    \ 'javascript.jsx': 'jsxRegion',
    \ }

" Case insensitive search
set ignorecase
set smartcase

" ----- Keymaps -----

" Space for leader key
nnoremap <space> <Nop>
let mapleader=" "


" Close pane w/o save
nmap <c-b> :bd!<Return>
" Save
nmap <c-s> :w<Return>
inoremap <c-s> <ESC>:w<Return>
" Save & Quit
nmap <leader>s :wq<Return>
" Quit w/o save
nmap <c-q> :q!<Return>

" Ctrl + d/u to scroll page
nnoremap <C-d> :call smooth_scroll#down(&scroll, 4, 1)<CR>
nnoremap <C-u> :call smooth_scroll#up(&scroll, 4, 1)<CR>


" ESC to Clear highlight after search
nnoremap <silent> <ESC> :noh<CR>

" Search for file - will also move away from NERDTree if we're in it
nnoremap <silent> <expr> <c-p> (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '').":FZF\<cr>"

" ALT + j/k to move lines up/down
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv
" For mac we have to use the alt symbols for each key
" alt + j = ∆
" alt + k = ˚
nnoremap ∆ :m .+1<CR>==
nnoremap ˚ :m .-2<CR>==
inoremap ∆ <Esc>:m .+1<CR>==gi
inoremap ˚ <Esc>:m .-2<CR>==gi
vnoremap ∆ :m '>+1<CR>gv=gv
vnoremap ˚ :m '<-2<CR>gv=gv

" Search for text everywhere
" Start search
":nmap <Leader>f :vimgrep // **/*<left><left><left><left><left><left>
" Use Ctrl + f for search using ripgrep
nmap <c-f> :Rg<space>
" Go to next search result
nmap ]q :cnext <CR>
" Go to prev sxtearch result
nmap [q :cprevious <CR>
" Close search results windows
nmap <leader>q :cclose <CR>
" Ignore directories
set wildignore=*/node_modules/*,*/.vscode,*/.git
" Required - automatically opens the vim quickfix window
augroup myvimrc
    autocmd!
    autocmd QuickFixCmdPost [^l]* cwindow
    autocmd QuickFixCmdPost l*    lwindow
augroup EN

" Disable arrow keys in normal mode
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

" Required - Fix syntax highlighting for .tsx by setting filetype
" javascripttypescript -> typescript.tsx
augroup SyntaxSettings
autocmd!
autocmd BufNewFile,BufRead *.tsx set filetype=typescript.tsx
augroup END

" Coc Auto-complete shortcuts

" Go-to definition
nmap <silent> gd <Plug>(coc-definition)
" Go-to type-def
nmap <silent> gy <Plug>(coc-type-definition)
" Go-to implementation
nmap <silent> gi <Plug>(coc-implementation)
" Go-to reference
nmap <silent> gr <Plug>(coc-references)

" Use `[g` and `]g` to navigate errors/warnings
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Use K to show documentation/type info
nnoremap <silent> K :call <SID>show_documentation()<CR>
" Required - to show type info in preview window
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Create and navigate tabs
" th - prev tab
nnoremap th :tabprev<CR>
" tl - next tab
nnoremap tl :tabnext<CR>
" tn - close tab
nnoremap tx :tabclose<CR>
" tn - Open current buffer in new tab
nnoremap tn :tab split<CR>

" Coc - use <tab> for trigger completion and navigate to the next complete item
"

inoremap <silent><expr> <TAB>
  \ coc#pum#visible() ? coc#_select_confirm() :
  \ coc#expandableOrJumpable() ?
  \ "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

" Rename symbol/variable
nmap <silent> <leader>r <Plug>(coc-rename)

" Formatting selected code
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Delete without copy
nnoremap <leader>d "_d
xnoremap <leader>d "_d
" Paste, and allow re-paste
xnoremap <leader>p "_dP

" Copy to system clipboard
if has ('unnamedplus')
  set clipboard=unnamedplus
else
  set clipboard=unnamed
endif

" Map + to expand selection via coc
nmap <silent> + <Plug>(coc-range-select)
xmap <silent> + <Plug>(coc-range-select)

" Apply AutoFix to problem on the current line.
nmap <silent> <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Show all diagnostics.
nnoremap <silent> <leader>e  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <leader>c  :<C-u>CocList extensions<cr>
" Find symbol of current document.
nnoremap <silent> <leader>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <leader>t  :<C-u>CocList -I symbols<cr>

" Text padding
set scrolloff=5

" Use vim-js-indent instead of leafgarland/typescript indenting
let g:typescript_indent_disable = 1

" Enable blinking cursor
set guicursor+=a:-blinkwait175-blinkoff150-blinkon175
