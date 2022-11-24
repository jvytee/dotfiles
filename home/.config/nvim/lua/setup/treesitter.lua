local module = {}

module.setup = function()
  local nvim_ts = require('nvim-treesitter.configs')
  nvim_ts.setup {
    ensure_installed = {
      'cpp',
      'css',
      'go',
      'haskell',
      'html',
      'javascript',
      'json',
      'lua',
      'nix',
      'python',
      'rust',
      'toml',
      'typescript',
      'tsx',
      'yaml',
    },
    highlight = { enable = true },
    indent = { enable = true },
    refactor = {
      highlight_definitions = {
        enable = true,
        clear_on_cursor_move = true,
      },
    },
  }
end

return module
