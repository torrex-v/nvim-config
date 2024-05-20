local status_ok, bufferline = pcall(require, "bufferline")
if not status_ok then
	return
end
bufferline.setup({
	options = {
		numbers = "buffer_id",
		close_command = "bdelete! %d",
		right_mouse_command = "bdelete! %d",
		left_mouse_command = "buffer %d",
		middle_mouse_command = nil,
		indicator = {
			icon = "▎",
			style = "icon",
		},
		buffer_close_icon = "󰅖",
		modified_icon = "●",
		close_icon = "",
		left_trunc_marker = "",
		right_trunc_marker = "",
		max_name_length = 18,
		truncate_names = true, -- whether or not tab names should be truncated
		max_prefix_length = 15,
		tab_size = 18,
		diagnostics = "nvim_lsp",
		diagnostics_update_in_insert = false,
		offsets = {
			{
				filetype = "nvimtree",
				text = function()
					return vim.fn.getcwd()
				end,
				highlight = "directory",
				text_align = "left",
				separator = true,
				padding = 1,
			},
			{
				filetype = "neo-tree",
				text = function()
					return vim.fn.getcwd()
				end,
				highlight = "directory",
				text_align = "left",
				padding = 1,
			},
		},
		hover = {
			enabled = true,
			delay = 200,
			reveal = { "close" },
		},
		diagnostics_indicator = function(count, level)
			local icon = level:match("error") and " " or ""
			return " " .. icon .. count
		end,
		color_icons = true,
		show_buffer_icons = true,
		show_buffer_close_icons = true,
		show_close_icon = true,
		show_tab_indicators = true,
		persist_buffer_sort = true,
		separator = true,
		sort_by = "insert_after_current",
		separator_style = "padded_slant",
		enforce_regular_tabs = true,
		always_show_bufferline = true,
	},
})
