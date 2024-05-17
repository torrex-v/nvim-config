return
{
    { "nvim-lua/popup.nvim" },
    { "nvim-neotest/nvim-nio" },
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
            "leoluz/nvim-dap-go",
            "theHamsta/nvim-dap-virtual-text",
            "nvim-neotest/nvim-nio",
            "williamboman/mason.nvim",
        },
        config = function()
            local dap, dapui = require("dap"), require("dapui")

            require("dapui").setup()
            require("dap-go").setup()

            require("nvim-dap-virtual-text").setup {
                -- This just tries to mitigate the chance that I leak tokens here. Probably won't stop it from happening...
                display_callback = function(variable)
                    local name = string.lower(variable.name)
                    local value = string.lower(variable.value)
                    if name:match "secret" or name:match "api" or value:match "secret" or value:match "api" then
                        return "*****"
                    end

                    if #variable.value > 15 then
                        return " " .. string.sub(variable.value, 1, 15) .. "... "
                    end

                    return " " .. variable.value
                end,
            }
            local elixir_ls_debugger = vim.fn.exepath "elixir-ls-debugger"
            if elixir_ls_debugger ~= "" then
                dap.adapters.mix_task = {
                    type = "executable",
                    command = elixir_ls_debugger,
                }

                dap.configurations.elixir = {
                    {
                        type = "mix_task",
                        name = "phoenix server",
                        task = "phx.server",
                        request = "launch",
                        projectDir = "${workspaceFolder}",
                        exitAfterTaskReturns = false,
                        debugAutoInterpretAllModules = false,
                    },
                }
            end

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

            vim.keymap.set('n', '<F5>', dap.continue, {})
            vim.keymap.set('n', '<F10>', dap.step_over, { silent = true })
            vim.keymap.set('n', '<F11>', dap.step_into, { silent = true })
            vim.keymap.set('n', '<F12>', dap.step_out, { silent = true })
            vim.keymap.set('n', '<Leader>b', dap.toggle_breakpoint, { silent = true })
            -- vim.keymap.set('n', '<Leader>B', dap.set_breakpoint(vim.fn.input("Breakpoint condition: ")),
            --     { silent = true })
            -- vim.keymap.set('n', '<Leader>lp', dap.set_breakpoin(vim.fn.input("Log point message: ")), { silent = true })
            vim.keymap.set('n', '<Leader>dr', dap.repl.open, { silent = true })
            vim.keymap.set('n', '<Leader>dl', dap.run_last, { silent = true })

            vim.keymap.set("n", "<space>b", dap.toggle_breakpoint)
            vim.keymap.set("n", "<space>gb", dap.run_to_cursor)
            vim.keymap.set("n", "<space>?", function()
                require("dapui").eval(nil, { enter = true })
            end)
        end
    }
}
