local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  { 'navarasu/onedark.nvim' },
  { 'nvim-tree/nvim-tree.lua',            dependencies = { 'nvim-tree/nvim-web-devicons' } },
  { 'nvim-telescope/telescope.nvim',      dependencies = { 'nvim-lua/plenary.nvim' } },
  { 'nvim-lualine/lualine.nvim',          dependencies = { 'nvim-tree/nvim-web-devicons' } },
  { 'akinsho/bufferline.nvim',            dependencies = { 'nvim-tree/nvim-web-devicons' } },
  { 'neovim/nvim-lspconfig' },
  { 'williamboman/mason.nvim' },
  { 'williamboman/mason-lspconfig.nvim' },
  { 'hrsh7th/nvim-cmp' },
  { 'hrsh7th/cmp-nvim-lsp' },
  { 'L3MON4D3/LuaSnip' },
  { 'saadparwaiz1/cmp_luasnip' },
  { 'nvimtools/none-ls.nvim' },
  { 'nvim-treesitter/nvim-treesitter',    build = ':TSUpdate' },
  { 'windwp/nvim-autopairs' },
  { 'windwp/nvim-ts-autotag' },
  { 'lewis6991/gitsigns.nvim' },
  { 'lukas-reineke/indent-blankline.nvim' },
  { 'folke/todo-comments.nvim' },
  { 'folke/noice.nvim',                   dependencies = { 'MunifTanjim/nui.nvim', 'rcarriga/nvim-notify' } },
  { 'stevearc/dressing.nvim' },
  { 'folke/which-key.nvim' },
  { 'utilyre/barbecue.nvim',              dependencies = { 'SmiteshP/nvim-navic' } },
  { 'echasnovski/mini.icons' },
  { 'himonshuuu/presence.nvim',           branch = 'main',                                                  lazy = false }
})
require('plugins')
