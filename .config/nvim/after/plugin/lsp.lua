local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(client, bufnr)
	-- see :help lsp-zero-keybindings
	-- to learn the available actions
	lsp.default_keymaps({buffer = bufnr})
end)

-- When you don't have mason.nvim installed
-- You'll need to list the servers installed in your system
lsp.setup_servers({ 'pyright', 'clangd' })

-- (Optional) Configure lua language server for neovim
-- require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

lsp.setup()

-- use enter to confirm completion
local cmp = require('cmp')

cmp.setup({
    mapping = 
    {
        ['<CR>'] = cmp.mapping.confirm({ select = true })
    },
})
