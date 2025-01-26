return {
	"nvim-tree/nvim-web-devicons",
	config = function()
		require("nvim-web-devicons").setup({
			override = {
				kbd = {
					name = "kbd",
					icon = "󰌌",
					color = "#33dd88",
				},
			},
		})
	end,
}
