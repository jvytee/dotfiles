local config = function()
  local builtin = require("telescope.builtin")

  vim.keymap.set("n", "<leader>b", builtin.buffers, {})
  vim.keymap.set("n", "<leader>f", builtin.find_files, {})
  vim.keymap.set("n", "<leader>g", builtin.git_files, {})
  vim.keymap.set("n", "<leader>k", builtin.keymaps, {})
  vim.keymap.set("n", "<leader>r", builtin.live_grep, {})
end

return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = { "nvim-lua/plenary.nvim" },
  priority = 900
}
