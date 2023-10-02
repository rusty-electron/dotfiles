vim.g.mapleader = " "
vim.keymap.set("n", "<leader>fo", vim.cmd.Oil)

vim.keymap.set("n", "-", require("oil").open, { desc = "Open parent directory" })

-- remap keys for buffer navigation
vim.keymap.set("n", "<leader>]", "<cmd>bnext<cr>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>[", "<cmd>bprevious<cr>", { desc = "Previous buffer" })
vim.keymap.set("n", "<leader>bc", "<cmd>bdelete<cr>", { desc = "Close buffer" })

-- remap keys for window navigation
vim.keymap.set("n", "<leader>h", '<C-w>h', { noremap = true, silent = true, desc = "Move to left window" })
vim.keymap.set("n", "<leader>j", '<C-w>j', { noremap = true, silent = true, desc = "Move to down window" })
vim.keymap.set("n", "<leader>k", '<C-w>k', { noremap = true, silent = true, desc = "Move to up window" })
vim.keymap.set("n", "<leader>l", '<C-w>l', { noremap = true, silent = true, desc = "Move to right window" })

-- remap keys for toggle term
vim.keymap.set("n", ",t", "<cmd>ToggleTerm<cr>", { desc = "Toggle terminal" })

-- remap keys for nvim-dap
vim.keymap.set("n", "<leader>dc", "<cmd>lua require('dap').continue()<cr>", { desc = "Debugger: Continue" })
vim.keymap.set("n", "<leader>db", "<cmd>lua require('dap').toggle_breakpoint()<cr>", { desc = "Debugger: Toggle breakpoint" })

-- remap keys for zen mode
vim.keymap.set("n", "<leader>zm", "<cmd>ZenMode<cr>", { desc = "Toggle zen mode" })
