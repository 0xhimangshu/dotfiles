local map = vim.keymap.set
map("n", "<Leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
map("n", "<Leader>f", ":Telescope find_files<CR>", { noremap = true, silent = true })
map("n", "<C-h>", "<C-w>h")
map("n", "<C-l>", "<C-w>l")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")

map("n", "<Tab>", ":BufferLineCycleNext<CR>", { noremap = true, silent = true })
map("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", { noremap = true, silent = true })
map("n", "<Leader>q", ":bdelete<CR>", { noremap = true, silent = true })

