local module = {
  setup = function()
    local tree = require('nvim-tree')
    tree.setup {
      renderer = {
        add_trailing = true,
        group_empty = true,
        highlight_git = true,
        highlight_opened_files = 'all',
        icons = {
          show = {
            file = false,
            folder = false,
            folder_arrow = false,
            git = false,
          }
        }
      }
    }
  end
}

return module
