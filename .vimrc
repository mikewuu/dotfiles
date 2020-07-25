

" ----- Plugins -----


call plug#begin()

" NerdTree (File Explorer)
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons' " File icons

" FZF - File search
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

" Git commands in vim
Plug 'tpope/vim-fugitive'

call plug#end() 


" ----- System Config -----


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

" Hide NerdTree (file explorer sidebar) on start
let NERDTreeShowHidden=1

" Themes
"colorscheme vim-material
"colorscheme nord
colorscheme OceanicNext
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
nmap <Leader>w :bd!<Return>
" Save
nmap <Leader>s :w<Return>
" Save & Quit
nmap <Leader>c :wq<Return>
" Quit w/o save
nmap <Leader>q :q!<Return>

" ESC to Clear highlight after search
nnoremap <silent> <ESC> :noh<CR>

" Search for file
map <Leader>p :FZF<Return>

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
