local config = function()
    local gitsigns = require("gitsigns")
    gitsigns.setup()
    vim.keymap.set("n", "gb", gitsigns.blame_line, nil)
end

return {
    "lewis6991/gitsigns.nvim", config = config,
}
