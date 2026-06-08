local config = function()
    vim.opt.conceallevel = 2

    local orgmode = require "orgmode"
    orgmode.setup {
        org_agenda_files = "~/notes/**/*"
    }
end

return {
    "nvim-orgmode/orgmode",
    event = "VeryLazy",
    ft = { "org" },
    config = config,
}
