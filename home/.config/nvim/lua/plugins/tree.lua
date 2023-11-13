local config = function()
  local tree = require("nvim-tree")
  tree.setup {
    renderer = {
      add_trailing = true,
      group_empty = true,
      highlight_git = true,
      highlight_opened_files = "all",
    }
  }
end

return {
  { "nvim-tree/nvim-tree.lua", config = config }
}
