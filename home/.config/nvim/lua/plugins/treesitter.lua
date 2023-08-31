local build = function()
  local ts_update = require("nvim-treesitter.install").update { with_sync = true }
  ts_update()
end

local config = function()
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
      'terraform',
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

return {
	{ "nvim-treesitter/nvim-treesitter", build = build, config = config },
	"nvim-treesitter/nvim-treesitter-refactor"
}
