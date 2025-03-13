require("bufferline").setup({
    options = {
        mode = "buffers",
        numbers = "ordinal",
        close_command = "bdelete! %d",
        right_mouse_command = "bdelete! %d",
        left_mouse_command = "buffer %d",
        middle_mouse_command = nil,
        indicator = { style = "icon", icon = "▎" },
        buffer_close_icon = "",
        modified_icon = "●",
        close_icon = "",
        left_trunc_marker = "",
        right_trunc_marker = "",
        diagnostics = "nvim_lsp",
        show_buffer_icons = true,
        show_buffer_close_icons = true,
        show_tab_indicators = true,
        separator_style = "slant",
        enforce_regular_tabs = true,
        always_show_bufferline = true,
        offsets = {
            {
                filetype = "NvimTree",
                text = "📂 File Explorer",
                text_align = "center",
                separator = true,
            },
        },
    },
})

