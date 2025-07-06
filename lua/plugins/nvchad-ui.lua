return {
	{
		"nvchad/base46",
		lazy = true,
		build = function()
			require("base46").load_all_highlights()
		end,
	},
	{
		"nvchad/ui",
		config = function()
			require("nvchad")
		end,
	},

	"nvzone/volt",
	"nvzone/menu",
	{ "nvzone/minty", cmd = { "Huefy", "Shades" } },
}
