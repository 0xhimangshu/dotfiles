local lspconfig = require("lspconfig")

lspconfig.pyright.setup({
    settings = {
        python = {
            analysis = {
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = "openFilesOnly",
            },
            pythonPath = vim.fn.exepath("python"), -- Detects the current virtualenv Python
        },
    },
})

