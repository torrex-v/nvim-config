return {
	"rmagatti/auto-session",
	config = function()
		require("auto-session").setup({
			auto_session_suppress_dirs = { "~/", "~/personal/projects/", "~/Downloads", "/" },
			session_lens = {
				buftypes_to_ignore = {}, -- list of buffer types what should not be deleted from current session
				load_on_setup = true,
				theme_conf = { border = true },
				previewer = false,
				picker = "telescope",
			},
			-- vim.keymap.set("n", "<leader>ls", require("auto-session.session-lens").search_session, {
			-- 	noremap = true,
			-- }),
			-- Set keymap to open session lens WITHOUT requiring a non-existent module
			vim.keymap.set("n", "<leader>ls", "<cmd>Autosession search<CR>", {
				desc = "Search sessions with session-lens",
				noremap = true,
			}),
		})
	end,
}
