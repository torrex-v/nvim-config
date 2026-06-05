local cmp = require("cmp")
local luasnip = require("luasnip")
local lspkind = require("lspkind")

-- Configure Luasnip
luasnip.config.set_config({
    history = false,
    updateevents = "TextChanged,TextChangedI",
})

-- Load snippets
require("luasnip.loaders.from_vscode").lazy_load()

-- Diagnostic config
vim.diagnostic.config({
    float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = if_many,
        header = "",
        prefix = "",
    },
})

-- Initialize lspkind
-- lspkind.init({})

cmp.setup({
    completion = {
        completeopt = "menu,menuone,preview", -- Removed 'select' to prevent auto-selection
    },
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body) -- Use only luasnip, remove others
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Restored Enter key
        ["<Tab>"] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace }),
    }),
    sources = cmp.config.sources({
        { name = "nvim_lsp", priority = 10 }, -- Give LSP highest priority
        { name = "luasnip",  priority = 8 },
        { name = "buffer",   priority = 5 },
        { name = "path",     priority = 3 },
        -- Comment out conflicting sources temporarily for debugging
        -- { name = "sg" },
        -- { name = "supermaven" },
    }),
    formatting = {
        format = function(entry, item)
            -- No lspkind, just return the item
            return item
        end,
    },
    -- formatting = {
    --     format = function(entry, item)
    --         -- Custom format that preserves rust-analyzer's label details
    --         local kind = lspkind.cmp_format({
    --             mode = "symbol_text",
    --             maxwidth = 50,
    --             ellipsis_char = "...",
    --             show_labelDetails = true, -- CRITICAL for rust-analyzer completions
    --         })(entry, item)
    --
    --         -- Add menu info without breaking the completion
    --         local menu_icon = {
    --             nvim_lsp = "λ",
    --             luasnip = "✂",
    --             buffer = "≡",
    --             path = "📁",
    --         }
    --         kind.menu = menu_icon[entry.source.name] or ""
    --
    --         return kind
    --     end,
    -- },
})

-- Cmdline setups (keep these as they are, but remove conflicting sources)
cmp.setup.cmdline("/", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = "buffer" },
    },
})

cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = "path" },
    }, {
        {
            name = "cmdline",
            option = {
                ignore_cmds = { "Man", "!" },
            },
        },
    }),
})

-- Database filetype setup
cmp.setup.filetype({ "sql" }, {
    sources = {
        { name = "vim-dadbod-completion" },
        { name = "buffer" },
    },
})
