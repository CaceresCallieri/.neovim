---@type LazySpec
return {
	"mikavilpas/yazi.nvim",
	event = "VeryLazy",
	dependencies = { "folke/snacks.nvim", lazy = true },
	keys = {
		{
			"<leader>ey",
			mode = { "n", "v" },
			"<cmd>Yazi<cr>",
			desc = "Open yazi at the current file",
		},
		-- Shortcut for yazi
		{
			"<A-y>",
			mode = { "n", "v" },
			"<cmd>Yazi<cr>",
			desc = "Open yazi at the current file",
		},
		{
			-- Open in the current working directory
			"<leader>eY",
			"<cmd>Yazi cwd<cr>",
			desc = "Open the file manager in nvim's working directory",
		},
		-- {
		-- 	"<c-up>",
		-- 	"<cmd>Yazi toggle<cr>",
		-- 	desc = "Resume the last yazi session",
		-- },
	},
	---@type YaziConfig | {}
	opts = {
		-- if you want to open yazi instead of netrw, see below for more info
		open_for_directories = false,
		keymaps = {
			show_help = "<f1>",
			open_file_in_vertical_split = "<c-v>",
			open_file_in_horizontal_split = "<c-h>",
			open_file_in_tab = "<c-t>",
			grep_in_directory = "<c-s>",
			replace_in_directory = "<c-g>",
			cycle_open_buffers = "<tab>",
			copy_relative_path_to_selected_files = "<c-y>",
			send_to_quickfix_list = "<c-q>",
			change_working_directory = "<c-\\>",
			-- TODO: Quit with esc key
		},
	},
	-- 👇 if you use `open_for_directories=true`, this is recommended
	init = function()
		-- More details: https://github.com/mikavilpas/yazi.nvim/issues/802
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1
	end,
}
