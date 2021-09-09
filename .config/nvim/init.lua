local cmd = vim.cmd
local g = vim.g
local set = vim.api.nvim_set_option
local wset = vim.api.nvim_win_set_option
local keymap = vim.api.nvim_set_keymap

g.mapleader = ','

-- color scheme
g.tokyonight_style = 'night'
g.tokyonight_italic_functions = true
g.tokyonight_sidebars = {'terminal', 'packer'}

require 'pluginlist'
require 'treesitter'
require 'lsp'
require 'completion'
require 'statusline'
require 'ctrlp'
require 'zettel'

require('nvim-autopairs').setup()
require('surround').setup({})

wset(0, 'number', true)
set('compatible', false)
set('filetype', 'on')
set('modelines', 0)
set('visualbell', true)
set('encoding', 'utf-8')
set('hidden', true)

set('autoread', true)
-- Reload the file when entering buffer
-- @TODO see https://github.com/neovim/neovim/pull/12378
cmd('au FocusGained,BufEnter * :silent! !')

set('backup', false)
set('writebackup', false)
set('updatetime', 300)
set('signcolumn', 'number')
set('wrap', true)
set('textwidth', 80)
set('formatoptions', 'tcqrn1')
set('tabstop', 2)
set('shiftwidth', 2)
set('expandtab', true)
set('shiftround', false)

-- cursor motion
set('scrolloff', 3)
set('backspace', 'indent,eol,start')
-- @TODO no idea how to do this in lua
cmd('set matchpairs+=<:>') -- use % to jump between pairs

-- status bar
set('laststatus', 2)
set('showmode', false)
set('showcmd', true)

-- search stuff
set('hlsearch', true)
set('incsearch', true)
set('ignorecase', false)
set('smartcase', true)
set('showmatch', true)
keymap('', '<leader><space>', ':let @/=\'\'<cr>', {silent = true}) -- clear search
set('grepprg', 'rg --vimgrep')
-- Type // in visual mode to find text that is selected
keymap('v', '//', 'y/\\V<C-R>=escape(@",\'/\')<CR><CR>',
       {noremap = true, silent = true})

-- free some keymaps (e.g. ctrl-p)
--[[ keymap('n', 'j', 'gj', {noremap = true})
keymap('n', 'k', 'gk', {noremap = true}) ]]

-- file browsing
g.netrw_banner = 0
g.netrw_list_hide =
    '.*\\.swp$,.DS_Store,*/tmp/*,*.so,*.swp,*.zip,*.git,^\\.\\=/\\=$'
-- Conveniently open netrw
keymap('n', '<C-]>', '<cmd>Ex<cr>', {noremap = true})
-- free <C-l> in netrw (for tmux navigator)
keymap('n', '<leader><leader>l', '<Plug>NetrwRefresh', {})
-- Show .h files properly
cmd('set suffixes-=.h')

cmd('set termguicolors')
cmd('colorscheme tokyonight')

-- terminal-debug
g.termdebug_popup = 0
g.termdebug_wide = 163
g.termdebugger = 'arm-none-eabi-gdb'
-- g.termdebugger_program = "tio -b 115200 /dev/cu.usbmodem1433203"
g.termdebugger_program = "openocd"
keymap('n', '<leader>d', ':Termdebug<cr>', {noremap = true})
keymap('t', '<Esc>', '<C-\\><C-n>', {noremap = true})
keymap('n', '<leader>b', ':Break<cr>', {noremap = true, silent = true})
keymap('n', '<leader>bc', ':Clear<cr>', {noremap = true, silent = true})
keymap('n', '<leader>c', ':Continue<cr>', {noremap = true, silent = true})
keymap('n', '<leader>g', ':Evaluate<cr>', {noremap = true})

-- for ferrine/md-img-paste.vim
cmd(
    'autocmd FileType markdown nmap <buffer><silent> <leader>p :call mdip#MarkdownClipboardImage()<CR>');

-- @Note: not needed for tokyo night. Enable again if using different
-- colorscheme
-- italic colorscheme modifications
--[[ cmd('hi htmlArg gui=italic')
cmd('hi Comment gui=italic')
cmd('hi Type    gui=italic')
cmd('hi htmlArg cterm=italic')
cmd('hi Comment cterm=italic')
cmd('hi Type    cterm=italic') ]]
