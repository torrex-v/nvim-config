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
        vim.keymap.set("n", "<leader>on", ":ObsidianNew<CR>", { noremap = true, silent =true})
        vim.keymap.set("n", "<leader>oc", ":ObsidianClose<CR>", { noremap = true, silent =true})
        vim.keymap.set("n", "<leader>ot", ":ObsidianToggle<CR>", { noremap = true, silent =true})
        vim.keymap.set("n", "<leader>oT", ":ObsidianToggleAll<CR>", { noremap = true, silent =true})
        vim.keymap.set("n", "<leader>oR", ":ObsidianRefresh<CR>", { noremap = true, silent =true})

        require("obsidian").setup({
                workspaces = {
                    {
                        name = "personal",
                        path = "~/Documents/Obsidian Vaults",
                    },
                },
                completion = {
                    nvim_cmp = true,
                    min_chars = 2,
                    prepend_note_id=true,
                },
        })
    end
}
