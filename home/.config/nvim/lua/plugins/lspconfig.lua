local on_attach = require "on_attach"
local opts = on_attach.opts
local attach_fn = on_attach.attach_fn

vim.keymap.set("n", "<localleader>e", function()
  vim.diagnostic.open_float(nil, {
    focusable = false,
    close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
    source = "always",
    scope = "cursor",
  })
end, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<localleader>q", vim.diagnostic.setloclist, opts)

local config = function()
  local nvim_lsp = require("lspconfig")
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
    "jedi_language_server",
    "nil_ls",
    "ruff_lsp",
    "terraformls",
    "tsserver",
    "yamlls",
  }

  for _, server in ipairs(servers) do
    nvim_lsp[server].setup(options)
  end

  nvim_lsp.rust_analyzer.setup {
    capabilities = capabilities,
    flags = flags,
    settings = {
      ["rust-analyzer"] = {
        check = {
          command = "clippy",
        },
      },
    },
  }

  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = attach_fn,
  })
end

return {
  { "neovim/nvim-lspconfig", config = config }
}
