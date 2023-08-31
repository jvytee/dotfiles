local config = function()
  vim.g.vim_json_conceal = 0

  local indent_blankline = require('indent_blankline')
  indent_blankline.setup {
    show_current_context = true,
    show_current_context_start = true,
  }
end

return {
  { "lukas-reineke/indent-blankline.nvim", config = config }
}
