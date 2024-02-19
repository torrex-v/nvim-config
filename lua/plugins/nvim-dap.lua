return
{
    { "nvim-lua/popup.nvim" },
    { "nvim-lua/plenary.nvim" },
    {
        "tomblind/local-lua-debugger-vscode",
        config = function()
        end
    },
    {
        'mfussenegger/nvim-dap',
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "leoluz/nvim-dap-go",
        "tomblind/local-lua-debugger-vscode",
        },
        config = function()
            local dap, dapui = require("dap"), require("dapui")

            dapui.setup({
                icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
                mappings = {
                    -- Use a table to apply multiple mappings
                    expand = { "<CR>", "<2-LeftMouse>" },
                    open = "o",
                    remove = "d",
                    edit = "e",
                    repl = "r",
                    toggle = "t",
                },
                element_mappings = {

                },

                expand_lines = vim.fn.has("nvim-0.7") == 1,

                layouts = {
                    {
                        elements = {
                            -- Elements can be strings or table with id and size keys.
                            { id = "scopes", size = 0.25 },
                            "breakpoints",
                            "stacks",
                            "watches",
                        },
                        size = 40, -- 40 columns
                        position = "left",
                    },
                    {
                        elements = {
                            "repl",
                            "console",
                        },
                        size = 0.25, -- 25% of total lines
                        position = "bottom",
                    },
                },
                controls = {
                    -- Requires Neovim nightly (or 0.8 when released)
                    enabled = true,
                    -- Display controls in this element
                    element = "repl",
                    icons = {
                        pause = "",
                        play = "",
                        step_into = "",
                        step_over = "",
                        step_out = "",
                        step_back = "",
                        run_last = "↻",
                        terminate = "□",
                    },
                },
                floating = {
                    max_height = nil,  -- These can be integers or a float between 0 and 1.
                    max_width = nil,   -- Floats will be treated as percentage of your screen.
                    border = "single", -- Border style. Can be "single", "double" or "rounded"
                    mappings = {
                        close = { "q", "<Esc>" },
                    },
                },
                windows = { indent = 1 },
                render = {
                    max_type_length = nil, -- Can be integer or nil.
                    max_value_lines = 100, -- Can be integer or nil.
                }
            })

            -- lua
            dap.adapters["local-lua"] = {
                type = "executable",
                command = "node",
                args = {
                    "~/AppData/Local/nvim-data/lazy/local-lua-debugger-vscode/extension/debugAdapter.js"
                },
                enrich_config = function(config, on_config)
                    if not config["extensionPath"] then
                        local c = vim.deepcopy(config)
                        c.extensionPath = "~/AppData/Local/nvim-data/lazy/local-lua-debugger-vscode/"
                        on_config(c)
                    else
                        on_config(config)
                    end
                end,
            }
            dap.configurations.lua = {
                {
                    name = 'Current file (local-lua-dbg, lua)',
                    type = 'local-lua',
                    request = 'launch',
                    cwd = '${workspaceFolder}',
                    program = {
                        lua = 'lua5.1',
                        file = '${file}',
                    },
                    args = {},
                },
            }
            -- csharp
            dap.adapters.coreclr = {
                type = 'executable',
                command = 'C:/tools/netcoredbg/netcoredbg.exe',
                args = { '--interpreter=vscode' }
            }

            dap.configurations.cs = {
                {
                    type = "coreclr",
                    name = "launch - netcoredbg",
                    request = "launch",
                    program = function()
                        return vim.fn.input('Path to dll', vim.fn.getcwd() .. '/bin/Debug/', 'file')
                    end,
                },
            }

            require("dapui").setup()
            require("dap-go").setup()
--keymaps
            dap.listeners.before.attach.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.launch.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated.dapui_config = function()
                dapui.close()
            end
            dap.listeners.before.event_exited.dapui_config = function()
                dapui.close()
            end

            vim.keymap.set('n', '<F5>', dap.continue,{})
            vim.keymap.set('n', '<F10>', dap.step_over, { silent = true })
            vim.keymap.set('n', '<F11>', dap.step_into, { silent = true })
            vim.keymap.set('n', '<F12>', dap.step_out, { silent = true })
            vim.keymap.set('n', '<Leader>b', dap.toggle_breakpoint, { silent = true })
            -- vim.keymap.set('n', '<Leader>B', dap.set_breakpoint(vim.fn.input("Breakpoint condition: ")),
            --     { silent = true })
            -- vim.keymap.set('n', '<Leader>lp', dap.set_breakpoin(vim.fn.input("Log point message: ")), { silent = true })
            vim.keymap.set('n', '<Leader>dr', dap.repl.open, { silent = true })
            vim.keymap.set('n', '<Leader>dl', dap.run_last, { silent = true })
        end
    }
}
