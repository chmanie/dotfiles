vim.cmd [[packadd telescope.nvim]]

local keymap = vim.api.nvim_set_keymap
local telescope = require('telescope')

telescope.setup {
    extensions = {telenotes = {tn_note_dir = '~/Nextcloud/Notes'}}
}
telescope.load_extension('fzy_native')

keymap('n', '<C-p>', '<cmd>Telescope find_files<CR>', {noremap = true})
keymap('n', '\\', '<cmd>Telescope live_grep<CR>', {noremap = true})
keymap('n', '<C-n>', '<cmd>Telescope buffers<CR>', {noremap = true})
