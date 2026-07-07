--require('nvim-treesitter.install').compilers = { "gcc" }
-- require("config.nvchadUi")
require("config.set")
require("config.remap")

vim.opt.termguicolors = true
-- message be buffer
vim.o.cmdheight = 0
require("vim._core.ui2").enable()
-- Rounded completion menu
vim.opt.pumborder = "rounded"

-- Rounded borders for built-in floating windows
vim.opt.winborder = "rounded"

-- No command line when idle (works especially well with UI2)
vim.opt.cmdheight = 0

vim.cmd("syntax on")
vim.cmd("filetype plugin indent on")

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
