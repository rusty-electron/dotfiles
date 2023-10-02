require("rusty.remap")
require("rusty.set")

vim.cmd('colorscheme rose-pine')

--- setup plugins
require("oil").setup()

require("lualine").setup {
    options = {
        theme = "rose-pine"
    }
}

require("bufferline").setup {}

require("toggleterm").setup {}

-- disable auto commenting of new lines
vim.cmd("autocmd BufEnter * setlocal formatoptions-=cro")
vim.cmd("autocmd BufEnter * set formatoptions-=cro")
