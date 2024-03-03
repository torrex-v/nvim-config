return {
    "epwalsh/obsidian.nvim",
    version = "*",
    lazy = true,
    ft = "markdown",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    config = function()
        vim.keymap.set("n", "<leader>ob", ":Obsidian<CR>", { noremap = true, silent = true })
        vim.keymap.set("n", "<leader>on", ":ObsidianNew<CR>", { noremap = true, silent = true })
        vim.keymap.set("n", "<leader>oc", ":ObsidianClose<CR>", { noremap = true, silent = true })
        vim.keymap.set("n", "<leader>ot", ":ObsidianToggle<CR>", { noremap = true, silent = true })
        vim.keymap.set("n", "<leader>oT", ":ObsidianToggleAll<CR>", { noremap = true, silent = true })
        vim.keymap.set("n", "<leader>oR", ":ObsidianRefresh<CR>", { noremap = true, silent = true })

        require("obsidian").setup({
            workspaces = {
                {
                    name = "personal",
                    path = "~/Documents/Obsidian Vaults",
                },
            },
            wiki_link_func = function(opts)
                if opts.id == nil then
                    return string.format("[[%s]]", opts.label)
                elseif opts.label ~= opts.id then
                    return string.format("[[%s|%s]]", opts.id, opts.label)
                else
                    return string.format("[[%s]]", opts.id)
                end
            end,
            completion = {
                nvim_cmp = true,
                min_chars = 2,
            },
        })
    end
}
