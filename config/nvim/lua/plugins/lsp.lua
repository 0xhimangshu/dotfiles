local lspconfig = require("lspconfig")
require("neodev").setup({})

lspconfig.lua_ls.setup({
    settings = {
        Lua = {
            runtime = { version = "LuaJIT" },
            diagnostics = {
                globals = { "vim" }, -- 👈 Marks 'vim' as a known global
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true), -- Loads Neovim runtime files
            },
            telemetry = { enable = false },
        },
    },
})

local bg_color = vim.fn.synIDattr(vim.fn.hlID("Normal"), "bg")

-- Enable LSP (TypeScript, Python, etc.)
lspconfig.lua_ls.setup({ on_attach = on_attach })
lspconfig.ts_ls.setup({})
lspconfig.pyright.setup({})
lspconfig.html.setup({})
lspconfig.cssls.setup({})

