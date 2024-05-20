local data = assert(vim.fn.stdpath("data")) --[[@as string]]

require("telescope").setup({
	extensions = {
		fzf = {},
		["ui-select"] = {
			require("telescope.themes").get_dropdown({
				-- even more opts
			}),
		},
		wrap_results = true,
		-- history = {
		-- 	path = vim.fs.joinpath(data, "telescope_history.sqlite3"),
		-- 	limit = 100,
		-- },
	},
})

pcall(require("telescope").load_extension, "fzf")
-- pcall(require("telescope").load_extension, "smart_history")
pcall(require("telescope").load_extension, "ui-select")
pcall(require("telescope").load_extension, "noice")
pcall(require("telescope").load_extension, "wrap_results")
local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
vim.keymap.set("n", "<leader>gw", builtin.grep_string)
vim.keymap.set("n", "<C-p>", builtin.git_files, {})
vim.keymap.set("n", "<leader>ps", function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)

vim.keymap.set("n", "<leader>/", builtin.current_buffer_fuzzy_find)

vim.keymap.set("n", "<leader>fa", function()
	---@diagnostic disable-next-line: param-type-mismatch
	builtin.find_files({ cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy") })
end)

vim.keymap.set("n", "<space>en", function()
	builtin.find_files({ cwd = vim.fn.stdpath("config") })
end)
