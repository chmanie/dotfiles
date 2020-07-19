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
" Language stuff
Plug 'pangloss/vim-javascript' 
Plug 'maxmellon/vim-jsx-pretty'
Plug 'jparise/vim-graphql'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'rhysd/vim-clang-format'
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

" Blink cursor on error instead of beeping (grr)
set visualbell

" Encoding
set encoding=utf-8

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

set signcolumn=no

" Whitespace
set wrap
set textwidth=80
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

" Move up/down editor lines
nnoremap j gj
nnoremap k gk

" Rendering
set ttyfast

" Regex engine
set re=2

" Status bar
" Give more space for displaying messages (might otherwise require CR to
" continue)
set cmdheight=2
set laststatus=2
set noshowmode " we have the mode in the status bar
" Last line
set showcmd

" Searching
set hlsearch
set incsearch
set noignorecase
set smartcase
set showmatch
map <leader><space> :let @/=''<cr> " clear search

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

" FILE BROWSING
" Freed <C-l> in Netrw
nmap <leader><leader>l <Plug>NetrwRefresh 
" Be able to delete non-emtpy directories
let g:netrw_localrmdir="rm -r" 
" Hide files ignored by git
let g:netrw_list_hide=netrw_gitignore#Hide()
" Conveniently open netrw
nnoremap <C-_> :Ex<CR>
" Show .h files properly
set suffixes-=.h

" Color scheme (terminal)
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

colorscheme iceberg

" Font adjustments
hi htmlArg gui=italic
hi Comment gui=italic
hi Type    gui=italic
hi htmlArg cterm=italic
hi Comment cterm=italic
hi Type    cterm=italic

" Formatting
map <leader>q gqip

" COC related stuff
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

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

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

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

" Use leader-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
nmap <leader>s <C-s> <Plug>(coc-range-select)
xmap <leader>s <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')
nmap <silent> <leader>f :Format<CR>

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" c++ syntax highlighting
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1

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

