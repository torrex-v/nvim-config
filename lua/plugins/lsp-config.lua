return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },
{ "nvim-neotest/nvim-nio" },
    {
        "williamboman/mason-lspconfig.nvim",
        lazy = false,
        opts = {
            auto_install = true,
        }
        -- config = function()
        --     require("mason-lspconfig").setup({
        --         ensure_installed = { "lua_ls", "tsserver", "csharp_ls" },
        --     })
        -- end,
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            { "antosha417/nvim-lsp-file-operations", config = true },
            'hrsh7th/nvim-cmp',
        },
        lazy = false,
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            local lspconfig = require("lspconfig")
            local capabilities = require("cmp_nvim_lsp").default_capabilities();

            local on_attach2 = function(client)
                require("completion").on_attach(client)
            end
            local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
            for type, icon in pairs(signs) do
                local hl = "DiagnosticSign" .. type
                vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
            end
            local opts = { noremap = true, silent = true }
            local on_attach = function(client, bufnr)
                opts.buffer = bufnr
                -- set keybinds
                opts.desc = "Show LSP references"
                vim.keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

                opts.desc = "Go to declaration"
                vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

                opts.desc = "Show LSP definitions"
                vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

                opts.desc = "Show LSP implementations"
                vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

                opts.desc = "Show LSP type definitions"
                vim.keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

                opts.desc = "See available code actions"
                vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

                opts.desc = "Smart rename"
                vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

                opts.desc = "Show buffer diagnostics"
                vim.keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

                opts.desc = "Show line diagnostics"
                vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

                opts.desc = "Go to previous diagnostic"
                vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

                opts.desc = "Go to next diagnostic"
                vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

                opts.desc = "Show documentation for what is under cursor"
                vim.keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

                opts.desc = "Restart LSP"
                vim.keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary


                vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
                vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa',
                    '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>',
                    opts)
                vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr',
                    '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>',
                    opts)
                vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl',
                    '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
                vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
                vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
                vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
                vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
                vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
                vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
                vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
                vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
            end

            require("sg").setup({
                on_attach = on_attach
            })
            lspconfig.jsonls.setup({
                on_attach = on_attach,
                capabilities = capabilities,
                settings = {
                    json = {
                        schemas = {
                            {
                                fileMatch = { ".prettierrc", "package.json" },
                                url = "https://json.schemastore.org/prettierrc",
                            },
                            {
                                fileMatch = { "package.json" },
                                url = "https://json.schemastore.org/package",
                            },
                            {
                                fileMatch = { ".eslintrc", ".eslintrc.json", ".eslintrc.yaml", ".eslintrc.yml" },
                                url = "https://json.schemastore.org/eslintrc",
                            },
                            {
                                fileMatch = { ".stylelintrc", ".stylelintrc.json", ".stylelintrc.yaml", ".stylelintrc.yml" },
                                url = "https://json.schemastore.org/stylelintrc",
                            },
                            {
                                fileMatch = { ".prettierrc", ".prettierrc.json", ".prettierrc.yaml", ".prettierrc.yml" },
                                url = "https://json.schemastore.org/prettierrc",
                            },
                        }
                    }
                }
            });
            lspconfig.rust_analyzer.setup({
                on_attach = on_attach,
                settings = {
                    ["rust-analyzer"] = {
                        imports = {
                            granularity = {
                                group = "module",
                            },
                            prefix = "self",
                        },
                        cargo = {
                            buildScripts = {
                                enable = true,
                            },
                        },
                        procMacro = {
                            enable = true,
                        },
                    },
                },
            })
            -- lspconfig.csharp_ls.setup({
            --     on_attach = on_attach,
            --     capabilities = capabilities
            -- })
lspconfig.clangd.setup{
    capabilities = capabilities,
    on_attach = on_attach,
}
            lspconfig.lua_ls.setup({
                capabilities = capabilities,
                on_attach = on_attach,
            })
            capabilities.textDocument.completion.completionItem.snippetSupport = true
            require 'lspconfig'.html.setup({
                capabilities = capabilities
            })
            require 'lspconfig'.eslint.setup {}
            lspconfig.eslint.setup({
                --- ...
                on_attach = function(client, bufnr)
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        buffer = bufnr,
                        command = "EslintFixAll",
                    })
                end,
            })
            lspconfig.html.setup({
                on_attach = on_attach,
                capabilities = capabilities,
                cmd = { "vscode-html-language-server", "--stdio" },
                filetypes = { "html" },
                init_options = {
                    configurationSection = { "html", "css", "javascript" },
                    embeddedLanguages = {
                        css = true,
                        javascript = true
                    }
                },
            })

            lspconfig.tsserver.setup {}
            -- configure typescript server with plugin
            lspconfig.tsserver.setup({
                capabilities = capabilities,
                on_attach = on_attach,
            })

            lspconfig.pyright.setup {
                capabilities = capabilities,
                on_attach = on_attach,
            }

            -- configure css server
            lspconfig.cssls.setup({
                capabilities = capabilities,
                on_attach = on_attach,
            })

            -- configure tailwindcss server
            lspconfig.tailwindcss.setup({
                capabilities = capabilities,
                on_attach = on_attach,
            })

            -- configure svelte server
            lspconfig.svelte.setup({
                capabilities = capabilities,
                on_attach = function(client, bufnr)
                    on_attach(client, bufnr)

                    vim.api.nvim_create_autocmd("BufWritePost", {
                        pattern = { "*.js", "*.ts" },
                        callback = function(ctx)
                            if client.name == "svelte" then
                                client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.file })
                            end
                        end,
                    })
                end,
            })

            local pid = vim.fn.getpid()
            local os_capabilities =
                require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
            lspconfig.omnisharp.setup({
                cmd = { "omnisharp", "--languageserver", "--hostPID", tostring(pid) },
                capabilities = capabilities,
                on_attach = on_attach,
            })
            --configure slint-lsp
            require 'lspconfig'.slint_lsp.setup { {
                capabilities = capabilities,
                on_attach = on_attach
            } }

            require 'lspconfig'.htmx.setup { {
                capabilities = capabilities,
                on_attach = on_attach
            } }

            require 'lspconfig'.intelephense.setup { {
                capabilities = capabilities,
                on_attach = on_attach
            } }

            --
            vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
            vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
            vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
            vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

            -- vim.api.nvim_create_autocmd("LspAttach", {
            --     group = vim.api.nvim_create_augroup("UserLspConfig", {}),
            --     callback = function(ev)
            --         -- Enable completion triggered by <c-x><c-o>
            --         vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
            --
            --         -- Buffer local mappings.
            --         -- See `:help vim.lsp.*` for documentation on any of the below functions
            --         local opts = { buffer = ev.buf }
            --         vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
            --         vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
            --         vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
            --         vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
            --         vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
            --         vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
            --         vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
            --         vim.keymap.set("n", "<space>wl", function()
            --             print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            --         end, opts)
            --         vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
            --         vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
            --         vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
            --         vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
            --         vim.keymap.set("n", "<space>f", function()
            --             vim.lsp.buf.format({ async = true })
            --         end, opts)
            --     end,
            -- })
        end,
    },
}
