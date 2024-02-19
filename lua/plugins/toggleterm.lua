return {
    {
        'akinsho/toggleterm.nvim',
        version = "*",
        config = function()
            require 'toggleterm'.setup {
                persist_size = false,
                shade_terminals = true,
                open_mapping = [[<c-\>]],
                start_in_insert = true,
                insert_mappings = true, -- whether or not the open mapping applies in insert mode
                terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
                persist_mode = true, -- if set to true (default) the previous terminal mode will be remembered
                close_on_exit = true, -- close the terminal window when the process exits
                auto_scroll = true, direction = 'float',
            }
            local Terminal = require('toggleterm.terminal').Terminal
            local lazygit  = Terminal:new({ cmd = "lazygit", hidden = true })

            function _lazygit_toggle()
                lazygit:toggle()
            end

            vim.api.nvim_set_keymap("n", "<leader>lg", "<cmd>lua _lazygit_toggle()<CR>", { noremap = true, silent = true })
        end
    }
}
