return {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    lazy = false,
    priority = 100,
    dependencies = {
        "hrsh7th/cmp-buffer",           -- source for text in buffer
        "hrsh7th/cmp-path",             -- source for file system paths
        "hrsh7th/cmp-cmdline",          -- source for file system paths
        "L3MON4D3/LuaSnip",             -- snippet engine
        "saadparwaiz1/cmp_luasnip",     -- for autocompletion
        "rafamadriz/friendly-snippets", -- useful snippets
        "onsails/lspkind.nvim",
        'hrsh7th/cmp-nvim-lsp',
        { "antosha417/nvim-lsp-file-operations", config = true },
    },
    config = function()
        require "custom.completion"
    end,
}
