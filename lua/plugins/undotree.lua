local function ensure_diff()
	if vim.fn.has("win32") == 1 and vim.fn.executable("diff") == 0 then
		local candidates = {}

		local git_path = vim.fn.exepath("git")
		if git_path ~= "" then
			local git_dir = vim.fs.dirname(vim.fs.dirname(git_path))
			table.insert(candidates, vim.fs.joinpath(git_dir, "usr", "bin"))
		end

		table.insert(candidates, "C:\\Program Files\\Git\\usr\\bin")
		table.insert(candidates, "C:\\Program Files (x86)\\Git\\usr\\bin")
		if vim.env.LOCALAPPDATA then
			table.insert(candidates, vim.fs.joinpath(vim.env.LOCALAPPDATA, "Programs", "Git", "usr", "bin"))
		end

		for _, dir in ipairs(candidates) do
			if vim.fn.executable(vim.fs.joinpath(dir, "diff.exe")) == 1 then
				vim.env.PATH = vim.env.PATH .. ";" .. dir
				break
			end
		end
	end
end

ensure_diff()

return {
	"mbbill/undotree",
	init = ensure_diff,
	config = function()
		ensure_diff()
		vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Toggle undo tree" })
	end,
}

