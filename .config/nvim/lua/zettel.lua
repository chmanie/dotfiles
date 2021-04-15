local g = vim.g
local keymap = vim.api.nvim_set_keymap

-- vimwiki and notes settings
g.vimwiki_list = {
    {
        path = '~/Nextcloud/Notes',
        syntax = 'markdown',
        ext = '.md',
        index = 'Wiki'
    }
}
g.vimwiki_global_ext = 0

keymap('n', '<leader>we', '<cmd>Telescope telenotes list<cr>', {noremap = true})
