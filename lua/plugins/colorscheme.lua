return {
	{
		"morhetz/gruvbox",
		name = "gruvbox",
		priority = 1000,
		lazy = false,
		config = function()
			-- require("gruvbox").setup({})
		end,
	},
	"ayu-theme/ayu-vim",
	"rktjmp/lush.nvim",
	"tckmn/hotdog.vim",
	"dundargoc/fakedonalds.nvim",
	"craftzdog/solarized-osaka.nvim",
	"tjdevries/colorbuddy.nvim",
	"tjdevries/gruvbuddy.nvim",
	{ "rose-pine/neovim", name = "rose-pine" },
	"eldritch-theme/eldritch.nvim",
	"jesseleite/nvim-noirbuddy",
	"vim-scripts/MountainDew.vim",
	"miikanissi/modus-themes.nvim",
	"rebelot/kanagawa.nvim",
	"gremble0/yellowbeans.nvim",
	{ "ellisonleao/gruvbox.nvim" },
	{ "folke/tokyonight.nvim" },
	{ "rose-pine/neovim" },
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		lazy = false,
		config = function()
			--require('rose-pine').setup({
			--    disable_background = true
			--
			--})
			local latte = require("catppuccin.palettes").get_palette("latte")
			local frappe = require("catppuccin.palettes").get_palette("frappe")
			local macchiato = require("catppuccin.palettes").get_palette("macchiato")
			local mocha = require("catppuccin.palettes").get_palette("mocha")
			-- require("catppuccin").setup({
			--     flavour = "mocha", -- latte, frappe, macchiato, mocha
			--     background = {     -- :h background
			--         light = "latte",
			--         dark = "mocha",
			--     },
			--     transparent_background = true, -- disables setting the background color.
			--     show_end_of_buffer = false,    -- shows the '~' characters after the end of buffers
			--     term_colors = false,           -- sets terminal colors (e.g. `g:terminal_color_0`)
			--     dim_inactive = {
			--         enabled = false,           -- dims the background color of inactive window
			--         shade = "dark",
			--         percentage = 0.15,         -- percentage of the shade to apply to the inactive window
			--     },
			--     no_italic = false,             -- Force no italic
			--     no_bold = false,               -- Force no bold
			--     no_underline = false,          -- Force no underline
			--     styles = {                     -- Handles the styles of general hi groups (see `:h highlight-args`):
			--         comments = { "italic" },   -- Change the style of comments
			--         conditionals = { "italic" },
			--         loops = {},
			--         functions = {},
			--         keywords = {},
			--         strings = {},
			--         variables = {},
			--         numbers = {},
			--         booleans = {},
			--         properties = {},
			--         types = {},
			--         operators = {},
			--     },
			--     color_overrides = {},
			--     custom_highlights = {},
			--     integrations = {
			--         cmp = true,
			--         gitsigns = true,
			--         nvimtree = true,
			--         treesitter = true,
			--         notify = false,
			--         mini = false,
			--         native_lsp = {
			--             enabled = true,
			--             virtual_text = {
			--                 errors = { "italic" },
			--                 hints = { "italic" },
			--                 warnings = { "italic" },
			--                 information = { "italic" },
			--             },
			--             underlines = {
			--                 errors = { "underline" },
			--                 hints = { "underline" },
			--                 warnings = { "underline" },
			--                 information = { "underline" },
			--             },
			--             inlay_hints = {
			--                 background = true,
			--             },
			--         },
			--         telescope = {
			--             enabled = true,
			--             -- style = "nvchad"
			--         }
			--         -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
			--     },
			-- })
			-- require("catppuccin").setup()
		end,
	},
	{
		"loctvl842/monokai-pro.nvim",
		config = function() end,
	},
}
