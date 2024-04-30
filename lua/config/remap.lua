vim.g.mapleader = " "
--vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
            local opts = { noremap = true, silent = true }
            opts.desc = "Last buffer"
vim.keymap.set("n", "<leader>[",":bprevious<CR>",opts)
opts.desc = "Next buffer"
vim.keymap.set("n", "<leader>]",":bnext<CR>",opts)
vim.keymap.set("n", "<leader>pv",":Neotree filesystem reveal left toggle<CR>")
vim.keymap.set("n", "<leader>pvb",":Neotree buffers float<CR>")
vim.keymap.set("n", "<leader>pvg",":Neotree git_status float <CR>")

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("n", "<leader>vwm", function()
    require("vim-with-me").StartVimWithMe()
end)
vim.keymap.set("n", "<leader>svwm", function()
    require("vim-with-me").StopVimWithMe()
end)

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
vim.keymap.set("n", "<leader>pp", [["+p]])

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set("n", "<leader>vpp", "<cmd>e ~/AppData/Local/nvim/lua/thepayman/lazy.lua<CR>");
vim.keymap.set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>");

vim.keymap.set("n", "gpd", "<cmd>lua require('goto-preview').goto_preview_definition()<CR>")
vim.keymap.set("n", "gpt", "<cmd>lua require('goto-preview').goto_preview_type_definition()<CR>")
vim.keymap.set("n", "gpi", "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>")
vim.keymap.set("n", "gP", "<cmd>lua require('goto-preview').close_all_win()<CR>")
vim.keymap.set("n", "gpr", "<cmd>lua require('goto-preview').goto_preview_references()<CR>")

vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)

vim.api.nvim_set_keymap('n', '<F5>', '<Cmd>lua require"dap".continue()<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<F10>', '<Cmd>lua require"dap".step_over()<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<F11>', '<Cmd>lua require"dap".step_into()<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<F12>', '<Cmd>lua require"dap".step_out()<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<Leader>b', '<Cmd>lua require"dap".toggle_breakpoint()<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<Leader>B',
    '<Cmd>lua require"dap".set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<Leader>lp',
    '<Cmd>lua require"dap".set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<Leader>dr', '<Cmd>lua require"dap".repl.open()<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<Leader>dl', '<Cmd>lua require"dap".run_last()<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<Leader>ss', '<Cmd>lua require"sg.extensions.telescope".fuzzy_search_result()<CR>',
    { silent = false })
