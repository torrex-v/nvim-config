return {
	"sourcegraph/sg.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },

	-- If you have a recent version of lazy.nvim, you don't need to add this!
	build = "nvim -l build/init.lua",
	config = function()
		require("sg").setup({})
		local telescope = require("telescope.builtin")
		vim.keymap.set("n", "<space>ss", telescope.live_grep, { desc = "Search results" })

		-- require("sourcegraph").setup({})
	end,
}
