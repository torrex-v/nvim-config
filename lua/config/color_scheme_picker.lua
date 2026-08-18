local M = {}

function M.open()
	---------------------------------------------------------------------------
	-- State
	---------------------------------------------------------------------------

	local schemes = vim.fn.getcompletion("", "color")

	if #schemes == 0 then
		vim.notify("No colorschemes found", vim.log.levels.WARN)
		return
	end

	local original_scheme = vim.g.colors_name
	local transparent = false

	local filtered = schemes
	local selected = 1

	---------------------------------------------------------------------------
	-- Buffers
	---------------------------------------------------------------------------

	local list_buf = vim.api.nvim_create_buf(false, true)
	local search_buf = vim.api.nvim_create_buf(false, true)

	for _, buf in ipairs({ list_buf, search_buf }) do
		vim.bo[buf].buftype = "nofile"
		vim.bo[buf].bufhidden = "wipe"
		vim.bo[buf].swapfile = false
		vim.bo[buf].modifiable = true
	end

	---------------------------------------------------------------------------
	-- Window
	---------------------------------------------------------------------------

	local ui = vim.api.nvim_list_uis()[1]

	local width = 45
	local height = 15

	local row = math.floor((ui.height - height) / 2)
	local col = math.floor((ui.width - width) / 2)

	---------------------------------------------------------------------------
	-- Search window
	---------------------------------------------------------------------------

	local search_win = vim.api.nvim_open_win(search_buf, false, {
		relative = "editor",
		row = row,
		col = col,
		width = width,
		height = 1,

		style = "minimal",

		border = {
			"╭",
			"─",
			"┬",
			"│",
			"╯",
			"─",
			"╰",
			"│",
		},

		title = " Search ",
		title_pos = "center",
	})

	---------------------------------------------------------------------------
	-- List window
	---------------------------------------------------------------------------

	local list_win = vim.api.nvim_open_win(list_buf, true, {
		relative = "editor",
		row = row + 2,
		col = col,
		width = width,
		height = height,

		style = "minimal",

		border = "rounded",

		title = " Colorschemes ",
		title_pos = "center",
	})

	---------------------------------------------------------------------------
	-- Search
	---------------------------------------------------------------------------

	local function fuzzy_match(text, pattern)
		text = text:lower()
		pattern = pattern:lower()

		if pattern == "" then
			return true
		end

		local position = 1

		for i = 1, #text do
			if text:sub(i, i) == pattern:sub(position, position) then
				position = position + 1

				if position > #pattern then
					return true
				end
			end
		end

		return false
	end

	local function update_filter()
		local query = vim.api.nvim_buf_get_lines(search_buf, 0, 1, false)[1] or ""

		filtered = {}

		for _, scheme in ipairs(schemes) do
			if fuzzy_match(scheme, query) then
				table.insert(filtered, scheme)
			end
		end

		selected = 1
	end

	---------------------------------------------------------------------------
	-- Apply colorscheme
	---------------------------------------------------------------------------

	local function apply_scheme()
		if #filtered == 0 then
			return
		end

		ColorMyPencils(filtered[selected], transparent)
	end

	---------------------------------------------------------------------------
	-- Draw list
	---------------------------------------------------------------------------

	local function redraw()
		local lines = {}

		if #filtered == 0 then
			table.insert(lines, "")
			table.insert(lines, "  No colorschemes found")
		else
			for i, scheme in ipairs(filtered) do
				if i == selected then
					table.insert(lines, "  → " .. scheme)
				else
					table.insert(lines, "    " .. scheme)
				end
			end
		end

		table.insert(lines, "")
		table.insert(lines, "  t  Background: " .. (transparent and "Transparent" or "Normal"))

		table.insert(lines, "  /  Search     Enter  Select     Esc  Cancel")

		vim.api.nvim_buf_set_lines(list_buf, 0, -1, false, lines)

		if #filtered > 0 then
			vim.api.nvim_win_set_cursor(list_win, { selected, 0 })
		end
	end

	---------------------------------------------------------------------------
	-- Preview
	---------------------------------------------------------------------------

	local function preview()
		update_filter()
		apply_scheme()
		redraw()
	end

	---------------------------------------------------------------------------
	-- Move
	---------------------------------------------------------------------------

	local function move_down()
		if #filtered == 0 then
			return
		end

		selected = selected + 1

		if selected > #filtered then
			selected = 1
		end

		apply_scheme()
		redraw()
	end

	local function move_up()
		if #filtered == 0 then
			return
		end

		selected = selected - 1

		if selected < 1 then
			selected = #filtered
		end

		apply_scheme()
		redraw()
	end

	---------------------------------------------------------------------------
	-- Transparency
	---------------------------------------------------------------------------

	local function toggle_transparent()
		transparent = not transparent

		apply_scheme()
		redraw()
	end

	---------------------------------------------------------------------------
	-- Close
	---------------------------------------------------------------------------

	local function close(restore)
		if restore and original_scheme then
			ColorMyPencils(original_scheme, false)
		end

		if vim.api.nvim_win_is_valid(search_win) then
			vim.api.nvim_win_close(search_win, true)
		end

		if vim.api.nvim_win_is_valid(list_win) then
			vim.api.nvim_win_close(list_win, true)
		end
	end

	---------------------------------------------------------------------------
	-- Search mode
	---------------------------------------------------------------------------

	local function enter_search()
		vim.api.nvim_set_current_win(search_win)

		vim.cmd("startinsert")
	end

	local function leave_search()
		vim.cmd("stopinsert")

		vim.api.nvim_set_current_win(list_win)

		redraw()
	end

	---------------------------------------------------------------------------
	-- Search changes
	---------------------------------------------------------------------------

	vim.api.nvim_create_autocmd("TextChangedI", {
		buffer = search_buf,

		callback = function()
			update_filter()

			apply_scheme()
			redraw()
		end,
	})

	vim.api.nvim_create_autocmd("TextChanged", {
		buffer = search_buf,

		callback = function()
			update_filter()

			apply_scheme()
			redraw()
		end,
	})

	---------------------------------------------------------------------------
	-- List keymaps
	---------------------------------------------------------------------------

	local list_opts = {
		buffer = list_buf,
		silent = true,
		noremap = true,
	}

	vim.keymap.set("n", "j", move_down, list_opts)
	vim.keymap.set("n", "k", move_up, list_opts)

	vim.keymap.set("n", "<Down>", move_down, list_opts)
	vim.keymap.set("n", "<Up>", move_up, list_opts)

	vim.keymap.set("n", "t", toggle_transparent, list_opts)

	vim.keymap.set("n", "/", enter_search, list_opts)

	vim.keymap.set("n", "<CR>", function()
		close(false)
	end, list_opts)

	vim.keymap.set("n", "q", function()
		close(true)
	end, list_opts)

	vim.keymap.set("n", "<Esc>", function()
		close(true)
	end, list_opts)

	---------------------------------------------------------------------------
	-- Search keymaps
	---------------------------------------------------------------------------

	local search_opts = {
		buffer = search_buf,
		silent = true,
		noremap = true,
	}

	vim.keymap.set("i", "<Esc>", leave_search, search_opts)

	vim.keymap.set("i", "<CR>", leave_search, search_opts)

	vim.keymap.set("i", "<Down>", function()
		vim.cmd("stopinsert")
		vim.api.nvim_set_current_win(list_win)
		move_down()
	end, search_opts)

	vim.keymap.set("i", "<Up>", function()
		vim.cmd("stopinsert")
		vim.api.nvim_set_current_win(list_win)
		move_up()
	end, search_opts)

	---------------------------------------------------------------------------
	-- Initial render
	---------------------------------------------------------------------------

	vim.api.nvim_buf_set_lines(search_buf, 0, -1, false, { "" })

	preview()

	-- IMPORTANT:
	-- Start with the LIST focused, not the search box.
	vim.api.nvim_set_current_win(list_win)
end

return M
