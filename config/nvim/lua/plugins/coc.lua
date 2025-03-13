vim.g.coc_global_extensions = {
    "coc-tsserver",
    "coc-python",
    "coc-json",
    "coc-html",
    "coc-css",
    "coc-prettier"
}

vim.keymap.set("n", "gd", "<Plug>(coc-definition)")
vim.keymap.set("n", "gr", "<Plug>(coc-references)")
vim.keymap.set("n", "K", "<Plug>(coc-hover)")

