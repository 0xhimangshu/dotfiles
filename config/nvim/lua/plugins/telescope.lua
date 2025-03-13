require("telescope").setup()
vim.keymap.set("n", "<Leader>f", ":Telescope find_files<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>g", ":Telescope live_grep<CR>", { noremap = true, silent = true })

