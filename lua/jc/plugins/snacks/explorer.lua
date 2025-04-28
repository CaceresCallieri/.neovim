return {
	"folke/snacks.nvim",
	---@type snacks.Config
	opts = {
		explorer = {
			-- your explorer configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
			replace_netrw = true,
		},
		picker = {
			sources = {
				explorer = {
					-- your explorer picker configuration comes here
					-- or leave it empty to use the default settings
				},
			},
		},
	},
	keys = {
		{
			"<leader>es",
			function()
				Snacks.explorer.open()
			end,
			desc = "Snacks Explorer",
		},
	},
}
