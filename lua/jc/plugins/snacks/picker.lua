-- snacks.picker
return {
	"folke/snacks.nvim",
	lazy = false,
	priority = 1000,
	-- TODO: Set vim.ui.select to use snacks picker
	opts = {
		picker = {
			sources = {
				files = {
					hidden = true, -- Show hidden files
					follow = true, -- Follow symlinks
				},
			},
			win = {
				input = {
					keys = {
						["<c-q>"] = "close",
					},
				},
				list = {
					keys = {
						-- ["<C-d>"] = "delete_buffer", -- TODO: Investigate correct implementation
					},
				},
			},
		},
	},
	keys = {
		{
			"<leader>ff",
			function()
				Snacks.picker.files()
			end,
			desc = "Smart Find Files",
		},
		{
			"<c-f>",
			function()
				Snacks.picker.files()
			end,
			desc = "Smart Find Files - Shortcut",
		},
		{
			"<leader>fs",
			function()
				Snacks.picker.smart()
			end,
			desc = "Smart Search",
		},
		{
			"<leader>fb",
			function()
				Snacks.picker.buffers()
			end,
			desc = "Buffers",
		},
		{
			"<c-b>",
			function()
				Snacks.picker.buffers()
			end,
			desc = "Buffers - Shortcut",
		},
		{
			"<leader>fg",
			function()
				Snacks.picker.grep()
			end,
			desc = "Smart Live Grep",
		},
		{
			"<leader>fy",
			function()
				Snacks.picker.registers()
			end,
			desc = "Smart Registers",
		},
		{
			"<leader>fm",
			function()
				Snacks.picker.marks()
			end,
			desc = "Marks",
		},
		{
			"<leader>fd",
			function()
				Snacks.picker.diagnostics()
			end,
			desc = "Diagnostics",
		},
		-- TODO: Add todos finder
	},
}
