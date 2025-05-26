return {
    "epwalsh/obsidian.nvim",
    version = "*",
    lazy = true,
    ft = "markdown",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
        workspaces = {
            { name = "Notes", path = "~/Sync/Notes" },
            { name = "Second Brain", path = "~/Sync/Second Brain" },
        },
        daily_notes = { folder = "00 Daily" },
        completion = { nvim_cmp = true, min_chars = 2 },
        disable_frontmatter = true,
        mappings = {
            ["<localleader>t"] = {
                action = function()
                    vim.cmd "ObsidianToday"
                end,
                opts = { buffer = true },
            },
        },
    },
}
