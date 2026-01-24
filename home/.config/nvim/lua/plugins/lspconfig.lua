local function attach_fn(ev)
    local builtin = require "telescope.builtin"
    local bufnr = ev.buf
    local bufopts = function(description)
        return { noremap = true, silent = true, buffer = bufnr, desc = description }
    end

    vim.keymap.set("n", "gd", builtin.lsp_definitions, bufopts("Find definitions"))
    vim.keymap.set("n", "gr", builtin.lsp_references, bufopts("Find all references"))
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts("Find declaration"))
    vim.keymap.set("n", "gI", builtin.lsp_implementations, bufopts("Find implementations"))
    vim.keymap.set("n", "gT", builtin.lsp_type_definitions, bufopts("Find type definitions"))
    vim.keymap.set("n", "K", function()
        vim.lsp.buf.hover { border = "rounded" }
    end, bufopts("Hover"))
    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts("Signature help"))
    vim.keymap.set("n", "<localleader>a", vim.lsp.buf.code_action, bufopts("Code action"))
    vim.keymap.set("n", "<localleader>r", vim.lsp.buf.rename, bufopts("Rename"))
    vim.keymap.set("n", "<localleader>f", function()
        vim.lsp.buf.format { async = true }
    end, bufopts("Format buffer"))
    vim.keymap.set("n", "<localleader>ws", builtin.lsp_workspace_symbols, bufopts("List workspace symbols"))
    vim.keymap.set("n", "<localleader>wa", vim.lsp.buf.add_workspace_folder, bufopts("Add workspace folder"))
    vim.keymap.set("n", "<localleader>wr", vim.lsp.buf.remove_workspace_folder, bufopts("Remove workspace folder"))
    vim.keymap.set("n", "<localleader>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts("List workspace folders"))

    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    vim.api.nvim_create_autocmd("CursorHold", {
        buffer = bufnr,
        callback = function()
            local opts = {
                border = "rounded",
                close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
                focusable = false,
                scope = "cursor",
                source = "always",
            }
            vim.diagnostic.open_float(nil, opts)
        end
    })
end

local config = function()
    local servers = {
        "ansiblels",
        "clangd",
        "gopls",
        "hls",
        "html",
        "jdtls",
        "nixd",
        "ruff",
        "rust_analyzer",
        "tailwindcss",
        "terraformls",
        "tinymist",
        "ts_ls",
        "ty",
        "yamlls",
    }

    for _, server in ipairs(servers) do
        vim.lsp.enable(server)
    end

    vim.lsp.config("*", {
        capabilities = vim.tbl_deep_extend("force", vim.lsp.protocol.make_client_capabilities(), require("cmp_nvim_lsp").default_capabilities()),
        flags = { debounce_text_changes = 150 },
    })

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
    "neovim/nvim-lspconfig", config = config,
}
