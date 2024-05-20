return {
	"folke/which-key.nvim",
	dependencies = {
		{ "folke/neoconf.nvim", cmd = "Neoconf" },
		"folke/neodev.nvim",
	},
	config = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 300
		require("which-key").setup()
	end,
}
