require('noice').setup({
    cmdline = {
        view = "cmdline_popup", -- or "cmdline" for a minimal look
        format = {
            cmdline = { icon = "", title = "Command" },
            search_down = { icon = " ", title = "Search Down" },
            search_up = { icon = " ", title = "Search Up" },
            filter = { icon = "", title = "Filter" },
            lua = { icon = "", title = "Lua" },
            help = { icon = "", title = "Help" },
        },
    },
    popupmenu = {
        enabled = true,  -- enables a modern popup menu for completions
        backend = "nui", -- use the NUI backend for best visuals
    },
    lsp = {
        override = {
            ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
            ['vim.lsp.util.stylize_markdown'] = true,
            ['cmp.entry.get_documentation'] = true,
        },
    },
    presets = {
        bottom_search = true,   -- command line at the bottom
        command_palette = true, -- position the command palette
        long_message_to_split = true,
        inc_rename = false,
        lsp_doc_border = true,
    },
    messages = {
        enabled = false, -- disable debug messages
    },
})
