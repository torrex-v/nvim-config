return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"folke/neodev.nvim",
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			{ "j-hui/fidget.nvim", opts = {} },
			-- Autoformatting
			"stevearc/conform.nvim",
			-- Schema information
			"b0o/SchemaStore.nvim",
			"hrsh7th/cmp-buffer", -- source for text in buffer
		},
		lazy = false,
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("neodev").setup({
				-- library = {
				--   plugins = { "nvim-dap-ui" },
				--   types = true,
				-- },
			})

			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			if pcall(require, "cmp_nvim_lsp") then
				capabilities = require("cmp_nvim_lsp").default_capabilities()
			end
			local lspconfig = require("lspconfig")
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
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
				vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)

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

				vim.keymap.set("n", "<leader>vws", function()
					vim.lsp.buf.workspace_symbol()
				end, opts)

				vim.keymap.set("n", "<leader>wa", function()
					vim.lsp.buf.add_workspace_folder()
				end, opts)
				vim.keymap.set("n", "<leader>wr", function()
					vim.lsp.buf.remove_workspace_folder()
				end, opts)
				vim.keymap.set("n", "<leader>wl", function()
					vim.lsp.buf.list_workspace_folders()
				end, opts)

				vim.keymap.set("n", "<leader>vd", function()
					vim.diagnostic.open_float()
				end, opts)
				vim.keymap.set("n", "<leader>vca", function()
					vim.lsp.buf.code_action()
				end, opts)
				vim.keymap.set("n", "<leader>vrr", function()
					vim.lsp.buf.references()
				end, opts)
				vim.keymap.set("n", "<leader>vrn", function()
					vim.lsp.buf.rename()
				end, opts)
				vim.keymap.set("i", "<C-h>", function()
					vim.lsp.buf.signature_help()
				end, opts)
				vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
			end

			capabilities.textDocument.completion.completionItem.snippetSupport = true

			local pid = vim.fn.getpid()
			local os_capabilities =
				require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
			local servers = {
				bashls = true,
				gopls = true,
				lua_ls = true,
				eslint = {
					on_attach = function(client, bufnr)
						vim.api.nvim_create_autocmd("BufWritePre", {
							buffer = bufnr,
							command = "EslintFixAll",
						})
					end,
				},
				-- rust_analyzer = {
				-- 	settings = {
				-- 		["rust-analyzer"] = {
				-- 			imports = {
				-- 				granularity = {
				-- 					group = "module",
				-- 				},
				-- 				prefix = "self",
				-- 			},
				-- 			cargo = {
				-- 				buildScripts = {
				-- 					enable = true,
				-- 				},
				-- 			},
				-- 			procMacro = {
				-- 				enable = true,
				-- 			},
				-- 		},
				-- 	},
				-- },
				rust_analyzer = true,
				svelte = {
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
				},
				templ = true,
				cssls = true,
				slint_lsp = {
					on_attach = function(client, bufnr)
						on_attach(client, bufnr)
						vim.cmd([[ autocmd BufRead,BufNewFile *.slint set filetype=slint ]])
						vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
							pattern = { "*.slint" },
							callback = function(ctx)
								if client.name == "slint_lsp" then
									client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.file })
								end
							end,
						})
					end,
				},
				htmx = true,
				html = {
					cmd = { "vscode-html-language-server", "--stdio" },
					filetypes = { "html" },
					init_options = {
						configurationSection = { "html", "css", "javascript" },
						embeddedLanguages = {
							css = true,
							javascript = true,
						},
					},
				},
				intelephense = true,
				pyright = true,
				omnisharp = { cmd = { "omnisharp", "--languageserver", "--hostPID", tostring(pid) } },
				ts_ls = true,
				tailwindcss = true,
				csharp_ls = true,
				jsonls = {
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
									fileMatch = {
										".stylelintrc",
										".stylelintrc.json",
										".stylelintrc.yaml",
										".stylelintrc.yml",
									},
									url = "https://json.schemastore.org/stylelintrc",
								},
								{
									fileMatch = {
										".prettierrc",
										".prettierrc.json",
										".prettierrc.yaml",
										".prettierrc.yml",
									},
									url = "https://json.schemastore.org/prettierrc",
								},
								require("schemastore").json.schemas(),
								validate = { enable = true },
							},
						},
					},
				},
				yamlls = {
					settings = {
						yaml = {
							schemaStore = {
								enable = false,
								url = "",
							},
							schemas = require("schemastore").yaml.schemas(),
						},
					},
				},
				ocamllsp = {
					manual_install = true,
					settings = {
						codelens = { enable = true },
					},

					filetypes = {
						"ocaml",
						"ocaml.interface",
						"ocaml.menhir",
						"ocaml.cram",
					},

					-- TODO: Check if i still need the filtypes stuff i had before
				},

				-- lexical = {
				--     cmd = { "/home/tjdevries/.local/share/nvim/mason/bin/lexical", "server" },
				--     root_dir = require("lspconfig.util").root_pattern { "mix.exs" },
				-- },

				clangd = {
					-- TODO: Could include cmd, but not sure those were all relevant flags.
					--    looks like something i would have added while i was floundering
					init_options = { clangdFileStatus = true },
					filetypes = { "c" },
				},
			}

			local servers_to_install = vim.tbl_filter(function(key)
				local t = servers[key]
				if type(t) == "table" then
					return not t.manual_install
				else
					return t
				end
			end, vim.tbl_keys(servers))

			require("mason").setup()
			local ensure_installed = {
				"stylua",
				"lua_ls",
				-- "delve",
				-- "tailwind-language-server",
			}
			vim.list_extend(ensure_installed, servers_to_install)
			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

			for name, config in pairs(servers) do
				if config == true then
					config = {}
				end
				config = vim.tbl_deep_extend("force", {}, {
					capabilities = capabilities,
					on_attach = on_attach,
				}, config)
				lspconfig[name].setup(config)
			end
			-- local servers = { 'tailwindcss', 'tsserver', 'jsonls', 'eslint' }
			-- for _, lsp in pairs(servers) do
			--   lspconfig[lsp].setup {
			--     on_attach = on_attach,
			--     capabilites = capabilities,
			--   }
			-- end
			--
			vim.keymap.set("n", "<space>e", vim.diagnostic.open_float)
			vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
			vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
			vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist)

			-- vim.api.nvim_create_autocmd("LspAttach", {
			--     group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			--     callback = function(ev)
			--         -- Enable completion triggered by <c-x><c-o>
			--         vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
			--
			--         -- Buffer local mappings.
			--         -- See `:help vim.lsp.*` for documentation on any of the below functions
			--         local opts = { buffer = ev.buf }
			--         vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
			--         vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
			--         vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
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
			require("conform").setup({
				formatters_by_ft = {
					lua = { "stylua" },
				},
			})

			vim.api.nvim_create_autocmd("BufWritePre", {
				callback = function(args)
					require("conform").format({
						bufnr = args.buf,
						lsp_fallback = true,
						quiet = true,
					})
				end,
			})
		end,
	},
}
