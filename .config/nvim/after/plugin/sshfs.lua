require("sshfs").setup {
    mnt_base_dir = vim.fn.expand("$HOME") .. "/drive/workdir_uni/mnt_sshfs",
}
