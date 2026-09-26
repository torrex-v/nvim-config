vim.g.mapleader = " "
local map = vim.keymap.set
map("n", "<leader>pv", vim.cmd.Ex, { desc = "Open file explorer (netrw)" })
local opts = { noremap = true, silent = true }
opts.desc = "Last buffer"
-- map("n", "<leader>x", "<cmd>.lua<CR>", { desc = "Execute the current line" })
-- map("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })
map("n", "<leader><leader>x", "<cmd>source %<CR>", { desc = "Execute the current file" })
map("n", "<M-,>", "<c-w>5<", { desc = "Shrink window width" })
map("n", "<M-.>", "<c-w>5>", { desc = "Grow window width" })
map("n", "<M-t>", "<C-W>+", { desc = "Grow window height" })
map("n", "<M-s>", "<C-W>-", { desc = "Shrink window height" })
-- nvchad shortcuts
map("n", "<C-h>", "<C-w>h", { desc = "switch window left" })
map("n", "<C-l>", "<C-w>l", { desc = "switch window right" })
map("n", "<C-j>", "<C-w>j", { desc = "switch window down" })
map("n", "<C-k>", "<C-w>k", { desc = "switch window up" })

map("n", "<Esc>", "<cmd>noh<CR>", { desc = "general clear highlights" })

-- greatest remap ever
map("x", "<leader>p", [["_dP]], { desc = "Paste over selection without losing register" })

-- next greatest remap ever : asbjornHaland
map({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to system clipboard" })
map("n", "<leader>Y", [["+Y]], { desc = "Yank line to system clipboard" })
map("n", "<leader>pp", [["+p]], { desc = "Paste from system clipboard" })

map({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete without yanking" })

map("i", "<C-c>", "<Esc>", { desc = "Exit insert mode" })
-- map("n", "<C-s>", "<cmd>w<CR>", { desc = "general save file" })
-- map("n", "<C-c>", "<cmd>%y+<CR>", { desc = "general copy whole file" })
-- map("n", "<leader>n", "<cmd>set nu!<CR>", { desc = "toggle line number" })
-- map("n", "<leader>rn", "<cmd>set rnu!<CR>", { desc = "toggle relative number" })
-- map("n", "<leader>ch", "<cmd>NvCheatsheet<CR>", { desc = "toggle nvcheatsheet" })

local map = vim.keymap.set

-- Close current buffer
map("n", "<leader>x", "<cmd>bdelete<CR>", { desc = "Close buffer" })

-- Next buffer
map("n", "<Tab>", "<cmd>BufferLineCycleNext<CR>", { desc = "Next buffer" })

-- Previous buffer
map("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<CR>", { desc = "Previous buffer" })
--------------------
map("n", "<leader>[", ":bprevious<CR>", opts)
opts.desc = "Next buffer"
map("n", "<leader>]", ":bnext<CR>", opts)

-- Jump list navigation (VS Code style: Ctrl+- to jump back, Ctrl+= or Alt+Right to jump forward)
map("n", "<C-->", "<C-o>", { desc = "Jump backward (jump list)" })
map("n", "<C-_>", "<C-o>", { desc = "Jump backward (jump list, terminal)" })
map("n", "<C-=>", "<cmd>execute 'normal! \\<lt>C-i>'<CR>", { desc = "Jump forward (jump list)" })
map("n", "<M-Left>", "<C-o>", { desc = "Jump backward (jump list)" })
map("n", "<M-Right>", "<cmd>execute 'normal! \\<lt>C-i>'<CR>", { desc = "Jump forward (jump list)" })

map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

map("n", "J", "mzJ`z", { desc = "Join line below without moving cursor" })
map("n", "<C-d>", "<C-d>zz", { desc = "Half-page down and center" })
map("n", "<C-u>", "<C-u>zz", { desc = "Half-page up and center" })
map("n", "n", "nzzzv", { desc = "Next search result and center" })
map("n", "N", "Nzzzv", { desc = "Previous search result and center" })

map("n", "<leader>vwm", function()
	require("vim-with-me").StartVimWithMe()
end, { desc = "Start Vim With Me" })
map("n", "<leader>svwm", function()
	require("vim-with-me").StopVimWithMe()
end, { desc = "Stop Vim With Me" })
-- This is going to get me cancelled

map("n", "Q", "<nop>", { desc = "Disable Ex mode" })
map("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>", { desc = "Open tmux sessionizer" })
map("n", "<leader>f", vim.lsp.buf.format, { desc = "Format buffer" })

map("n", "<C-k>", "<cmd>cnext<CR>zz", { desc = "Next quickfix item" })
map("n", "<C-j>", "<cmd>cprev<CR>zz", { desc = "Previous quickfix item" })
map("n", "<leader>k", "<cmd>lnext<CR>zz", { desc = "Next location list item" })
map("n", "<leader>j", "<cmd>lprev<CR>zz", { desc = "Previous location list item" })

map("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Search and replace word under cursor" })

-- map("n", "<leader>vpp", "<cmd>e ~/AppData/Local/nvim/lua/thepayman/lazy.lua<CR>")
map("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>", { desc = "Make it rain (cellular automaton)" })

map("n", "gpd", "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", { desc = "Preview definition" })
map("n", "gpt", "<cmd>lua require('goto-preview').goto_preview_type_definition()<CR>", { desc = "Preview type definition" })
map("n", "gpi", "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>", { desc = "Preview implementation" })
map("n", "gP", "<cmd>lua require('goto-preview').close_all_win()<CR>", { desc = "Close all preview windows" })
map("n", "gpr", "<cmd>lua require('goto-preview').goto_preview_references()<CR>", { desc = "Preview references" })

map("n", "<leader><leader>", function()
	vim.cmd("so")
end, { desc = "Source current file" })

vim.api.nvim_set_keymap("n", "<F5>", '<Cmd>lua require"dap".continue()<CR>', { silent = true, desc = "Debug: continue" })
vim.api.nvim_set_keymap("n", "<F10>", '<Cmd>lua require"dap".step_over()<CR>', { silent = true, desc = "Debug: step over" })
vim.api.nvim_set_keymap("n", "<F11>", '<Cmd>lua require"dap".step_into()<CR>', { silent = true, desc = "Debug: step into" })
vim.api.nvim_set_keymap("n", "<F12>", '<Cmd>lua require"dap".step_out()<CR>', { silent = true, desc = "Debug: step out" })
vim.api.nvim_set_keymap("n", "<Leader>b", '<Cmd>lua require"dap".toggle_breakpoint()<CR>', { silent = true, desc = "Debug: toggle breakpoint" })
vim.api.nvim_set_keymap(
	"n",
	"<Leader>B",
	'<Cmd>lua require"dap".map_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>',
	{ silent = true, desc = "Debug: conditional breakpoint" }
)
vim.api.nvim_set_keymap(
	"n",
	"<Leader>lp",
	'<Cmd>lua require"dap".map_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>',
	{ silent = true, desc = "Debug: log point" }
)
vim.api.nvim_set_keymap("n", "<Leader>dr", '<Cmd>lua require"dap".repl.open()<CR>', { silent = true, desc = "Debug: open REPL" })
vim.api.nvim_set_keymap("n", "<Leader>dl", '<Cmd>lua require"dap".run_last()<CR>', { silent = true, desc = "Debug: run last" })
vim.api.nvim_set_keymap(
	"n",
	"<Leader>ss",
	'<Cmd>lua require"sg.extensions.telescope".fuzzy_search_result()<CR>',
	{ silent = false, desc = "Sourcegraph: fuzzy search result" }
)
local colorscheme_picker = require("config/color_scheme_picker")

vim.keymap.set("n", "<leader>cs", colorscheme_picker.open, {
	desc = "Colorscheme picker",
})

-- Toggle Right-to-Left (RTL) mode for the active window
vim.keymap.set("n", "<leader>rl", function()
	vim.wo.rightleft = not vim.wo.rightleft
	vim.notify("Right-to-Left: " .. (vim.wo.rightleft and "ON" or "OFF"), vim.log.levels.INFO)
end, { desc = "Toggle Right-to-Left (RTL) mode" })
