

" ----- Plugins -----


call plug#begin()

" NerdTree (File Explorer)
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'      " File icons

"FZF - File search
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Syntax Highlighting
Plug 'pangloss/vim-javascript'                                         " JavaScript
Plug 'leafgarland/typescript-vim'                                      " TypeScript
Plug 'maxmellon/vim-jsx-pretty'                                        " JSX/TSX
Plug 'jparise/vim-graphql'                                             " GraphQL
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }   " Styled Components

" Editor Config
Plug 'editorconfig/editorconfig-vim'

" Closing Brackets
Plug 'jiangmiao/auto-pairs' 	" Auto-close [brackets]
Plug 'alvan/vim-closetag' 	" Auto-close <tags>
Plug 'tpope/vim-surround' 	" Quickly change <tags> -> [brackets] -> 'quotes' -> <tags>

" Expand selection region
Plug 'terryma/vim-expand-region'

" Allow selecting more regions
Plug 'kana/vim-textobj-user' 	  " Required - enable custom user objects
Plug 'kana/vim-textobj-line'      " Expand until end of line
Plug 'kana/vim-textobj-entire'    " Expand until whoel file

" Tmux focus events - required for plugins
Plug 'tmux-plugins/vim-tmux-focus-events'

" Select next occurrence
Plug 'terryma/vim-multiple-cursors'

" Lightline
Plug 'itchyny/lightline.vim'

" VSCode style Auto-complete
Plug 'neoclide/coc.nvim' , { 'branch' : 'release'  }

" Themes
Plug 'hzchirs/vim-material'
Plug 'arcticicestudio/nord-vim'
Plug 'mhartington/oceanic-next'
Plug 'joshdick/onedark.vim'

" Git commands in vim
Plug 'tpope/vim-fugitive'

call plug#end() 


" ----- System Config -----

" Don't show the intro
set shortmess+=I

" Turn on the mouse in all modes
set mouse=a

" Give one virtual space at end of line
set virtualedit=onemore

" Set to auto read when a file is changed from the outside
set autoread

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
set textwidth=120
set autoindent
set nowrap
set whichwrap+=h,l,<,>,[,]

" Explicitly set encoding to utf-8
set encoding=utf-8

" Turn off sound
set vb
set t_vb=

" Allow changing buffer without saving it first
set hidden

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
let $FZF_DEFAULT_COMMAND = 'ag --hidden -g ""'

" Coc Auto-complete Extensions
let g:coc_global_extensions = [ 'coc-tsserver' ]  			  
if isdirectory('./node_modules') && isdirectory('./node_modules/eslint')   " ESlint (if in node_modules)
  let g:coc_global_extensions += ['coc-eslint']
endif
autocmd CursorHold * silent call CocActionAsync('highlight')               " Highlight symbol on cursor highlight

" NERDTree
let NERDTreeShowHidden=1
let NERDTreeIgnore=['\~$', '\.swp$', '\.git', '\.cache', '\.idea'] 

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


"----- Keymaps -----

" Space for leader key
nnoremap <SPACE> <Nop>
let mapleader=" "

" Split window
nmap <Leader>t :vsplit<Return>

" Navigate panes
map <Leader>h <C-w>h
map <Leader>k <C-w>k
map <Leader>j <C-w>j
map <Leader>l <C-w>l

" Toggle file explorerr
nmap <silent> <Leader>e :NERDTreeToggle<CR>

" Close pane w/o save
nmap <c-w> :bd!<Return>
" Save
nmap <c-s> :w<Return>
" Save & Quit
nmap <c-c> :wq<Return>
" Quit w/o save
nmap <c-q> :q!<Return>

" ESC to Clear highlight after search
nnoremap <silent> <ESC> :noh<CR>

" Search for file - will also move away from NERDTree if we're in it
nnoremap <silent> <expr> <Leader>p (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '').":FZF\<cr>"

" ALT + j/k to move lines up/down
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" Search for text everywhere
" Start search
:nmap <Leader>f :vimgrep // **/*<left><left><left><left><left><left>
" Go to next search result
:nmap <Leader>] :cnext <CR>
" Go to prev sxtearch result
:nmap <Leader>[ :cprevious <CR>
" Close search results windows
:nmap <Leader>. :cclose <CR>
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

" Coc - use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction
" Required - to trigger tab completion
inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

" Rename symbol/variable
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code
xmap <leader>fo  <Plug>(coc-format-selected)
nmap <leader>fo  <Plug>(coc-format-selected)
