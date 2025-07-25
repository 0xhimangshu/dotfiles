local presence = require('presence')

local function presence_statusline()
    -- If presence exposes a connection check, use it. Otherwise, always show icon if loaded.
    if presence.is_connected and presence:is_connected() then
        return ' '
    end
    -- Fallback: show icon if presence is loaded
    return ''
end

require('lualine').setup {
    options = {
        theme = 'onedark',
        section_separators = { left = '', right = '' },
        component_separators = { left = '', right = '' },
        icons_enabled = true,
        globalstatus = true,
        disabled_filetypes = { 'NvimTree', 'alpha' },
    },
    sections = {
        lualine_a = { { 'mode', icon = '' } },
        lualine_b = { { 'branch', icon = '' }, 'diff', 'diagnostics' },
        lualine_c = { { 'filename', path = 1, symbols = { modified = '●', readonly = '', unnamed = '[No Name]' } } },
        lualine_x = { presence_statusline, 'filetype', 'encoding', 'fileformat' },
        lualine_y = { 'progress' },
        lualine_z = { { 'location', icon = '' } },
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { { 'filename', path = 1 } },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {},
    },
    tabline = {},
    extensions = { 'nvim-tree', 'quickfix', 'fugitive' },
}
