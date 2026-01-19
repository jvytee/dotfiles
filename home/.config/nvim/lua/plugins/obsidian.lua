return {
    "obsidian-nvim/obsidian.nvim",
    version = "*",
    ft = "markdown",
    opts = {
        legacy_commands = false,
        workspaces = {
            { name = "Notes", path = "~/notes", strict = true },
        },
        daily_notes = { folder = "00 Daily" },
        completion = { nvim_cmp = true, min_chars = 2 },
    },
}
