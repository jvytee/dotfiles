local module = {}

module.setup = function()
  local nvim_ts = require('nvim-treesitter.configs')
  nvim_ts.setup {
    ensure_installed = {
      'cpp',
      'haskell',
      'html',
      'javascript',
      'lua',
      'nix',
      'python',
      'rust',
      'typescript',
      'vue',
      'yaml',
    },
    highlight = { enable = true },
    indent = { enable = true },
  }
end

return module
