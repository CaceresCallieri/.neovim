return {
	"dmtrKovalenko/fff.nvim",
	-- Build the Rust backend (downloads prebuilt binary or compiles from source)
	build = function()
		require("fff.download").download_or_build_binary()
	end,
	lazy = false, -- Plugin initializes itself lazily internally
	opts = {
		-- Enable debug mode to help diagnose any issues
		debug = {
			enabled = true,
			show_scores = true,
		},
	},
	-- Define keybindings using lazy.nvim's keys table
	keys = {
		-- Primary file finding shortcuts (replaces Telescope file finding)
		{
			"<C-f>",
			function()
				require("fff").find_files()
			end,
			desc = "FFF find files in current directory",
		},
		{
			"<leader>ff",
			function()
				require("fff").find_files()
			end,
			desc = "FFF find files in current directory",
		},
		-- Find files in git root
		{
			"<leader>fF",
			function()
				require("fff").find_in_git_root()
			end,
			desc = "FFF find files in git root",
		},
		-- Refresh file index manually if needed
		{
			"<leader>fr",
			function()
				require("fff").scan_files()
			end,
			desc = "FFF refresh file index",
		},
	},
}
