local config = function()
  vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
    callback = function()
      require("lint").try_lint()
    end
  })

  require("lint").linters_by_ft = {
    markdown = { "markdownlint" },
    python = { "mypy" }
  }
end

return {
  "mfussenegger/nvim-lint",
  config = config
}
