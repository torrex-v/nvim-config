return {

	{
		-- The "main" branch is a full rewrite: it only installs/updates parsers now.
		-- Highlighting, folding, etc. are enabled ourselves below via core `vim.treesitter`.
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		build = ":TSUpdate",
		config = function()
			local ok, treesitter = pcall(require, "nvim-treesitter")
			if not ok then
				return
			end

			-- Installing/compiling parsers needs the `tree-sitter` CLI plus a C compiler.
			-- Skip auto-install when they're missing so startup doesn't spam build errors;
			-- `:TSInstall <lang>` still works once they're available.
			local has_cc = vim.fn.executable("cc") == 1
				or vim.fn.executable("gcc") == 1
				or vim.fn.executable("clang") == 1
				or vim.fn.executable("cl") == 1
			if vim.fn.executable("tree-sitter") == 1 and has_cc then
				treesitter.install({
					"lua", "vim", "vimdoc", "query",
					"markdown", "markdown_inline",
					"bash", "regex", "diff",
					"json", "yaml", "toml",
					"html", "css", "javascript", "typescript", "tsx", "svelte",
					"python", "go", "rust", "c", "cpp", "c_sharp", "php", "ocaml", "ocaml_interface",
					"sql", "dockerfile", "gitignore", "gitcommit", "git_config",
				})
			end

			-- Highlighting is provided by core Neovim; nvim-treesitter only manages parsers now.
			vim.api.nvim_create_autocmd("FileType", {
				callback = function(args)
					if pcall(vim.treesitter.start, args.buf) then
						vim.wo[0][0].foldmethod = "expr"
						vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
					end
				end,
			})
		end,
	},
	{
		"windwp/nvim-ts-autotag",
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	},
	{ "nvim-treesitter/nvim-treesitter-context" },
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		lazy = false,
		config = function()
			require("nvim-treesitter-textobjects").setup({
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						["af"] = "@function.outer",
						["if"] = "@function.inner",
					},
				},
			})
		end,
	},
}
