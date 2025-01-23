local opts = { noremap = true, silent = true }

local function attach_fn(ev)
    local builtin = require "telescope.builtin"
    local bufnr = ev.buf
    local bufopts = { noremap = true, silent = true, buffer = bufnr }

    vim.keymap.set("n", "<localleader>e", function()
        vim.diagnostic.open_float(nil, {
            focusable = false,
            close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
            source = "always",
            scope = "cursor",
        })
    end, bufopts)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, bufopts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, bufopts)
    vim.keymap.set("n", "<localleader>q", builtin.diagnostics, bufopts)

    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
    vim.keymap.set("n", "gd", builtin.lsp_definitions, bufopts)
    vim.keymap.set("n", "gi", builtin.lsp_implementations, bufopts)
    vim.keymap.set("n", "gr", builtin.lsp_references, bufopts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set("n", "<localleader>a", vim.lsp.buf.code_action, bufopts)
    vim.keymap.set("n", "<localleader>r", vim.lsp.buf.rename, bufopts)
    vim.keymap.set("n", "<localleader>f", function()
        vim.lsp.buf.format { async = true }
    end, bufopts)
    vim.keymap.set("n", "<localleader>t", builtin.lsp_type_definitions, bufopts)
    vim.keymap.set("n", "<localleader>s", builtin.lsp_workspace_symbols, bufopts)
    vim.keymap.set("n", "<localleader>wa", vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set("n", "<localleader>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set("n", "<localleader>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)

    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    vim.api.nvim_create_autocmd("CursorHold", {
        buffer = bufnr,
        callback = function()
            local opts = {
                focusable = false,
                close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
                source = "always",
                scope = "cursor",
            }
            vim.diagnostic.open_float(nil, opts)
        end
    })
end

return {
    opts = opts,
    attach_fn = attach_fn,
}
