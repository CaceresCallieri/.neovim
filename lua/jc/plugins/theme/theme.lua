return {
	-- "cacerescallieri/wine_theme.nvim",
	name = "wine_theme",
	dir = "/home/jc/.config/nvim/lua/jc/plugins/theme/wine_theme",
	lazy = true,
	config = function()
		require("wine_theme").setup({
			vim.cmd("colorscheme wine_theme"),
		})
	end,
}
