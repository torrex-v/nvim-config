return {
    "theprimeagen/refactoring.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    "lewis6991/async.nvim",
    },
  lazy = false,
    config = function()
        -- require('plenary')
        -- _G.async = require('plenary.async')

        require('refactoring').setup({})

        vim.api.nvim_set_keymap("v", "<leader>ri",
            [[ <Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]],
            { noremap = true, silent = true, expr = false })
    end
}
