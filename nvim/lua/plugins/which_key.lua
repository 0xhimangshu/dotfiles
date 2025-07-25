local wk = require("which-key")

wk.setup {
  window = {
    border = "single",        -- or "rounded", "shadow", etc.
    position = "center",      -- center the popup
    margin = { 2, 2, 2, 2 },  -- extra space around the popup
    padding = { 2, 2, 2, 2 }, -- extra space within the popup
    winblend = 0,             -- transparency
  },
}
