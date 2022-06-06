local module = {}

module.setup = function()
  local indent_blankline = require('indent_blankline')
  indent_blankline.setup {
    show_current_context = true,
    show_current_context_start = true,
  }
end

return module
