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

-- TypeScript/JavaScript LSP (for React)
lspconfig.ts_ls.setup({
  filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
})

-- Tailwind CSS LSP
lspconfig.tailwindcss.setup({
  filetypes = { "html", "css", "javascript", "javascriptreact", "typescript", "typescriptreact" },
  root_dir = lspconfig.util.root_pattern("tailwind.config.js", "tailwind.config.ts", "package.json", ".git"),
})


local bg_color = vim.fn.synIDattr(vim.fn.hlID("Normal"), "bg")

-- Enable LSP (TypeScript, Python, etc.)
lspconfig.lua_ls.setup({ on_attach = on_attach })
lspconfig.pyright.setup({})
lspconfig.html.setup({})
lspconfig.cssls.setup({})
lspconfig.rust_analyzer.setup({})

