-- Load core settings
require("core.options")
require("core.keymaps")
require("core.plugins")

-- Load plugin configurations
require("plugins.mason")
require("plugins.coc")
require("plugins.lsp")
require("plugins.treesitter")
require("plugins.telescope")
require("plugins.neotree")
require("plugins.git")
require("plugins.theme")
require("plugins.pyright")

require("plugins.icons")
require("plugins.bufferline")
require("plugins.lualine")

vim.opt.number = true
vim.opt.relativenumber = true

vim.diagnostic.config({
    virtual_text = false,
    float = { border = "rounded" },
})

-- Set the time (in milliseconds) before triggering CursorHold
vim.opt.updatetime = 1000  -- 1000ms = 1 second

-- Create an autocommand for CursorHold to show hover documentation
vim.api.nvim_create_autocmd("CursorHold", {
    pattern = "*",
    callback = function()
        -- Check if a hover window is already open
        if not vim.b.hover_open then
            vim.lsp.buf.hover()
        end
    end,
})

-- Function to close hover window gracefully
local function close_hover()
    if vim.b.hover_open and vim.api.nvim_win_is_valid(vim.b.hover_win) then
        vim.api.nvim_win_close(vim.b.hover_win, true)
        vim.b.hover_open = false
    end
end

-- Override the default LSP hover handler
vim.lsp.handlers["textDocument/hover"] = function(_, result, ctx, config)
    -- Close existing hover window if open
    close_hover()

    -- Call the default hover handler
    local bufnr, winnr = vim.lsp.handlers.hover(_, result, ctx, config)

    -- If a window was opened, track its state
    if winnr and vim.api.nvim_win_is_valid(winnr) then
        vim.b[bufnr].hover_open = true
        vim.b[bufnr].hover_win = winnr

        -- Close the hover window when the cursor moves
        vim.api.nvim_create_autocmd("CursorMoved", {
            buffer = bufnr,
            once = true,
            callback = function()
                close_hover()
            end,
        })
    end

    return bufnr, winnr
end

