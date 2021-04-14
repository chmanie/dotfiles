local keymap = vim.api.nvim_set_keymap

keymap('n', '<C-p>', '<cmd>Telescope find_files<CR>', { noremap = true })
keymap('n', '\\', '<cmd>Telescope live_grep<CR>', { noremap = true })
keymap('n', '<C-n>', '<cmd>Telescope buffers<CR>', { noremap = true })
keymap('n', '<leader>e', '<cmd>Telescope telenotes list<cr>', { noremap = true })
