local module = {}

module.setup = function()
  local lualine = require('lualine')
  lualine.setup {
    extensions = {
      'fzf',
      'quickfix',
    },
    options = {
      icons_enabled = false,
      theme = 'onedark'
    }
  }
end

return module
