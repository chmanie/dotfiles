" Don't try to be vi compatible
set nocompatible

" Helps force plugins to load correctly when it is turned back on below
filetype off

" Plugins
call plug#begin('~/.local/share/nvim/site/plugged')

" Properly navigate splits when in tmux
Plug 'christoomey/vim-tmux-navigator'  
" Color schemes
Plug 'cocopon/iceberg.vim'
" status bar
Plug 'itchyny/lightline.vim'
" Show git branch
" Plug 'itchyny/vim-gitbranch'
" Language stuff
Plug 'pangloss/vim-javascript' 
Plug 'maxmellon/vim-jsx-pretty'
Plug 'jparise/vim-graphql'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'rhysd/vim-clang-format'
Plug 'vim-syntastic/syntastic'
" Language server
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'jackguo380/vim-lsp-cxx-highlight'
" Debugging
Plug 'chmanie/termdebugx.nvim'
" File exploring
Plug '/usr/local/opt/fzf'
Plug 'chmanie/fzf.vim'
Plug 'tpope/vim-vinegar'
" Auto close parens
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
" Add comments using gcc and gc
Plug 'tpope/vim-commentary'
Plug 'suy/vim-context-commentstring'
" Open marked (macOS only)
Plug 'itspriddle/vim-marked'
" Paste images from clipboard into markdown
Plug 'ferrine/md-img-paste.vim'
" Color CSS colors
Plug 'chrisbra/Colorizer'

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

" coc.nvim: Some servers have issues with backup files, see #649.
" Consider turning that on if it works
set nobackup
set nowritebackup

" Give more space for displaying messages.
" set cmdheight=2

" Always draw the signcolumn (merged with number column)
" set signcolumn=number
set signcolumn=yes

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Whitespace
set wrap
" set textwidth=80
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

" Regex engine
set re=2

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

" Visualize tabs and newlines
set listchars=tab:▸\ ,eol:¬
" Uncomment this to enable by default:
" set list " To enable by default
" Or use your leader key + l to toggle on/off
map <leader>l :set list!<CR> " Toggle tabs and EOL

" Use mac os clipboard for yanking
" set clipboard=unnamed
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
" Freed <C-l> in Netrw
nmap <leader><leader>l <Plug>NetrwRefresh 
" Be able to delete non-emtpy directories
let g:netrw_localrmdir="rm -r" 
" Hide files ignored by git
let g:netrw_list_hide=netrw_gitignore#Hide()
" Conveniently open netrw
nnoremap <C-_> :Ex<CR>

" Color scheme (terminal)
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

colorscheme iceberg

" Operator mono adjustments
hi htmlArg gui=italic
hi Comment gui=italic
hi Type    gui=italic
hi htmlArg cterm=italic
hi Comment cterm=italic
hi Type    cterm=italic

" Plugin config

" fzf keybindings
nnoremap <C-p> :Files<CR>
nnoremap <C-n> :Buffers<CR>
nnoremap \ :Find<Space>
" Relative path autocompletion with fzf and fd (fantastic!)
inoremap <expr> <c-x><c-f> fzf#vim#complete#path_relative('fd')

" Find + replace project wide (requires fr function)
nnoremap \| :!fr<Space>

" Type // in visual mode to find text that is selected
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>

" lightline
let g:lightline = {
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ],
  \             [ 'readonly',  'cocstatus', 'filename', 'modified' ] ]
  \ },
  \ 'colorscheme': 'iceberg',
  \ 'component_function': {
  \   'cocstatus': 'coc#status'
  \ },
\ }

" c++ syntax highlighting
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1

" syntastic
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_cpp_checkers = ['cpplint']
let g:syntastic_c_checkers = ['cpplint']
let g:syntastic_cpp_cpplint_exec = 'cpplint'

" coc.nvim

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)


" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

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

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" C(++) debugging
" See https://neovim.io/doc/user/nvim_terminal_emulator.html
" packadd termdebug
let g:termdebug_popup = 0
let g:termdebug_wide = 163
" Default is ARM debugging
" In the future, consider using https://github.com/embear/vim-localvimrc for
" project specific settings
let g:termdebugger = "arm-none-eabi-gdb"
let g:termdebugger_program = "pio device monitor -b 38400"
" Map ESC to exit terminal mode (it's interfering with fzf so we check
" whether we're in fzf, see https://github.com/junegunn/fzf.vim/issues/544#issuecomment-457456166)
tnoremap <expr> <Esc> (&filetype == "fzf") ? "<Esc>" : "<c-\><c-n>"
" Some debugging shortcuts
nnoremap <silent> <leader>b :Break<CR>
nnoremap <silent> <leader>bc :Clear<CR>
nnoremap <silent> <leader>c :Continue<CR>
