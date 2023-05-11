local module = {}

module.setup = function()
  local cmp = require('cmp')
  cmp.setup {
    snippet = {
      expand = function(args)
        vim.call('vsnip#anonymous', args.body)
      end
    },
    mapping = cmp.mapping.preset.insert {
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<cr>'] = cmp.mapping.confirm { select = true },
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'nvim_lua' },
      { name = 'vsnip' },
    },
    {
      { name = 'path' },
      { name = 'buffer' },
    }),
  }
end

return module
