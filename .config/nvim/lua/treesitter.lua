local ts_config = require('nvim-treesitter.configs')

ts_config.setup {
    ensure_installed = {
        'c', 'cpp', 'css', 'bash', 'cpp', 'html', 'javascript', 'lua', 'rust',
        'tsx', 'typescript'
    },
    highlight = {enable = true, use_languagetree = true},
    indent = {enable = true}
}
