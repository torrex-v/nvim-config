local cmp = require("cmp")

local luasnip = require("luasnip")
luasnip.config.set_config({
	history = false,
	updateevents = "TextChanged,TextChangedI",
})
local lspkind = require("lspkind")
lspkind.init({})
-- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
	completion = {
		completeopt = "menu,menuone,preview,select",
	},
	snippet = { -- configure how nvim-cmp interacts with snippet engine
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
		["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete({
			-- config = {
			--     sources = {
			--         { name = "cody" },
			--     }
			-- },
		}), -- show completion suggestions
		["<C-e>"] = cmp.mapping.abort(), -- close completion window
		-- ["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<TAB>"] = cmp.mapping.confirm({
			select = true,
			behavior = cmp.ConfirmBehavior.Replace,
		}), -- confirm completion
	}),
	-- sources for autocompletion
	sources = cmp.config.sources({
		{ name = "cody" },
		{ name = "nvim_lsp" },
		{ name = "luasnip" }, -- snippets
		{ name = "vsnip" }, -- snippets
		{ name = "buffer" }, -- text within current buffer
		{ name = "path" }, -- file system paths
	}),
	-- configure lspkind for vs-code like pictograms in completion menu
	formatting = {
		format = lspkind.cmp_format({
			maxwidth = 50,
			ellipsis_char = "...",
			with_text = true,
			menu = {
				nvim_lsp = "[LSP]",
				cody = "[cody]",
			},
		}),
	},
})
-- `/` cmdline setup.
cmp.setup.cmdline("/", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" },
		{ name = "cody" },
	},
})

-- `:` cmdline setup.
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
cmp.setup.filetype({ "sql" }, {
	sources = {
		{ name = "vim-dadbod-completion" },
		{ name = "buffer" },
	},
})
