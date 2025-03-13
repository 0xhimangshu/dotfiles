require("mason").setup()
require("mason-lspconfig").setup({
        ensure_installed = { "ts_ls", "pyright", "lua_ls", "html", "cssls" }
    }
)

