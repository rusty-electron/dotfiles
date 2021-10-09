vim.api.nvim_set_keymap('n', '<leader>jj', "<cmd>lua require'hop'.hint_words()<cr>", {})
vim.api.nvim_set_keymap('n', '<leader>jc', "<cmd>lua require'hop'.hint_char1()<cr>", { noremap=true, silent=true })

function _G.set_terminal_keymaps()
  local opts = {noremap = true}
  vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<A-k>', [[<C-\><C-n><C-W>k]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-c>t', [[<C-\><C-n>:ToggleTerm<CR>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

-- for toggleterm
vim.api.nvim_set_keymap('n', '<C-c>t', ':ToggleTerm<CR>', { noremap = true, silent = false })

-- for autopairs
require('nvim-autopairs').setup{}
