local map = vim.keymap.set

-- File Explorer
map("n", "<A-e>", ":Neotree toggle<CR>", { noremap = true, silent = true })
map("n", "<A-f>", ":Neotree focus<CR>", { noremap = true, silent = true })

-- File Search & Fuzzy Finder
map("n", "<Leader>f", ":Telescope find_files<CR>", { noremap = true, silent = true })
map("n", "<Leader>g", ":Telescope live_grep<CR>", { noremap = true, silent = true })

-- Save File
map("n", "<C-s>", ":w<CR>", { noremap = true, silent = true })
map("i", "<C-s>", "<Esc>:w<CR>a", { noremap = true, silent = true })

-- Split Navigation
map("n", "<C-h>", "<C-w>h", { noremap = true, silent = true })
map("n", "<C-l>", "<C-w>l", { noremap = true, silent = true })
map("n", "<C-j>", "<C-w>j", { noremap = true, silent = true })
map("n", "<C-k>", "<C-w>k", { noremap = true, silent = true })

-- Window Resizing
map("n", "<A-h>", ":vertical resize -2<CR>", { noremap = true, silent = true })
map("n", "<A-l>", ":vertical resize +2<CR>", { noremap = true, silent = true })
map("n", "<A-j>", ":resize -2<CR>", { noremap = true, silent = true })
map("n", "<A-k>", ":resize +2<CR>", { noremap = true, silent = true })

-- Buffer Navigation (Replaces BufferLine with default buffer controls)
map("n", "<Tab>", ":bnext<CR>", { noremap = true, silent = true })
map("n", "<S-Tab>", ":bprev<CR>", { noremap = true, silent = true })
map("n", "<Leader>q", ":bd<CR>", { noremap = true, silent = true })

-- Tab Management
map("n", "<Leader>tn", ":tabnew<CR>", { noremap = true, silent = true })
map("n", "<Leader>tc", ":tabclose<CR>", { noremap = true, silent = true })
map("n", "<Leader>to", ":tabonly<CR>", { noremap = true, silent = true })

-- Quick Escape from Insert Mode
map("i", "jk", "<Esc>", { noremap = true, silent = true })

-- Better Indentation in Visual Mode
map("v", "<", "<gv", { noremap = true, silent = true })
map("v", ">", ">gv", { noremap = true, silent = true })

