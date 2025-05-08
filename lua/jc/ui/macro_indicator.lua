-- Define a namespace and store the window/buffer handles
local ns_id = vim.api.nvim_create_namespace("macro_indicator")
local macro_win = nil
local macro_buf = nil

-- Function to show the floating window
local function show_macro_indicator(reg)
	-- If it already exists, do nothing
	if macro_win and vim.api.nvim_win_is_valid(macro_win) then
		return
	end

	macro_buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_buf_set_lines(macro_buf, 0, -1, false, { "Recording @" .. reg })

	macro_win = vim.api.nvim_open_win(macro_buf, false, {
		relative = "editor",
		width = 20,
		height = 1,
		row = 0, -- vim.o.lines to get the height of the editor
		col = vim.o.columns - (vim.o.columns / 2) - 10,
		style = "minimal",
		border = "rounded",
		noautocmd = true,
	})
end

-- Function to close the floating window
local function hide_macro_indicator()
	if macro_win and vim.api.nvim_win_is_valid(macro_win) then
		vim.api.nvim_win_close(macro_win, true)
		macro_win = nil
		macro_buf = nil
	end
end

-- Autocommands to trigger on macro recording
vim.api.nvim_create_autocmd("RecordingEnter", {
	callback = function()
		local reg = vim.fn.reg_recording()
		vim.defer_fn(function()
			show_macro_indicator(reg)
		end, 20) -- slight delay avoids race condition
	end,
})

vim.api.nvim_create_autocmd("RecordingLeave", {
	callback = function()
		hide_macro_indicator()
	end,
})
