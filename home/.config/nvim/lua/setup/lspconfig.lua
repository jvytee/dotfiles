local module = {}

local function on_attach(client, bufnr)
  local function buf_set_keymap(keys, cmd)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', keys, '<cmd>' .. cmd .. '<cr>', module.keymap_opts)
  end

  buf_set_keymap('gD', 'lua vim.lsp.buf.declaration()')
  buf_set_keymap('gd', 'lua vim.lsp.buf.definition()')
  buf_set_keymap('K', 'lua vim.lsp.buf.hover()')
  buf_set_keymap('gi', 'lua vim.lsp.buf.implementation()')
  buf_set_keymap('<C-k>', 'lua vim.lsp.buf.signature_help()')
  buf_set_keymap('<localleader>wa', 'lua vim.lsp.buf.add_workspace_folder()')
  buf_set_keymap('<localleader>wr', 'lua vim.lsp.buf.remove_workspace_folder()')
  buf_set_keymap('<localleader>wl', 'lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))')
  buf_set_keymap('<localleader>D', 'lua vim.lsp.buf.type_definition()')
  buf_set_keymap('<localleader>rn', 'lua vim.lsp.buf.rename()')
  buf_set_keymap('<localleader>ca', 'lua vim.lsp.buf.code_action()')
  buf_set_keymap('gr', 'lua vim.lsp.buf.references()')
  buf_set_keymap('<localleader>e', 'lua vim.lsp.diagnostic.show_line_diagnostics()')
  buf_set_keymap('[d', 'lua vim.lsp.diagnostic.goto_prev()')
  buf_set_keymap(']d', 'lua vim.lsp.diagnostic.goto_next()')
  buf_set_keymap('<localleader>q', 'lua vim.lsp.diagnostic.set_loclist()')
  buf_set_keymap('<localleader>f', 'lua vim.lsp.buf.formatting()')
end

module.setup = function(keymap_opts)
  module.keymap_opts = keymap_opts

  local nvim_lsp = require('lspconfig')
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

  local options = {
    capabilities = capabilities,
    flags = { debounce_text_changes = 150 },
    on_attach = on_attach,
  }

  local servers = {
    'ansiblels',
    'gopls',
    'hls',
    'pyright',
    'rust_analyzer',
    'tailwindcss',
    'tsserver',
    'volar',
    'yamlls',
  }

  for _, server in ipairs(servers) do
    nvim_lsp[server].setup(options)
  end
end

return module
