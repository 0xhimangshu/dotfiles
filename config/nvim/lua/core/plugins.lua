local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({ "git", "clone", "--filter=blob:none", 
                    "https://github.com/folke/lazy.nvim.git", lazypath })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    { "williamboman/mason.nvim" },
    { "williamboman/mason-lspconfig.nvim" },
    { "neovim/nvim-lspconfig" },

    { "neoclide/coc.nvim", branch = "release" },

    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },

    { "nvim-neo-tree/neo-tree.nvim", dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons", "MunifTanjim/nui.nvim" } },

    { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },

    { "lewis6991/gitsigns.nvim" },

    { "folke/tokyonight.nvim" },

    { "nvim-tree/nvim-web-devicons" },

    { "nvim-lualine/lualine.nvim", dependencies = "nvim-tree/nvim-web-devicons" },

    { "akinsho/bufferline.nvim", dependencies = { "nvim-tree/nvim-web-devicons" } },   
    -- { "glepnir/lspsaga.nvim" },

    { "lewis6991/hover.nvim" },

    { "folke/neodev.nvim" },
    
    { "github/copilot.vim" }
})

