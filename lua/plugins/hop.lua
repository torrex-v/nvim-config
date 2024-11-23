return {
	"smoka7/hop.nvim",
	version = "*",
	opts = {
		keys = 'etovxqpdygfblzhckisuran"',
	},
	config = function()
		-- place this in one of your configuration file(s)
		local hop = require("hop")
		hop.setup({
			-- quit_key = '<SPC>'
		})
	end,
}
