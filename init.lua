vim.g.mapleader = " "
vim.g.maplocalleader = " "

if vim.tbl_flatten then
	vim.tbl_flatten = function(t)
		local result = {}
		local function flatten(value)
			if type(value) == "table" then
				for _, child in ipairs(value) do
					flatten(child)
				end
			else
				result[#result + 1] = value
			end
		end
		flatten(t)
		return result
	end
end

if vim.islist then
	vim.tbl_islist = vim.islist
end

local ok, treesitter_language = pcall(require, "vim.treesitter.language")
if ok and not treesitter_language.ft_to_lang then
	treesitter_language.ft_to_lang = treesitter_language.get_lang
end
if vim.treesitter and vim.treesitter.language and not vim.treesitter.language.ft_to_lang then
	vim.treesitter.language.ft_to_lang = vim.treesitter.language.get_lang
		or (ok and treesitter_language.ft_to_lang)
end

require("config.pack").setup()

local ok_parsers, treesitter_parsers = pcall(require, "nvim-treesitter.parsers")
if ok_parsers and not treesitter_parsers.ft_to_lang then
	treesitter_parsers.ft_to_lang = function(ft)
		return vim.treesitter.language.get_lang(ft) or ft
	end
end
if ok_parsers and not treesitter_parsers.get_parser then
	treesitter_parsers.get_parser = vim.treesitter.get_parser
end

local ok_configs, treesitter_configs = pcall(require, "nvim-treesitter.configs")
if not ok_configs or type(treesitter_configs) ~= "table" then
	treesitter_configs = {}
	package.loaded["nvim-treesitter.configs"] = treesitter_configs
end
if not treesitter_configs.is_enabled then
	treesitter_configs.is_enabled = function()
		return true
	end
end
if not treesitter_configs.get_module then
	treesitter_configs.get_module = function(name)
		if name == "highlight" then
			return { additional_vim_regex_highlighting = false }
		end
		return {}
	end
end

require("config")
ColorMyPencils("tokyonight-night", true)
