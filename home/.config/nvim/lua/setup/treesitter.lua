local module = {}

module.setup = function()
  local nvim_ts = require('nvim-treesitter.configs')
  nvim_ts.setup {
    ensure_installed = {
      'c',
      'cpp',
      'css',
      'go',
      'gomod',
      'gosum',
      'haskell',
      'html',
      'java',
      'javascript',
      'json',
      'lua',
      'markdown',
      'markdown_inline',
      'meson',
      'nix',
      'python',
      'rust',
      'scheme',
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
