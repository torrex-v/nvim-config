vim.g.mapleader = " "
local map = vim.keymap.set
--map("n", "<leader>pv", vim.cmd.Ex)
local opts = { noremap = true, silent = true }
opts.desc = "Last buffer"
-- map("n", "<leader>x", "<cmd>.lua<CR>", { desc = "Execute the current line" })
-- map("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })
map("n", "<leader><leader>x", "<cmd>source %<CR>", { desc = "Execute the current file" })
map("n", "<M-,>", "<c-w>5<")
map("n", "<M-.>", "<c-w>5>")
map("n", "<M-t>", "<C-W>+")
map("n", "<M-s>", "<C-W>-")
-- nvchad shortcuts
map("n", "<C-h>", "<C-w>h", { desc = "switch window left" })
map("n", "<C-l>", "<C-w>l", { desc = "switch window right" })
map("n", "<C-j>", "<C-w>j", { desc = "switch window down" })
map("n", "<C-k>", "<C-w>k", { desc = "switch window up" })

map("n", "<Esc>", "<cmd>noh<CR>", { desc = "general clear highlights" })

map("n", "<C-s>", "<cmd>w<CR>", { desc = "general save file" })
map("n", "<C-c>", "<cmd>%y+<CR>", { desc = "general copy whole file" })
-- map("n", "<leader>n", "<cmd>set nu!<CR>", { desc = "toggle line number" })
-- map("n", "<leader>rn", "<cmd>set rnu!<CR>", { desc = "toggle relative number" })
-- map("n", "<leader>ch", "<cmd>NvCheatsheet<CR>", { desc = "toggle nvcheatsheet" })

map("n", "<leader>x", function()
	require("nvchad.tabufline").close_buffer()
end, { desc = "buffer close" })
map("n", "<tab>", function()
	require("nvchad.tabufline").next()
end, { desc = "buffer goto next" })

map("n", "<S-tab>", function()
	require("nvchad.tabufline").prev()
end, { desc = "buffer goto prev" })
map("n", "<leader>th", function()
	require("nvchad.themes").open()
end, { desc = "telescope nvchad themes" })
--------------------
map("n", "<leader>[", ":bprevious<CR>", opts)
opts.desc = "Next buffer"
map("n", "<leader>]", ":bnext<CR>", opts)
map("n", "<leader>pv", ":Neotree filesystem reveal left toggle<CR>")
map("n", "<leader>pvb", ":Neotree buffers float<CR>")
map("n", "<leader>pvg", ":Neotree git_status float <CR>")

map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

map("n", "J", "mzJ`z")
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

map("n", "<leader>vwm", function()
	require("vim-with-me").StartVimWithMe()
end)
map("n", "<leader>svwm", function()
	require("vim-with-me").StopVimWithMe()
end)

-- greatest remap ever
map("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
map({ "n", "v" }, "<leader>y", [["+y]])
map("n", "<leader>Y", [["+Y]])
map("n", "<leader>pp", [["+p]])

map({ "n", "v" }, "<leader>d", [["_d]])

-- This is going to get me cancelled
map("i", "<C-c>", "<Esc>")

map("n", "Q", "<nop>")
map("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
map("n", "<leader>f", vim.lsp.buf.format)

map("n", "<C-k>", "<cmd>cnext<CR>zz")
map("n", "<C-j>", "<cmd>cprev<CR>zz")
map("n", "<leader>k", "<cmd>lnext<CR>zz")
map("n", "<leader>j", "<cmd>lprev<CR>zz")

map("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- map("n", "<leader>vpp", "<cmd>e ~/AppData/Local/nvim/lua/thepayman/lazy.lua<CR>")
map("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>")

map("n", "gpd", "<cmd>lua require('goto-preview').goto_preview_definition()<CR>")
map("n", "gpt", "<cmd>lua require('goto-preview').goto_preview_type_definition()<CR>")
map("n", "gpi", "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>")
map("n", "gP", "<cmd>lua require('goto-preview').close_all_win()<CR>")
map("n", "gpr", "<cmd>lua require('goto-preview').goto_preview_references()<CR>")

map("n", "<leader><leader>", function()
	vim.cmd("so")
end)

vim.api.nvim_set_keymap("n", "<F5>", '<Cmd>lua require"dap".continue()<CR>', { silent = true })
vim.api.nvim_set_keymap("n", "<F10>", '<Cmd>lua require"dap".step_over()<CR>', { silent = true })
vim.api.nvim_set_keymap("n", "<F11>", '<Cmd>lua require"dap".step_into()<CR>', { silent = true })
vim.api.nvim_set_keymap("n", "<F12>", '<Cmd>lua require"dap".step_out()<CR>', { silent = true })
vim.api.nvim_set_keymap("n", "<Leader>b", '<Cmd>lua require"dap".toggle_breakpoint()<CR>', { silent = true })
vim.api.nvim_set_keymap(
	"n",
	"<Leader>B",
	'<Cmd>lua require"dap".map_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>',
	{ silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<Leader>lp",
	'<Cmd>lua require"dap".map_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>',
	{ silent = true }
)
vim.api.nvim_set_keymap("n", "<Leader>dr", '<Cmd>lua require"dap".repl.open()<CR>', { silent = true })
vim.api.nvim_set_keymap("n", "<Leader>dl", '<Cmd>lua require"dap".run_last()<CR>', { silent = true })
vim.api.nvim_set_keymap(
	"n",
	"<Leader>ss",
	'<Cmd>lua require"sg.extensions.telescope".fuzzy_search_result()<CR>',
	{ silent = false }
)
