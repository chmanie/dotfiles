" Don't try to be vi compatible
set nocompatible

" Helps force plugins to load correctly when it is turned back on below
filetype off

" Plugins
call plug#begin('~/.local/share/nvim/site/plugged')

" Properly navigate splits when in tmux
Plug 'christoomey/vim-tmux-navigator'  
" Code formatters and linters
Plug 'w0rp/ale'
" Color schemes
"Plug 'mhartington/oceanic-next'
" Plug 'morhetz/gruvbox'
Plug 'dracula/vim'
" status bar
Plug 'itchyny/lightline.vim'
" Show git branch
Plug 'itchyny/vim-gitbranch'
" JavaScript language stuff
Plug 'pangloss/vim-javascript' 
Plug 'mxw/vim-jsx'
" Not really a plugin byt fzf
Plug '/usr/local/opt/fzf'
Plug 'chmanie/fzf.vim'
" Auto close parens
Plug 'cohama/lexima.vim'

call plug#end()

" Turn on syntax highlighting
syntax on

" For plugins to load correctly
filetype plugin indent on

let mapleader = ","

" Security
set modelines=0

" Show line numbers
set number

" Show file stats
set ruler

" Blink cursor on error instead of beeping (grr)
set visualbell

" Encoding
set encoding=utf-8

" Whitespace
set wrap
set textwidth=79
set formatoptions=tcqrn1
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set noshiftround

" Cursor motion
set scrolloff=3
set backspace=indent,eol,start 
set matchpairs+=<:> " use % to jump between pairs
runtime! macros/matchit.vim

" Move up/down editor lines
nnoremap j gj
nnoremap k gk

" Allow hidden buffers
set hidden

" Automatically detect file changes
set autoread
" Reload the file when enterin buffer
au FocusGained,BufEnter * :silent! !

" Rendering
set ttyfast

" Status bar
set laststatus=2
set noshowmode " we have the mode in the status bar

" Last line
set showcmd

" Searching
nnoremap / /\v
vnoremap / /\v
set hlsearch
set incsearch
set noignorecase
" set smartcase
set showmatch
map <leader><space> :let @/=''<cr> " clear search

" Remap help key.
inoremap <F1> <ESC>:set invfullscreen<CR>a
nnoremap <F1> :set invfullscreen<CR>
vnoremap <F1> :set invfullscreen<CR>

" Formatting
map <leader>q gqip
" Easy commenting of lines
noremap <silent> <leader>cc :<C-B>silent <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:nohlsearch<CR>
noremap <silent> <leader>cu :<C-B>silent <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:nohlsearch<CR>

" Visualize tabs and newlines
set listchars=tab:▸\ ,eol:¬
" Uncomment this to enable by default:
" set list " To enable by default
" Or use your leader key + l to toggle on/off
map <leader>l :set list!<CR> " Toggle tabs and EOL

" Use mac os clipboard for yanking
set clipboard=unnamed
" Use '' in visual mode to copy stuff to the mac clipboard
" vmap '' :w !pbcopy<CR><CR>

" Finding stuff

" Use fzf and ripgrep to find things
" --column: Show column number
" --line-number: Show line number
" --no-heading: Do not show file headings in results
" --fixed-strings: Search term as a literal string
" --ignore-case: Case insensitive search
" --no-ignore: Do not respect .gitignore, etc...
" --hidden: Search hidden files and folders
" --follow: Follow symlinks
" --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
" --color: Search color options
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)
" Use ripgrep for grepping
set grepprg=rg\ --vimgrep

" FILE BROWSING

let g:netrw_localrmdir="rm -r" " Be able to delete non-emtpy directories
" let g:netrw_banner=0 " Disable banner
" let g:netrw_browse_split=4 " Open in prior window
let g:netrw_liststyle=3 " Tree view
let g:netrw_altv=1
let g:netrw_winsize=25
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^|\s\s)\zs\.\S+'

" Color scheme (terminal)
if (has("termguicolors"))
  let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

" colorscheme OceanicNext
" colorscheme gruvbox
colorscheme dracula

" Operator mono adjustments
hi htmlArg gui=italic
hi Comment gui=italic
hi Type    gui=italic
hi htmlArg cterm=italic
hi Comment cterm=italic
hi Type    cterm=italic

" Plugin config

" fzf keybinding
map <C-p> :Files<CR>
map <C-n> :Buffers<CR>
nnoremap \ :Find<Space>
" Relative path autocompletion with fzf and fd (fantastic!)
inoremap <expr> <c-x><c-f> fzf#vim#complete#path_relative('fd')

" gruvbox
" let g:gruvbox_contrast_dark = 'hard'

" vim-javascript
let g:javascript_plugin_flow = 1

" lightline
let g:lightline = {
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ],
  \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
  \ },
  \ 'colorscheme': 'one',
  \ 'component_function': {
  \   'gitbranch': 'gitbranch#name'
  \ },
\ }

" ALE
map <leader>g :ALEGoToDefinition<CR>
map <leader>f :ALEFix<CR>
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1
