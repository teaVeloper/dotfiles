local zettel_path = "~/workspace/zettelkasten"

if true then
    return {}
end

return {

    -- calendar usefull for telekasten
    "renerocksai/calendar-vim",

    -- telekasten for zettelkasten notes
    {
        "renerocksai/telekasten.nvim",
        dependencies = { "nvim-telescope/telescope.nvim" },
        config = {
            home = vim.fn.expand(zettel_path .. "/zettel"),
            dailies = vim.fn.expand(zettel_path .. "/daily"),
            weeklies = vim.fn.expand(zettel_path .. "/weekly"),
            templates = vim.fn.expand(zettel_path .. "/templates"),
            new_note_location = "smart",
            template_new_daily = vim.fn.expand(zettel_path .. "/templates/daily.md"),
        },
    },
}
