local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- general settings
--------------------

-- remove trailing whitespace from end of lines
autocmd('BufWritePre', {
    pattern = '',
    command = ":%s/\\s\\+$//e"
})

-- remove trailing newlines from end of lines
autocmd('BufWritePre', {
    pattern = '',
    command = ":%s/\\n\\+\\%$//e"
})

-- disable auto commenting of new lines (not working)
-- possible cause: ftp plugin
-- autocmd('BufEnter', {
--     callback = function()
--         vim.opt.formatoptions:remove { "c", "r", "o" }
--     end,
--     group = general,
--     desc = 'disable auto commenting of new lines',
-- })
