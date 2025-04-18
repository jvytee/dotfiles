local config = function()
    local lualine = require("lualine")
    lualine.setup {
        extensions = {
            "quickfix",
        },
        options = {
            icons_enabled = false,
            theme = "auto"
        }
    }
end

return {
    { "nvim-lualine/lualine.nvim", dependencies = { "kyazdani42/nvim-web-devicons" }, config = config }
}
