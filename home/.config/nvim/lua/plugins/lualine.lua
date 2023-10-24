local config = function()
  local lualine = require("lualine")
  lualine.setup {
    extensions = {
      "fzf",
      "quickfix",
    },
    options = {
      icons_enabled = false,
      theme = "gruvbox-material"
    }
  }
end

return {
  { "nvim-lualine/lualine.nvim", dependencies = { "kyazdani42/nvim-web-devicons" }, config = config }
}
