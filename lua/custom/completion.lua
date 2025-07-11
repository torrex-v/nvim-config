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
vim.diagnostic.config({
	-- update_in_insert = true,
	float = {
		focusable = false,
		style = "minimal",
		border = "rounded",
		source = "always",
		header = "",
		prefix = "",
	},
})
cmp.setup({
	completion = {
		completeopt = "menu,menuone,preview,select",
	},
	snippet = { -- configure how nvim-cmp interacts with snippet engine
		expand = function(args)
			-- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
			luasnip.lsp_expand(args.body)
			-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
			vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
			vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
		["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(), -- close completion window
		-- ["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<TAB>"] = cmp.mapping.confirm({
			select = false,
			behavior = cmp.ConfirmBehavior.Replace,
		}), -- confirm completion
	}),
	-- sources for autocompletion
	sources = cmp.config.sources({
		-- { name = "copilot" }, -- text within current buffer
		{ name = "sg" },
		{ name = "supermaven" },
		{ name = "nvim_lsp" },
		-- { name = "vsnip" }, -- snippets
		{ name = "luasnip" }, -- snippets
		{ name = "buffer" }, -- text within current buffer
		{ name = "path" }, -- file system paths
	}),
	-- configure lspkind for vs-code like pictograms in completion menu
	formatting = {
		format = lspkind.cmp_format({
			maxwidth = 50,
			ellipsis_char = "...",
			with_tsxt = true,
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
		-- { name = "nvim_lsp" },
		{ name = "vsnip" },
		{ name = "buffer" },
		{ name = "cody" },
	},
})

-- `:` cmdline setup.
cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
		-- { name = "nvim_lsp" },
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
