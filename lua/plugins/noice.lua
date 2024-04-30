return {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify"
    },
    config = function()
        -- require("noice").setup({
        --     messages = {
        --         enabled = false,             -- enables the Noice messages UI
        --     },
        --     notify = {
        --         enabled = false,
        --         view = "notify",
        --     },
        --     lsp = {
        --         progress = {
        --             enabled = true,
        --             --- @type NoiceFormat|string
        --             format = "lsp_progress",
        --             --- @type NoiceFormat|string
        --             format_done = "lsp_progress_done",
        --             throttle = 1000 / 30, -- frequency to update lsp progress message
        --             view = "mini",
        --         },
        --         message = {
        --             -- Messages shown by lsp servers
        --             enabled = true,
        --             view = "notify",
        --             opts = {},
        --         },
        --     },
        -- })

        vim.keymap.set("n", "<leader>nd", "<cmd>NoiceDismiss<CR>", { desc = "Dismiss Noice Message" })
    end
}
