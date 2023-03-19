local module = {}

local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<localleader>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<localleader>q', vim.diagnostic.setloclist, opts)

local function on_attach(client, bufnr)
  local bufopts = { noremap = true, silent = true, buffer = bufnr }

  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<localleader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<localleader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<localleader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<localleader>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<localleader>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<localleader>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<localleader>f', function()
    vim.lsp.buf.format { async = true }
  end, bufopts)

  vim.api.nvim_create_autocmd("CursorHold", {
    buffer = bufnr,
    callback = function()
      local opts = {
        focusable = false,
        close_events = { 'BufLeave', 'CursorMoved', 'InsertEnter', 'FocusLost' },
        source = 'always',
        scope = 'cursor',
      }
      vim.diagnostic.open_float(nil, opts)
    end
  })
end

module.setup = function()
  local nvim_lsp = require('lspconfig')
  local capabilities = require('cmp_nvim_lsp').default_capabilities()

  local options = {
    capabilities = capabilities,
    flags = { debounce_text_changes = 150 },
    on_attach = on_attach,
  }

  local servers = {
    'ansiblels',
    'clangd',
    'denols',
    'gopls',
    'hls',
    'jdtls',
    'nil_ls',
    'pyright',
    'rust_analyzer',
    'tailwindcss',
    'tsserver',
    'yamlls',
  }

  for _, server in ipairs(servers) do
    nvim_lsp[server].setup(options)
  end

  local home = vim.env.HOME
  local jdtls_options = {
    capabilities = options.capabilities,
    flags = options.flags,
    on_attach = options.on_attach,
    cmd = { 'jdt-language-server', '-configuration', home .. '/.cache/jdtls/config', '-data', home .. '/.cache/jdtls/workspace' },
    init_options = { jvm_args = {}, workspace = home .. '/.cache/jdtls/workspace' },
  }
  nvim_lsp.jdtls.setup(jdtls_options)

  local yamlls_options = {
    capabilities = options.capabilities,
    flags = options.flags,
    on_attach = options.on_attach,
    settings = {
      yaml = {
        schemas = {
          ['https://github.com/yannh/kubernetes-json-schema/raw/master/v1.25.3-standalone/all.json'] = '*.yml'
        }
      }
    }
  }
  nvim_lsp.yamlls.setup(yamlls_options)
end

return module
