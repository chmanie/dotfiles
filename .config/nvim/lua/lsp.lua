local nvim_lsp = require('lspconfig')

-- enable null-ls integration
require('null-ls').config {}
nvim_lsp['null-ls'].setup {}

-- completion menu symbols
require('lspkind').init()

-- define prettier signs
vim.fn.sign_define('LspDiagnosticsSignError',
                   {text = '', texthl = 'LspDiagnosticsError'})
vim.fn.sign_define('LspDiagnosticsSignWarning',
                   {text = '', texthl = 'LspDiagnosticsWarning'})
vim.fn.sign_define('LspDiagnosticsSignInformation',
                   {text = '', texthl = 'LspDiagnosticsInformation'})
vim.fn.sign_define('LspDiagnosticsSignHint',
                   {text = '', texthl = 'LspDiagnosticsHint'})

-- needs eslint_d and prettier_d_slim binaries to be available
nvim_lsp.tsserver.setup {
    on_attach = function(client, bufnr)
        -- disable tsserver formatting if you plan on formatting via null-ls
        client.resolved_capabilities.document_formatting = false
        client.resolved_capabilities.document_range_formatting = false

        local function buf_set_keymap(...)
            vim.api.nvim_buf_set_keymap(bufnr, ...)
        end

        -- TODO: is this necessary?
        --[[ local function buf_set_option(...)
            vim.api.nvim_buf_set_option(bufnr, ...)
        end
        buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc') ]]

        -- Mappings.
        local opts = {noremap = true, silent = true}
        buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<cr>', opts)
        buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<cr>', opts)
        buf_set_keymap('n', 'ga', '<Cmd>lua vim.lsp.buf.code_action()<cr>', opts)
        buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<cr>', opts)
        buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
        buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<cr>',
                       opts)
        buf_set_keymap('n', '<leader>wa',
                       '<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>', opts)
        buf_set_keymap('n', '<leader>wr',
                       '<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>', opts)
        buf_set_keymap('n', '<leader>wl',
                       '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>',
                       opts)
        buf_set_keymap('n', '<leader>D',
                       '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
        buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
        buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
        buf_set_keymap('n', '<leader>e',
                       '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<cr>',
                       opts)
        buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>',
                       opts)
        buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<cr>',
                       opts)
        buf_set_keymap('n', '<leader>q',
                       '<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>', opts)
        buf_set_keymap('n', '<leader>f',
                       '<cmd>lua vim.lsp.buf.formatting()<cr>', opts)
        buf_set_keymap('n', 'gs', ':TSLspOrganize<CR>', opts)
        buf_set_keymap('n', 'gn', ':TSLspRenameFile<CR>', opts)
        buf_set_keymap('n', 'gl', ':TSLspImportAll<CR>', opts)

        local ts_utils = require('nvim-lsp-ts-utils')

        -- defaults
        ts_utils.setup {
            -- debug = false,
            enable_import_on_completion = true,

            -- eslint
            eslint_bin = 'eslint_d',
            eslint_enable_diagnostics = true,

            -- formatting
            enable_formatting = true,
            formatter = 'prettier_d_slim',
        }

        -- required to fix code action ranges and filter diagnostics
        ts_utils.setup_client(client)
    end
}
