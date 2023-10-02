require("indent_blankline").setup {
    show_end_of_line = false,
}

-- avoid indent lines in dashboard
vim.g.indent_blankline_filetype_exclude = {"dashboard"}
