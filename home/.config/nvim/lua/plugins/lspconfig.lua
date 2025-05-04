local config = function()
    local nvim_lsp = require "lspconfig"

    local on_attach = require "on_attach"
    local opts = on_attach.opts
    local attach_fn = on_attach.attach_fn

    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    local flags = { debounce_text_changes = 150 }

    local options = {
        capabilities = capabilities,
        flags = flags,
    }

    local servers = {
        "ansiblels",
        "clangd",
        "gopls",
        "hls",
        "jdtls",
        "nil_ls",
        "pyright",
        "ruff",
        "rust_analyzer",
        "terraformls",
        "ts_ls",
        "yamlls",
    }

    for _, server in ipairs(servers) do
        vim.lsp.enable(server)
    end

    vim.lsp.config("gopls", {
        settings = {
            ["gopls"] = {
                hints = {
                    assignVariableTypes = true,
                    compositeLiteralFields = true,
                    compositeLiteralTypes = true,
                    constantValues = true,
                    functionTypeParameters = true,
                    parameterNames = true,
                    rangeVariableTypes = true,
                }
            },
        },
    })

    vim.lsp.config("rust_analyzer", {
        settings = {
            ["rust-analyzer"] = {
                check = {
                    command = "clippy",
                },
            },
        },
    })

    vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = attach_fn,
    })
end

return {
    "neovim/nvim-lspconfig",
    config = config,
}
