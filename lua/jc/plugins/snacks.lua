return {
	"folke/snacks.nvim",
	---@type snacks.Config
	opts = {
		picker = {
			-- your picker configuration comes here
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
				Snacks.picker.smart()
			end,
			desc = "Smart Find Files",
		},
		{
			"<c-f>",
			function()
				Snacks.picker.smart()
			end,
			desc = "Smart Find Files - Shortcut",
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
