local config = function()
  local tree = require("nvim-tree")
  tree.setup {
    renderer = {
      add_trailing = true,
      group_empty = true,
      highlight_git = true,
      highlight_opened_files = "all",
    },
    view = {
      width = 32,
    },
  }
end

return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = config
}
