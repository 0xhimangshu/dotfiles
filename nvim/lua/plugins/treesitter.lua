require('nvim-treesitter.configs').setup {
  ensure_installed = { 'lua', 'python', 'typescript', 'javascript', 'tsx', 'css', 'html', 'c' },
  highlight = { enable = true },
  autotag = { enable = true },
} 