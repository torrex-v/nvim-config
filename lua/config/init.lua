--require('nvim-treesitter.install').compilers = { "gcc" }
require("config.set")
require("config.remap")

local augroup = vim.api.nvim_create_augroup
local group = augroup("thePayman", {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup("HighlightYank", {})

function R(name)
	require("plenary.reload").reload_module(name)
end

autocmd("TextYankPost", {
	group = yank_group,
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch",
			timeout = 40,
		})
	end,
})

autocmd({ "BufWritePre" }, {
	group = group,
	pattern = "*",
	command = [[%s/\s\+$//e]],
})

function ColorMyPencils(color, noBg)
	color = color or "catppuccin"
	noBg = noBg or false
	vim.cmd.colorscheme(color)
	if noBg then
		vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
		vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
	end
end
