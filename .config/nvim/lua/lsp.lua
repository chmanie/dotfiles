vim.cmd [[packadd nvim-lspconfig]]
vim.cmd [[packadd nvim-compe]]
vim.cmd [[packadd lspkind-nvim]]
vim.cmd [[packadd vim-vsnip]]
vim.cmd [[packadd neoformat]]

local g = vim.g
local keymap = vim.api.nvim_set_keymap

-- neoformat config
g.neoformat_enabled_lua = {'luaformat'}
vim.api
    .nvim_set_keymap('n', '<leader>f', '<cmd>Neoformat<cr>', {noremap = true})

-- nvim-lspconfig
local nvim_lsp = require('lspconfig')

-- rust-tools
require('rust-tools').setup()

-- snippets.nvim
g.completion_enable_snippet = 'vim-vsnip'
keymap('i', '<Tab>', "vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<Tab>'",
       {expr = true})
keymap('s', '<Tab>', "vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<Tab>'",
       {expr = true})
keymap('i', '<S-Tab>',
       "vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>'",
       {expr = true})
keymap('s', '<S-Tab>',
       "vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>'",
       {expr = true})

function on_attach(client)
    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end
    local function buf_set_option(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
    end

    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

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

    -- set some keybinds conditional on server capabilities
    if client.resolved_capabilities.document_formatting then
        buf_set_keymap('n', '<leader>f',
                       '<cmd>lua vim.lsp.buf.formatting()<cr>', opts)
    elseif client.resolved_capabilities.document_range_formatting then
        buf_set_keymap('n', '<leader>f',
                       '<cmd>lua vim.lsp.buf.range_formatting()<cr>', opts)
    end
end

-- enable snippet support
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport =
    {properties = {'documentation', 'detail', 'additionalTextEdits'}}

-- enable diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] =
    vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics,
                 {virtual_text = true, signs = true, update_in_insert = false})

nvim_lsp.tsserver.setup({on_attach = on_attach})

nvim_lsp.rust_analyzer.setup({
    capabilities = capabilities,
    on_attach = on_attach
})

nvim_lsp.clangd.setup({
    on_attach = on_attach,
    cmd = {
        'clangd', '--background-index', '--compile-commands-dir=build',
        -- @TODO we need to make this project specific
        '--query-driver=/usr/local/bin/arm-none-eabi-*'
    }
})

nvim_lsp.pyright.setup({on_attach = on_attach})

-- completion menu symbols
require('lspkind').init()
