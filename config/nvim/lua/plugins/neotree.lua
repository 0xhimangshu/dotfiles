require("neo-tree").setup({
  close_if_last_window = true, -- Close Neo-tree if it's the last window
  popup_border_style = "rounded",
  enable_git_status = true,
  enable_diagnostics = true,

  filesystem = {
    filtered_items = {
      visible = true, -- Show hidden files
      hide_dotfiles = false,
      hide_gitignored = false,
    },
    follow_current_file = true, -- Keep the file explorer in sync with open file
    use_libuv_file_watcher = true, -- Auto-refresh when files change
  },

  window = {
    position = "left", -- Sidebar position
    width = 35, -- Sidebar width
    mappings = {
      ["<space>"] = "toggle_node", -- Expand/collapse folders
      ["o"] = "open",
      ["<CR>"] = "open",
      ["s"] = "open_split",
      ["v"] = "open_vsplit",
      ["t"] = "open_tabnew",
      ["C"] = "close_node",
      ["R"] = "refresh",
    }
  },

  buffers = { follow_current_file = true }, -- Keep buffer in sync
  git_status = { symbols = { unstaged = "", staged = "✓", untracked = "★" } }
})

