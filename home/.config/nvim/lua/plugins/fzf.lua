local config = function()
  local opts = require("on_attach").opts

  vim.keymap.set("n", "<leader>b", "<cmd>Buffers<cr>", opts)
  vim.keymap.set("n", "<leader>f", "<cmd>FZF<cr>", opts)
  vim.keymap.set("n", "<leader>g", "<cmd>GitFiles<cr>", opts)
  vim.keymap.set("n", "<leader>r", "<cmd>Rg<cr>", opts)
  vim.keymap.set("n", "<leader>m", "<cmd>Maps<cr>", opts)
end

return {
  "junegunn/fzf.vim",
  config = config,
  dependencies = { "junegunn/fzf" },
}
